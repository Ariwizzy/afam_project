import 'package:afam_project/constant.dart';
import 'package:afam_project/model/db_model.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../db/db_helper.dart';
import '../widget/ads_code.dart';

class NewsDetails extends StatefulWidget {
  final String imageUrl, tittle, content, dateTime, minsRead;
  final int id,dbID;
  const NewsDetails(
      {Key key,
      this.imageUrl,
      this.tittle,
      this.content,
      this.id,
      this.dateTime,
      this.minsRead, this.dbID})
      : super(key: key);
  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  var dbHelper;
  List<DbModel> dbModel;
  BannerAd bannerAd;
  bool checkId = false;
  String elementId;
  @override
  void initState() {
    AppLovinMAX.showBanner(MaxCode().bannerAdUnitId);
    ads();
    dbHelper = DatabaseHelper();
    DatabaseHelper().fetchSavedQuotes().then((value) {
      dbModel = value;
      for (var element in dbModel) {
        elementId = element.newsId;
        if (element.newsId == widget.id.toString()) {
          setState(() {
            checkId = true;
          });
        }
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    AppLovinMAX.hideBanner(MaxCode().bannerAdUnitId);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print(checkId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          height: 40,
          child: Image.asset("images/fnst.png"),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                if(checkId){
                  DatabaseHelper().deleteQuoteFromFavorite(widget.dbID)
                      .then((value) {
                    setState(() {
                      checkId =!checkId;
                    });
                    toast(message: "Removed Successfully");
                  });
                } else if (elementId == widget.id.toString()) {
                  setState(() {
                    checkId = !checkId;
                  });
                  toast(message: "already bookmarked");
                }
                else{
                  setState(() {
                    elementId = widget.id.toString();
                    checkId = !checkId;
                  });
                  DbModel db = DbModel(
                    id: null,
                    tittle: widget.tittle,
                    dateTime: widget.dateTime,
                    content: widget.content,
                    imageUrl: widget.imageUrl,
                    minsRead: widget.minsRead,
                    newsId: widget.id.toString(),
                  );
                  dbHelper.saveQuote(db);
                  toast(message: "Bookmarked Successfully");
                }},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(checkId ? Icons.bookmark : Icons.bookmark_border),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.tittle,
                    style: GoogleFonts.ptSerif(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 2,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:  widget.imageUrl,
                        placeholder: (context, url) => Container(
                            height: 10,
                            child: Constant().spinKit),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                ),
                SizedBox(height: 5,),
                Constant().container(),
                SizedBox(height: 5,),
                HtmlWidget(
                  // the first parameter (`html`) is required
                  '''${widget.content} ''',
                  // all other parameters are optional, a few notable params:
                  // specify custom styling for an element
                  // see supported inline styling below
                  customStylesBuilder: (element) {
                    if (element.classes.contains('[Chorus]')) {
                      return {'color': 'red'};
                    }

                    return null;
                  },

                  // render a custom widget
                  customWidgetBuilder: (element) {
                    if (element.attributes['foo'] == 'bar') {
                      // return FooBarWidget();
                    }
                    return null;
                  },

                  // turn on selectable if required (it's disabled by default)
                  isSelectable: true,

                  // these callbacks are called when a complicated element is loading
                  // or failed to render allowing the app to render progress indicator
                  // and fallback widget
                  onErrorBuilder: (context, element, error) =>
                      Text('$element error: $error'),
                  onLoadingBuilder: (context, element, loadingProgress) =>
                      CircularProgressIndicator(),

                  // // this callback will be triggered when user taps a link
                  // onTapUrl: (url) => print('tapped $url'),

                  // select the render mode for HTML body
                  // by default, a simple `Column` is rendered
                  // consider using `ListView` or `SliverList` for better performance
                  renderMode: RenderMode.column,

                  // set the default styling for text
                  textStyle: TextStyle(fontSize: 14),

                  // turn on `webView` if you need IFRAME support (it's disabled by default)
                  webView: true,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 80,
          child: AdWidget(ad: bannerAd)),
    );
  }
  void toast({String message}){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xff3A4191),
        textColor: Colors.white,
        fontSize: 16.0);
  }
  void ads(){
    bannerAd = BannerAd(
      adUnitId: AdsCode().banner,
      size: AdSize.banner,
      request: AdRequest(keywords: Constant().adRequest),
      listener: BannerAdListener(onAdClosed: (ad) => ad.dispose()),
    );
    bannerAd.load();
  }
}

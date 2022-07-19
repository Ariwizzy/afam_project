import 'package:afam_project/db/db_helper.dart';
import 'package:afam_project/model/db_model.dart';
import 'package:afam_project/widget/news_widget.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import '../constant.dart';
import '../widget/ads_code.dart';
class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key key}) : super(key: key);

  @override
  _BookMarkScreenState createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  BannerAd bannerAd;
  @override
  void initState() {
    AppLovinMAX.showBanner(MaxCode().bannerAdUnitId);
    ads();
    super.initState();
  }
  @override
  void dispose() {
    AppLovinMAX.hideBanner(MaxCode().bannerAdUnitId);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Bookmarked",
            style: GoogleFonts.ptSerif(
              fontSize: 20,
              color: const Color(0xff3A4191),
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            )),
      ),
      body: FutureBuilder<List<DbModel>>(
        future: DatabaseHelper().fetchSavedQuotes(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return snapshot.data.isEmpty?
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Lottie.asset(
                  'images/notFound.json',
                  width: MediaQuery.of(context).size.width *0.9,
                  height: 230,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text("You don't have any bookmark yet, you can easily add news you want to read later to your bookmark ",style: GoogleFonts.ptSerif(
                    fontSize: 16,
                    letterSpacing: 0.5,
                    color: Colors.grey[800]
                  ),textAlign: TextAlign.center),
                ),
                Container(),
              ],
            ):
            SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: const  NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                      itemBuilder:(context, index) {
                    return Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),
                      endActionPane:  ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 4,
                            onPressed: (c) {
                              DatabaseHelper().deleteQuoteFromFavorite(snapshot.data[index].id).then((value) {
                                setState(() {

                                });
                              });
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.favorite,
                            label: 'remove',
                          ),
                        ],
                      ),
                      child:   NewsWidget(dbIndex: index,isDb: true,dbModel: snapshot.data,),
                    );
                  }),
                const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.0),
                  child:   Divider(thickness: 1),
                ),
                  Text("Swipe left to remove bookmark",style: GoogleFonts.ptSerif(
                      color: Colors.grey[600],
                      letterSpacing: 0.5
                  )),
                ],
              ),
            );
          }else if(snapshot.hasError){
            return const Center(child: Text("Something went wrong"),);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: AdWidget(ad: bannerAd)),
      );
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


import 'package:afam_project/Apis/api.dart';
import 'package:afam_project/Screens/news_details.dart';
import 'package:afam_project/constant.dart';
import 'package:afam_project/model/news_model.dart'as news;
import 'package:afam_project/model/search_modell.dart';
import 'package:html/parser.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reading_time/reading_time.dart';
class SearchScreen extends StatefulWidget {
  final String keyword;
  const SearchScreen({Key key, this.keyword}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
  TextEditingController searchController = TextEditingController();
  news.NewsModel newsModel;
  @override
  void initState() {
   searchController.text = widget.keyword;
    super.initState();
  }
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  SizedBox(
          height: 40,
          child: Image.asset("images/fnst.png"),
        ),
      ),
      body: isLoading? Constant().spinKit:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder<List<SearchModel>>(
          future: APi().search(data: searchController.text),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16,horizontal: 15),
                        enabledBorder:  OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderSide:   BorderSide(color: Colors.grey[900], width: 0.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        hintStyle: GoogleFonts.ptSerif(
                          color: Colors.grey[800],
                          letterSpacing: 0.5,
                        ),
                        hintText: "Search...",
                        fillColor: Colors.white70,
                        suffixIcon: GestureDetector(
                            onTap: (){
                              if(searchController.text.isEmpty){
                                 toast(message: "Search field is required");
                              }else{
                                print("ppp");
                                setState(() {
                                  isLoading = true;
                                });
                                APi().search(data: searchController.text).then((value) {
                                  print("yh");
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              }
                            },
                            child: const Padding(
                              padding:  EdgeInsets.only(right: 5.0),
                              child:  Icon(Icons.search),
                            )),
                      ),
                    ),
                    snapshot.data.isEmpty?Container(
                      height: MediaQuery.of(context).size.height *0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('images/empty.png',height: 150,),
                          Text("No data from our database match your keyword",style: GoogleFonts.ptSerif(
                            letterSpacing: 0.5,
                          ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ): ListView.builder(
                      shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(_parseHtmlString(snapshot.data[index].title),style: GoogleFonts.ptSerif(
                              letterSpacing: 0.5,
                            )),
                            onTap: (){
                              setState(() {
                                isLoading = true;
                              });
                              APi().newsSearchDetails(id: snapshot.data[index].id.toString()).then((value) {
                              setState(() {
                                newsModel = value;
                              });
                              print("this value $value");
                              });

                              Future.delayed(const Duration(seconds: 2)).then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                              var reader = readingTime(newsModel == null?"0":newsModel.content.rendered);
                             newsModel== null?null: Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetails(
                                dbID: newsModel.id,
                                tittle: newsModel.title.rendered,
                                content: newsModel.content.rendered,
                                imageUrl: newsModel.yoastHeadJson.schema.graph[5].thumbnailUrl,
                                id:  newsModel.id,
                                dateTime: formatDate(newsModel.date ?? '', [d, '-', M, '-', yyyy]).toString(),
                                minsRead: reader.minutes.toStringAsFixed(0),
                              )));
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    }),
                  ],
                ),
              );
            }else if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Constant().spinKit,
              ],
            );
          },
        )
      ),
    );
  }
  void toast({String message}){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor:  Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

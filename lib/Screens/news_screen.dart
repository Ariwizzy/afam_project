import 'package:afam_project/Screens/search_screen.dart';
import 'package:afam_project/model/news_model.dart' as n;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Apis/api.dart';
import '../constant.dart';
import '../widget/news_widget.dart';
class NewsScreen extends StatefulWidget {
  const NewsScreen({Key key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  int page = 1;
  bool showSearch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: SizedBox(
              child: Image.asset("images/fnst.png"),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(" NewsFeed",
              style: GoogleFonts.ptSerif(
                fontSize: 19,
                color: const Color(0xff3A4191),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              )),
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showSearch =!showSearch;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(showSearch ? Icons.cancel_outlined : Icons.search),
              ),
            )
          ],
        ),
        body: isLoading
            ? Center(
          child: Constant().spinKit,
        ) : FutureBuilder<List<n.NewsModel>>(
          future: APi().newsApi(page: page),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    showSearch ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5),
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[900], width: 0.0),
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
                              onTap: () {
                                if (searchController.text.isEmpty) {
                                  Constant().toast(message: "Search field is required",color: Colors.red);
                                } else {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(keyword: searchController.text,)),
                                  );
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(Icons.search),
                              )),
                        ),
                      ),
                    )
                        : Container(),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:  snapshot.data.length,
                        itemBuilder: (context, index) {
                          return NewsWidget(
                            data:  snapshot.data[index],
                          );
                        }),
                   page > 1 ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            child: Text("Previous",
                                style: GoogleFonts.ptSerif(
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontSize: 16)),
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                                page--;
                              });
                              APi().newsApi(page: page);
                              Future.delayed(const Duration(seconds: 2)).then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            },
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            elevation: 1,
                            color: const Color(0xff3A4191),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          RaisedButton(
                            child: Text("Next",
                                style: GoogleFonts.ptSerif(
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontSize: 16)),
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                                page++;
                              });
                              APi().newsApi(page: page);
                              Future.delayed(const Duration(seconds: 2)).then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            },
                            padding: const EdgeInsets.symmetric(
                                vertical: 9, horizontal: 29),
                            elevation: 1,
                            color: const Color(0xff3A4191),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ],
                      ),
                    )
                        : Container(
                      child: RaisedButton(
                        child: Text("Load More",
                            style: GoogleFonts.ptSerif(
                                color: Colors.white,
                                letterSpacing: 0.5,
                                fontSize: 16)),
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            page++;
                          });
                          APi().newsApi(page: page);
                          Future.delayed(const Duration(seconds: 2)).then((value) {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        elevation: 1,
                        color: const Color(0xff3A4191),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4),
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 3,
                    )
                  ],
                ),
              );
            }else if(snapshot.hasError){

            }
            return Center(child: Constant().spinKit);
          })
        );
  }

}

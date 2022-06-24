// import 'package:afam_project/Apis/api.dart';
// import 'package:afam_project/Screens/search_screen.dart';
// import 'package:afam_project/model/news_model.dart' as n;
// import 'package:afam_project/model/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../constant.dart';
// import 'package:provider/provider.dart';
// import '../widget/news_widget.dart';
// class NewsScreen extends StatelessWidget {
//   NewsScreen({Key key}) : super(key: key);
//   TextEditingController searchController = TextEditingController();
//   int page = 1;
//   bool isLoading = true;
//
//   bool showSearch = false;
//   @override
//   Widget build(BuildContext context) {
//     apiCall(context);
//    Provider.of<FirstProvider>(context,).newsModel;
//     print("this ${Provider.of<FirstProvider>(context,).page};");
//     isLoading = Provider.of<FirstProvider>(context,).isLoading;
//     showSearch = Provider.of<FirstProvider>(context,).showSearch;
//     page = Provider.of<FirstProvider>(context,).page;
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           leading: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: SizedBox(
//               child: Image.asset("images/fnst.png"),
//             ),
//           ),
//           backgroundColor: Colors.white,
//           elevation: 0,
//           centerTitle: true,
//           title: Text(" NewsFeed",
//               style: GoogleFonts.ptSerif(
//                 fontSize: 21,
//                 color: const Color(0xff3A4191),
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1.2,
//               )),
//           actions: [
//             GestureDetector(
//               onTap: () {
//                 Provider.of<FirstProvider>(context, listen: false)
//                     .changeShowSearch(search: !showSearch);
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Icon(showSearch ? Icons.cancel_outlined : Icons.search),
//               ),
//             )
//           ],
//         ),
//         body: Provider.of<FirstProvider>(context).isLoading
//             ? Center(
//                 child: Constant().spinKit,
//               ) : SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     showSearch
//                         ? Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 4.0, horizontal: 5),
//                             child: TextFormField(
//                               controller: searchController,
//                               decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     vertical: 16, horizontal: 15),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                       color: Colors.grey, width: 0.0),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.grey[900], width: 0.0),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 filled: true,
//                                 hintStyle: GoogleFonts.ptSerif(
//                                   color: Colors.grey[800],
//                                   letterSpacing: 0.5,
//                                 ),
//                                 hintText: "Search...",
//                                 fillColor: Colors.white70,
//                                 suffixIcon: GestureDetector(
//                                     onTap: () {
//                                       if (searchController.text.isEmpty) {
//                                         toast(
//                                             message:
//                                                 "Search field is required");
//                                       } else {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   SearchScreen(
//                                                     keyword:
//                                                         searchController.text,
//                                                   )),
//                                         );
//                                       }
//                                     },
//                                     child: const Padding(
//                                       padding: EdgeInsets.only(right: 5.0),
//                                       child: Icon(Icons.search),
//                                     )),
//                               ),
//                             ),
//                           )
//                         : Container(),
//                     ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount:  Provider.of<FirstProvider>(context,).newsModel.length,
//                         itemBuilder: (context, index) {
//                           return NewsWidget(
//                             data:  Provider.of<FirstProvider>(context,).newsModel[index],
//                           );
//                         }),
//                     Provider.of<FirstProvider>(
//                               context,
//                             ).page >
//                             1
//                         ? Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 RaisedButton(
//                                   child: Text("Previous",
//                                       style: GoogleFonts.ptSerif(
//                                           color: Colors.white,
//                                           letterSpacing: 0.5,
//                                           fontSize: 16)),
//                                   onPressed: () {
//                                     Provider.of<FirstProvider>(context,
//                                             listen: false)
//                                         .changeLoading(loading: true);
//                                     Provider.of<FirstProvider>(context,
//                                             listen: false)
//                                         .changePage(pageb: page - 1);
//                                     APi().newsApi(page: page).then((value) {
//                                       Provider.of<FirstProvider>(context,
//                                               listen: false)
//                                           .changeLoading(loading: false);
//                                     });
//                                   },
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 10, horizontal: 15),
//                                   elevation: 1,
//                                   color: const Color(0xff3A4191),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                 ),
//                                 RaisedButton(
//                                   child: Text("Next",
//                                       style: GoogleFonts.ptSerif(
//                                           color: Colors.white,
//                                           letterSpacing: 0.5,
//                                           fontSize: 16)),
//                                   onPressed: () {
//                                     Provider.of<FirstProvider>(context,
//                                             listen: false)
//                                         .changeLoading(loading: true);
//                                     Provider.of<FirstProvider>(context,
//                                             listen: false)
//                                         .changePage(pageb: page + 1);
//                                     APi().newsApi(page: page);
//                                   },
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 9, horizontal: 29),
//                                   elevation: 1,
//                                   color: const Color(0xff3A4191),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : Container(
//                             child: RaisedButton(
//                               child: Text("Load More",
//                                   style: GoogleFonts.ptSerif(
//                                       color: Colors.white,
//                                       letterSpacing: 0.5,
//                                       fontSize: 16)),
//                               onPressed: () {
//                              Provider.of<FirstProvider>(context,listen: false).changeLoading(loading: true);
//                                 Provider.of<FirstProvider>(context, listen: false).changePage(pageb: page + 1);
//                                apiCall(context);
//                               },
//                               padding: const EdgeInsets.symmetric(vertical: 15),
//                               elevation: 1,
//                               color: const Color(0xff3A4191),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                             ),
//                             margin: const EdgeInsets.symmetric(
//                                 horizontal: 15, vertical: 4),
//                             width: double.infinity,
//                           ),
//                     const SizedBox(
//                       height: 3,
//                     )
//                   ],
//                 ),
//               ));
//   }
//
//   void toast({String message}) {
//     Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }
//
//   void apiCall(BuildContext context) {
//     APi().newsApi(page: Provider.of<FirstProvider>(context,).page,context: context).then((value) {
//       // print(value);
//       // Provider.of<FirstProvider>(context,listen: false).changeNewsModel(newsModelb: value);
//        Future.delayed(const Duration(seconds: 2)).then((value) {
//          Provider.of<FirstProvider>(context, listen: false).changeLoading(loading: false);
//        });
//     });
//   }
// }

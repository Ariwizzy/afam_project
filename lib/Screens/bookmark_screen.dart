import 'package:afam_project/db/db_helper.dart';
import 'package:afam_project/model/db_model.dart';
import 'package:afam_project/widget/news_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key key}) : super(key: key);

  @override
  _BookMarkScreenState createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
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
            return snapshot.data.isEmpty?Center(child: Text("You don't have any bookmark yet",style: GoogleFonts.ptSans(letterSpacing: 0.5,fontSize: 16)),):SingleChildScrollView(
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
      );
  }
}


import 'package:afam_project/model/db_model.dart';
import 'package:afam_project/model/news_model.dart' as news;
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:reading_time/reading_time.dart';

import '../Screens/news_details.dart';
class NewsWidget extends StatelessWidget {
  final news.NewsModel data;
  final List<DbModel> dbModel;
  final bool isDb;
  final int dbIndex;
  const NewsWidget({Key key, this.data, this.dbModel, this.isDb = false, this.dbIndex}) : super(key: key);
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
  @override
  Widget build(BuildContext context) {
    var reader = readingTime(isDb?dbModel[dbIndex].content: data.content.rendered);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsDetails(
                dbID: isDb?dbModel[dbIndex].id:data.id,
                tittle: _parseHtmlString(isDb? dbModel[dbIndex].tittle:data.title.rendered),
                content: isDb? dbModel[dbIndex].content:data.content.rendered,
                imageUrl: isDb? dbModel[dbIndex].imageUrl:data.yoastHeadJson.schema.graph[5].thumbnailUrl,
                id:  isDb?int.parse(dbModel[dbIndex].newsId):data.id,
                dateTime: isDb? dbModel[dbIndex].dateTime:formatDate(data.date ?? '', [d, '-', M, '-', yyyy]).toString(),
                minsRead: isDb? dbModel[dbIndex].minsRead:reader.minutes.toStringAsFixed(0),
              )));
            },
            child: Row(
              children: [
                SizedBox(
                  width:  150,
                  height: 140,
                  child: ClipRRect(
                    child: Image.network(
                      isDb? dbModel[dbIndex].imageUrl:data.yoastHeadJson.schema.graph[5].thumbnailUrl,
                      fit: BoxFit.cover,
                      height: 140,
                      width:  150,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                const SizedBox(width: 3,),
                Flexible(
                  child: Column(
                    children: [
                      Text(_parseHtmlString(isDb? dbModel[dbIndex].tittle:data.title.rendered),style: GoogleFonts.ptSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          letterSpacing: 0.5
                      ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3,),
                      Text(_parseHtmlString(isDb? dbModel[dbIndex].content:data.content.rendered),style: GoogleFonts.ptSans(
                          letterSpacing: 0.5),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 7,),
                      Row(
                        children: [
                          const  Icon(Icons.calendar_today,color: Color(0xff3A4191),size: 16),
                          const SizedBox(width: 2,),
                          Text(isDb? dbModel[dbIndex].dateTime:formatDate(data.date ?? '', [d, '-', M, '-', yyyy]).toString(),style: GoogleFonts.ptSerif(
                              fontSize: 14,
                              letterSpacing: 0.5
                          ),),
                          const Spacer(),
                          const  Icon(Icons.access_time_outlined,color: Color(0xff3A4191),size: 17),
                          const SizedBox(width: 2,),
                          Text(isDb? "${dbModel[dbIndex].minsRead} mins read" :"${reader.minutes.toStringAsFixed(0)} mins read",style: GoogleFonts.ptSerif(
                              letterSpacing: 0.5,
                              fontSize: 15
                          ),)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

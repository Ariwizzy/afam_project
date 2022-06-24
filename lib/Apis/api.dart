import 'dart:convert';

import 'package:afam_project/model/news_model.dart';
import 'package:afam_project/model/search_modell.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';

import '../model/provider.dart';
class APi{
  Future<List<NewsModel>> newsApi({int page}) async{
    final String uri = "https://www.newsbtc.com/wp-json/wp/v2/posts?per_page=20&page=$page";
    var res = await http.get(Uri.parse(uri));
    List jsonResponse = json.decode(res.body);
    List b = jsonResponse.map((jb) =>  NewsModel.fromJson(jb)).toList();
    return b;
  }
  Future<List<SearchModel>> search({String data}) async{
    final String uri = "https://www.newsbtc.com/wp-json/wp/v2/search?search=$data&per_page=30&page=1";
    var res = await http.get(Uri.parse(uri));
    List jsonResponse = json.decode(res.body);
    List b = jsonResponse.map((jb) =>  SearchModel.fromJson(jb)).toList();
    return b;
  }
  Future<NewsModel> newsSearchDetails({String id})async{
    final String uri = "https://www.newsbtc.com/wp-json/wp/v2/posts/$id";
    var res = await http.get(Uri.parse(uri));
    NewsModel newsModel =NewsModel.fromJson(jsonDecode(res.body));
    print(newsModel);
    return newsModel;
  }
}
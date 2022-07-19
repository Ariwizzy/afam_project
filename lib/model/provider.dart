import 'package:flutter/cupertino.dart';

import 'news_model.dart';

class FirstProvider extends ChangeNotifier{
   bool isLoading = true;
   bool showSearch = false;
   String userId ='';
   String referralId ='';
   String name;
   String email;
   double amount =0.0;
   int mineID =1;
   String phoneNumber;
   String walletAddress;
   List<NewsModel> newsModel;
   bool forgotPasswordBtn = false;
   int page =1;
  void changeLoading({bool loading}){
    isLoading = loading;
    notifyListeners();
  }
  void changeForgotPassBtn({bool state}){
    forgotPasswordBtn = state;
    notifyListeners();
  }
  void changePage({int pageb}){
    page = pageb;
    notifyListeners();
  }
  void changeWallet({String walletA}){
    walletAddress = walletA;
    notifyListeners();
  }
  void changeDetails({String nameB,String emailB, String phoneB,double amountb,int mineIdb,String userIdB,referralIdB}){
    name = nameB;
    email = emailB;
    phoneNumber = phoneB;
    amount = amountb;
    userId =userIdB;
    referralId =referralIdB;
    mineID = mineIdb;
    notifyListeners();
  }
  void changeName({String nameB, String emailB, String phoneB,}){
    name = nameB;
    email = emailB;
    phoneNumber = phoneB;
    notifyListeners();
  }
  void changeNewsModel({List<NewsModel> newsModelb}){
    newsModel = newsModelb;
    notifyListeners();
  }
  void changeShowSearch({bool search}){
    showSearch = search;
    notifyListeners();
  }
}
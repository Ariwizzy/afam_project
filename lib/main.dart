import 'dart:developer';

import 'package:afam_project/Screens/homeScreen.dart';
import 'package:afam_project/model/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'Screens/intro.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var token = localStorage.getString("userData");
  if(token == null){
    runApp(const MyApp(screenValue: 1,));
  }else {
    //Navigate to Dashboard.
    runApp(const MyApp(screenValue: 0,));
  }
}

class MyApp extends StatelessWidget {
  final int screenValue;
  const MyApp({Key key, this.screenValue}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>FirstProvider(),
      child:     MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme:  AppBarTheme(
              color: Colors.white,
              titleTextStyle: GoogleFonts.ptSerif(
                color: const Color(0xff3A4191),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5
              ),
              elevation: 0,
              actionsIconTheme: const IconThemeData(
                  color:  Color(0xff3A4191)
              ) ,
              iconTheme: const IconThemeData(
                  color:  Color(0xff3A4191)
              )
          ),
          primarySwatch: Colors.blue,
        ),
        home: screenValue ==0? const Homescreen():const IntroScreen(),
      ),
    );

  }
}
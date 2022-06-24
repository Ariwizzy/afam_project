import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Constant{
  Container container(){
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5)),
      child: Text("Ads Space",style: GoogleFonts.ptSerif()),
      alignment: Alignment.center,
      height: 80,

    );
  }
  static final qTextDecoration = InputDecoration(
      isCollapsed: true,
      contentPadding:const EdgeInsets.all(17),
    hintStyle: GoogleFonts.ptSans(
      color: const Color(0xffCFD4DA),
      letterSpacing: 0.5
    ),
      fillColor: Colors.white,
      filled: true,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffF6F7F9), width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffBAE2F7), width: 2),
      ));
  final spinKit = const SpinKitFadingCircle(
    color: Color(0xff3A4191),
    size: 50.0,
  );
  void toast({String message,Color color}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  void sendMail() async{
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'fistnetwork9@gmail.com',
      query: 'subject=App Feedback&body=App Version 3.23', //add subject and body here
    );

    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
import 'package:afam_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
class NoInternet extends StatefulWidget {
  final Function onTap;
  const NoInternet({Key key, this.onTap}) : super(key: key);

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Lottie.asset(
            'images/no_connection.json',
            width: double.infinity,
            height: 370,
            fit: BoxFit.fill,
          ),
          Text('Something went wrong please check your internet connection and try again.',style: GoogleFonts.ptSerif(
            fontSize: 16,
            letterSpacing: 0.7,

          ),textAlign: TextAlign.center,),
          RaisedButton(
            color: Constant().appColor,
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
            onPressed: widget.onTap,child: Text("Try Again",style: GoogleFonts.poppins(
            letterSpacing: 0.5,
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),),),
        ],
      ),
    );
  }
}

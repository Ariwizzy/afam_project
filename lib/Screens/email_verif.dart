import 'dart:async';

import 'package:afam_project/Screens/homeScreen.dart';
import 'package:afam_project/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
class EmailVerif extends StatefulWidget {
  const EmailVerif({Key key}) : super(key: key);

  @override
  _EmailVerifState createState() => _EmailVerifState();
}

class _EmailVerifState extends State<EmailVerif> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;
  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();
   timer = Timer.periodic(const Duration(seconds: 3), (timer) {
     checkEmailVerified();
   });
    super.initState();
  }
  @override
  void dispose() {
   timer.cancel();
    super.dispose();
  }
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Lottie.asset(
              'images/verify_email.json',
              width: double.infinity -10,
              height: 275,
              repeat: false,
              fit: BoxFit.cover,
            ),
            Text("a verification email has been sent to your email address ${user.email}, kindly click on the link on the mail to get verified",
              style: GoogleFonts.ptSans(
              fontSize: 15.5,
              letterSpacing: 0
            ),
            textAlign: TextAlign.center,
            ),
            // Text("user.email"),
            Text("NB: Kindly check your spam before requesting a resend",style: GoogleFonts.ptSerif()),
            const Spacer(),
            const SizedBox(height: 3,),
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      onPressed: (){
                        user.sendEmailVerification();
                      },child: Text("Resend",style: GoogleFonts.ptSerif(
                      fontSize: 17,
                      letterSpacing: 0.5,
                      color: Constant().appColor,
                  )),
                      color: Constant().secondAppColor,
                  ),
                ),
                const SizedBox(width: 6,),
                Expanded(
                  child: RaisedButton(
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      onPressed: (){
                        checkEmailVerified(showData: true);
                      },
                      child: isLoading?const SpinKitFadingCircle(
                        color: Colors.white,
                        size: 30.0,
                      ):Text("Validate",style: GoogleFonts.ptSerif(
                          fontSize: 17,
                          letterSpacing: 0.5,
                          color: Colors.white
                      )),
                      color: const Color(0xff3A4191)
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
  Future<void> checkEmailVerified({bool showData})async{
    showData?setState(() {
      isLoading = true;
    }):null;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    user = auth.currentUser;
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      localStorage.setString("userData", user.uid).then((value) {
        showData?Navigator.push(context, MaterialPageRoute(builder: (context)=>const Homescreen())):null;
      });
    }else{
      Constant().toast(message: "You email address is not yet verified");
    }
    showData?setState(() {
      isLoading = false;
    }):null;
  }
}

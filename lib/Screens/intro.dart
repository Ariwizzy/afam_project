import 'package:afam_project/Screens/sign-up2.dart';
import 'package:afam_project/Screens/sign_in.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff384095),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: mq*0.03,),
              Image.asset("images/fnst.png",height: 280,width: double.infinity,),
              SizedBox(height: mq*0.02,),
            Text("Earn up to 3 Fist Network Token when you create an account with us",style: GoogleFonts.ptSerif(
                fontSize: 16,
                color:  Colors.white,
                letterSpacing: 0.7,
              ),
              textAlign: TextAlign.center,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        color: const Color(0xff3D5CFF),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp2()));
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        color: const Color(0xff858597),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignIn()));
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

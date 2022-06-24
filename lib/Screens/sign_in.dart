import 'package:afam_project/Screens/homeScreen.dart';
import 'package:afam_project/Screens/sign-up2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool showIcon = true;
  bool isLoading = false;
  String errorMessage ='';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    child: Image.asset("images/fnst.png"),
                  ),
                ),
                const SizedBox(height: 15,),
                Text("Email Address",style: GoogleFonts.ptSans(
                    color: const Color(0xff3A4191),
                    fontSize: 15.5
                ),),
                const  SizedBox(height: 2,),
                TextFormField(
                  maxLines: null,
                  decoration: Constant.qTextDecoration.copyWith(
                    hintText: "Enter email address",
                    // suffixIcon: Icon(Icons.mail_outline)
                  ),
                  validator:(value) =>value != null && !EmailValidator.validate(value) ? "Enter Valid Email" : null,
                  controller: emailController,
                ),
                const  SizedBox(height: 5,),
                Text("Password",style: GoogleFonts.ptSans(
                    color:  Color(0xff3A4191),
                    fontSize: 15.5,
                    letterSpacing: 0.5
                ),),
                const SizedBox(height: 2,),
                TextFormField(
                  obscureText: showIcon,
                  decoration: Constant.qTextDecoration.copyWith(
                      hintText: "Enter password",
                      suffixIcon:  GestureDetector(
                          onTap: (){
                            setState(() {
                              showIcon =! showIcon;
                            });
                          },
                          child: Icon(showIcon?Icons.visibility:Icons.visibility_off,color: const Color(0xffCFD4DA),))
                    // suffixIcon: Icon(Icons.mail_outline)
                  ),
                  validator:(value){
                    print(value);
                    //=>value != null && passwordController.text.length < 6 ? "Enter Valid Email" : null,
                    if(value.isEmpty){
                      return "Password is required";
                    }else if(passwordController.text.length < 6){
                      return "Password must be greater than 6";
                    }
                    return null;
                  },
                  controller: passwordController,
                ),
                const SizedBox(height: 2,),
                Center(
                  child: Text(errorMessage,textAlign: TextAlign.center,style: GoogleFonts.ptSerif(
                      color: Colors.red
                  )),
                ),
                const SizedBox(height: 8,),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    onPressed: isLoading ? (){}:()async{
                      setState(() {
                        isLoading = true;
                        errorMessage = "";
                      });
                      if(_formKey.currentState.validate()){
                        SharedPreferences localStorage = await SharedPreferences.getInstance();
                        try{
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) {
                            var user = FirebaseAuth.instance.currentUser;
                            print(user.uid);
                            localStorage.setString("userData", user.uid).then((value) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Homescreen()));
                            });
                          });
                        }on FirebaseAuthException catch(e){
                          setState(() {
                            isLoading = false;
                            errorMessage = e.code;
                          });
                        }
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },color: const Color(0xff3A4191),
                    child: isLoading ?const SpinKitFadingCircle(
                      color: Colors.white,
                      size: 30.0,
                    ):Text("Sign In",style: GoogleFonts.ptSerif(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5
                    )),
                  ),
                ),
                const SizedBox(height: 9,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp2()));
                  },
                  child: Text.rich(TextSpan(
                    children: [
                      TextSpan(text: "Don't have an account ? ",style: GoogleFonts.ptSans(
                        fontSize: 15.3,
                        letterSpacing: 0.5
                      )),
                      TextSpan(text: "Sign Up",style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.6,
                        fontSize: 15.5
                      )),
                    ]
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

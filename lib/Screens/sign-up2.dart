import 'dart:convert';
import 'dart:math';

import 'package:afam_project/Screens/homeScreen.dart';
import 'package:afam_project/Screens/home_page.dart';
import 'package:afam_project/Screens/sign_in.dart';
import 'package:date_format/date_format.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/provider.dart';
class SignUp2 extends StatefulWidget {
  const SignUp2({Key key}) : super(key: key);

  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController refController = TextEditingController();
  bool showIcon = true;
  bool isLoading = false;
  String errorMessage ='';
  String referralId = '';
  final _formKey = GlobalKey<FormState>();
  List codes =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
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
                  const SizedBox(height: 10,),
                  Text("Full Name",style: GoogleFonts.ptSans(
                      color: const Color(0xff3A4191),
                      fontSize: 15.5
                  ),),
                  const  SizedBox(height: 2,),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    maxLines: null,
                    decoration: Constant.qTextDecoration.copyWith(
                      hintText: "Enter full name",
                    ),
                    validator:(value) => value.isEmpty?"name is required":null,
                    controller: nameController,
                  ),
                  const SizedBox(height: 10,),
                  Text("Phone Number",style: GoogleFonts.ptSans(
                      color: const Color(0xff3A4191),
                      fontSize: 15.5
                  ),),
                  const  SizedBox(height: 2,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    maxLines: null,
                    decoration: Constant.qTextDecoration.copyWith(
                      prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("+234",style: GoogleFonts.ptSans(
                            letterSpacing: 0.9,
                          )),
                        ],
                      ),
                      hintText: "Enter phone number",
                    ),
                    validator:(value){
                      if(value.isEmpty){
                        return "phone number is required";
                      } else if(phoneController.text.length <10){
                        return "invalid phone number";
                      }
                      return null;
                    },
                    controller: phoneController,
                  ),
                  const SizedBox(height: 10,),
                  Text("Email Address",style: GoogleFonts.ptSans(
                      color: const Color(0xff3A4191),
                      fontSize: 15.5
                  ),),
                  const  SizedBox(height: 2,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
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
                    keyboardType: TextInputType.visiblePassword,
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
                      if(value.isEmpty){
                        return "Password is required";
                      }else if(passwordController.text.length < 6){
                        return "Password must be greater than 6";
                      }
                      return null;
                    },
                    controller: passwordController,
                  ), const SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Referral Id",style: GoogleFonts.ptSans(
                          color: const Color(0xff3A4191),
                          fontSize: 15.5
                      ),),
                      Text(" (Optional)",style: GoogleFonts.ptSans(
                          color:  Colors.grey,
                          fontSize: 15,
                        letterSpacing: 0.5
                      ),),
                    ],
                  ),
                  const  SizedBox(height: 2,),
                  TextFormField(
                    maxLength: 6,
                    keyboardType: TextInputType.name,
                    maxLines: null,
                    decoration: Constant.qTextDecoration.copyWith(
                      hintText: "Enter referral code",
                    ),
                    validator: (value){
                     if(refController.text.length < 6){
                        return "invalid referral code";
                      }
                      return null;
                    },
                    controller: refController,
                  ),
                  const SizedBox(height: 2,),
                  errorMessage.isEmpty?Container():Center(
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
                          borderRadius: BorderRadius.circular(20)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      onPressed: isLoading ? (){}:()async{
                        if(_formKey.currentState.validate()){
                          setState(() {
                            isLoading = true;
                            errorMessage = "";
                          });
                        if(refController.text.isEmpty){
                          uploadData();
                        } else {
                          await  FirebaseFirestore.instance.collection("users").where('userid', isGreaterThanOrEqualTo: refController.text, isLessThan: refController.text.substring(0, refController.text.length-1) + String.fromCharCode(refController.text.codeUnitAt(refController.text.length - 1) + 1)).get().then((value) {
                                if(value.docs.isEmpty){
                                 setState(() {
                                   isLoading = false;
                                   errorMessage = "Invalid referral code";
                                  });
                                 // Constant().toast(message: "Invalid referral code",color: const Color(0xff3A4191));
                                } else{
                                  setState(() {
                                    referralId = value.docs[0].data()["userid"];
                                     print(value.docs[0].data()["userid"]);
                                  });
                                  uploadData();
                                }
                          });
                        }
                        }
                      },color: const Color(0xff3A4191),
                      child: isLoading ?const SpinKitFadingCircle(
                        color: Colors.white,
                        size: 30.0,
                      ):Text("Sign Up",style: GoogleFonts.ptSerif(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5
                      )),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignIn()));
                    },
                    child: Text.rich(TextSpan(
                        children: [
                          TextSpan(text: "Already had an account ? ",style: GoogleFonts.ptSans(
                              fontSize: 15.3,
                              letterSpacing: 0.5
                          )),
                          TextSpan(text: "Sign In",style: GoogleFonts.poppins(
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
      ),
    );
  }
  void uploadData()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var user = FirebaseAuth.instance.currentUser;
    // if(refController.text == null){
    //   FirebaseFirestore.instance.collection("users").doc(user.uid).update({"amount":0.0,'refId':refController.text ?? ""}).then((value) {
    //     FirebaseFirestore.instance.collection("users").doc(user.uid).update({'list': []})
    //         .then((value) {
    //       Constant().toast(message: "Login Successfully",color: const Color(0xff3A4191));
    //       localStorage.setString("userData", user.uid).then((value) {
    //
    //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Homescreen()));
    //       });
    //       // setState(() {
    //       //   isLoading = false;
    //       // });
    //     });
    //   });
    // }
    try{
     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) {
        var user = FirebaseAuth.instance.currentUser;
        FirebaseFirestore.instance.collection("users").doc(user.uid).
        set({"email":emailController.text,"userid":user.uid,"name": nameController.text,"number":phoneController.text,"amount":0.0,'referralId':referralId ?? "",'list': []}).then((value) {
          Constant().toast(message: "Login Successfully",color: const Color(0xff3A4191));
           localStorage.setString("userData", user.uid).then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Homescreen()));
          });
        });
      });
    }on FirebaseAuthException catch(e){
      setState(() {
        errorMessage = e.message;
      });
    }



  }
}
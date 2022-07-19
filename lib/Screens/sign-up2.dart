import 'package:afam_project/Screens/email_verif.dart';
import 'package:afam_project/Screens/homeScreen.dart';
import 'package:afam_project/Screens/otp_screen.dart';
import 'package:afam_project/Screens/sign_in.dart';
import 'package:date_format/date_format.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/provider.dart';
import '../widget/pop_over.dart';
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
  String phoneNum = "";
  String referralId = '';
  String verID = " ";
  String otpPin = "205483";
  var number = PhoneNumber(isoCode: 'NG');
  String countryDial = "+1";
  final _formKey = GlobalKey<FormState>();
  List codes =[];
  @override
  Widget build(BuildContext context) {
    // print(phoneNum);
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
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                        phoneNum = number.phoneNumber;
                    },
                    onInputValidated: (bool value) {
                      print(value);
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    maxLength: 10,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    inputDecoration: const InputDecoration(border: InputBorder.none),
                    initialValue: number,

                    textFieldController: phoneController,
                    formatInput: false,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    onSaved: (PhoneNumber number) {
                      print('On Saved: $number');
                    },
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
                      color:  const Color(0xff3A4191),
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
                      if(value.isEmpty){
                        return null;
                      }
                     else if(refController.text.length < 6){
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

                            errorMessage = "";
                          });
                        if(refController.text.isEmpty){
                          // verifyPhone(numberb: phoneNum);
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OtpScreen()));
                          confirmEmail();
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          await  FirebaseFirestore.instance.collection("users").where('userid', isGreaterThanOrEqualTo: refController.text, isLessThan: refController.text.substring(0, refController.text.length-1) + String.fromCharCode(refController.text.codeUnitAt(refController.text.length - 1) + 1)).get().then((value) {
                                if(value.docs.isEmpty){
                                 setState(() {
                                   isLoading = false;
                                   errorMessage = "Invalid referral code";
                                  });
                                 // Constant().toast(message: "Invalid referral code",color: const Color(0xff3A4191));
                                } else{
                                  setState(() {
                                    isLoading = false;
                                    referralId = value.docs[0].data()["userid"];
                                     print(value.docs[0].data()["userid"]);
                                  });
                                  confirmEmail();
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
                  const SizedBox(height: 4,),
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
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void uploadData()async{

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
       var datetime = formatDate(DateTime.now() ?? '', [d, '-', M, '-', yyyy]).toString();
        var user = FirebaseAuth.instance.currentUser;
       double addRefAmount = 1.0;
        Map<String, dynamic> user1 = {"mineId": 1 ,"date": datetime, "amount": 1.0 ,"tittle":"Referral SignUp bonus"};
        FirebaseFirestore.instance.collection("users").doc(user.uid).
        set({"email":emailController.text,"userid":user.uid,"name": nameController.text,"number":phoneNum,"amount":referralId.isEmpty? 0.0 :1.0,'referralId':referralId ?? "",'list': referralId.isEmpty?[]:FieldValue.arrayUnion([user1])}).then((value) {
          if(referralId.isNotEmpty){
            FirebaseFirestore.instance.collection("users").doc(referralId).get().then((value) {
              List list= value.data()["list"];
              Map<String, dynamic> refDetails = {"RefUserId": user.uid,"RefUserName":nameController.text,"date": datetime, "amount": 1.0,"tittle":"Referral Mining Successful","mineId": value.data()['list'][list.length-1]["mineId"]+ 1};
              print(value.data()['amount']);
              FirebaseFirestore.instance.collection("users").doc(referralId).update({'list': FieldValue.arrayUnion([refDetails]),"amount": value.data()['amount'] + addRefAmount,}).then((value) {
                //Constant().toast(message: "Login Successfully",color: const Color(0xff3A4191));
                // localStorage.setString("userData", user.uid).then((value) {
                //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Homescreen()));
                // });
              });
            });
          }
          //Constant().toast(message: "Login Successfully",color: const Color(0xff3A4191));
          setState(() {
            isLoading = false;
          });
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const EmailVerif()));
        });
      });
    }on FirebaseAuthException catch(e){
      setState(() {
        isLoading = false;
        errorMessage = e.message;
      });
    }
  }
  void confirmEmail(){
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Popover(
          child: Container(
            height: 220,
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text("Confirm Email",style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  )),
                ),
                Text('A verification email link will be sent to this email address',style: GoogleFonts.ptSerif(
                  fontSize: 16,
                ),),
                const SizedBox(height: 5,),
                TextFormField(
                  readOnly: true,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: null,
                  decoration: Constant.qTextDecoration.copyWith(
                    suffixIcon:  GestureDetector(
                        onTap: (){

                          Constant().toast(message: "click edit email to edit change email address");
                        },
                        child: const Icon(Icons.report_gmailerrorred_outlined)),
                    hintText: "Enter email address",
                    // suffixIcon: Icon(Icons.mail_outline)
                  ),
                  validator:(value) =>value != null && !EmailValidator.validate(value) ? "Enter Valid Email" : null,
                  controller: emailController,
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 11),
                      color: Constant().secondAppColor,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("Edit Email",style: GoogleFonts.poppins(
                          color: Constant().appColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 0.5
                      )),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 11),
                      color: Constant().appColor,
                      onPressed: (){
                        setState(() {
                          isLoading = true;
                        });
                        Navigator.pop(context);
                        uploadData();
                      },
                      child: Text("Send Email",style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 0.5
                      )),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      isScrollControlled: true,
    );
  }
}
///Phone number verification code
// Future<void> verifyPhone({String numberb}) async {
//   await FirebaseAuth.instance.verifyPhoneNumber(
//     phoneNumber: "+2348145966860",
//     timeout: const Duration(seconds: 20),
//     verificationCompleted: (PhoneAuthCredential credential) {
//       Constant().toast(message: "Auth Completed!");
//     },
//     verificationFailed: (FirebaseAuthException e) {
//       Constant().toast(message: e.message);
//       print(e.message);
//       setState(() {
//         errorMessage = e.message;
//         isLoading = false;
//       });
//     },
//     codeSent: (String verificationId, int resendToken) {
//       Constant().toast(message: "Otp Sent");
//       verID = verificationId;
//       // setState(() {
//       //   screenState = 1;
//       // });
//     },
//     codeAutoRetrievalTimeout: (String verificationId) {
//       Constant().toast(message: "Timeout!");
//     },
//   );
// }
// Future<void> verifyOTP() async {
//   try{
//     await FirebaseAuth.instance.signInWithCredential(
//       PhoneAuthProvider.credential(
//         verificationId: verID,
//         smsCode: otpPin,
//       ),
//     ).then((value) {
//       print("value $value");
//     });
//   } catch(e){
//     print("vaue ${e.toString()}");
//   }
// }
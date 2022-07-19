import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:afam_project/widget/pop_over.dart';


class Constant{
  void passwordReset({BuildContext context,TextEditingController emailController,Function onTap,bool checkState= false}) {
    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet<int>(

      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: Popover(

            child: Container(
              height: 240,
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text("Reset Password",style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    )),
                  ),
                  Text('A password reset link will be sent to your email address',style: GoogleFonts.ptSerif(
                    fontSize: 16,
                  ),),
                  const SizedBox(height: 5,),
                  TextFormField(
                    readOnly: checkState?false:true,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: null,
                    decoration: Constant.qTextDecoration.copyWith(
                      suffixIcon: checkState? null: GestureDetector(
                          onTap: (){
                            Constant().toast(message: "Email can't be edited");
                          },
                          child: const Icon(Icons.report_gmailerrorred_outlined)),
                      hintText: "Enter email address",
                      // suffixIcon: Icon(Icons.mail_outline)
                    ),
                    validator:(value) =>value != null && !EmailValidator.validate(value) ? "Enter Valid Email" : null,
                    controller: emailController,
                  ),
                 const SizedBox(height: 10,),
                  Center(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 12),
                      color: Constant().appColor,
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          onTap();
                        }
                      },
                      child: Text("Send Link",style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 0.5
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      isScrollControlled: true,
    );
  }
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
   final qOtpInputText = GoogleFonts.poppins(
    fontSize: 18.0,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
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
  final Color appColor =  const Color(0xff3A4191);
  final Color secondAppColor =  const Color(0xffE6E6FA);
  List<String> adRequest=["insurance, doctor, health, school,"];
  void toast({String message,Color color}) {
    Fluttertoast.showToast(
      timeInSecForIosWeb: 3,
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  void centerToast({String message,Color color}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
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
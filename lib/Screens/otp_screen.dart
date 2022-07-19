import 'package:afam_project/constant.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../widget/pop_over.dart';
class OtpScreen extends StatefulWidget {
   const OtpScreen({Key key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController emailController= TextEditingController();

  bool sendOtp = true;
  int endTime;
  @override
  void initState() {
   endTime  = DateTime.now().millisecondsSinceEpoch + 1000 * 20;
    super.initState();
  }
  @override
  void dispose() {
    endTime;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Container container(Widget widget){
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              spreadRadius: 1.0,
              color: Colors.black.withOpacity(0.07),
            ),
          ],
        ),
        child:  widget,
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Lottie.asset(
              'images/otp.json',
              width: 240,
              height: 225,
              repeat: false,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 2,),
             Text("Verification Code Sent to +2348145966860",style: GoogleFonts.ptSerif(
              fontSize: 19
            ),),
            const SizedBox(height: 2,),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text("Change number?",style: GoogleFonts.poppins(
                  fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff3A4191)
              ),),
            ),
            const SizedBox(height: 6,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    child: container(TextFormField(
                      style:  Constant().qOtpInputText,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value){
                        if(value.length ==1){
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),)
                  ),
                ),
                const SizedBox(width: 4,),
                Expanded(
                  child: SizedBox(
                      child: container(
                        TextFormField(
                          style:  Constant().qOtpInputText,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value){
                          if(value.length ==1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),)
                  ),
                ),
                const SizedBox(width: 4,),
                Expanded(
                  child: SizedBox(
                      child: container(TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style:  Constant().qOtpInputText,
                        onChanged: (value){
                          if(value.length ==1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),)
                  ),
                ),
                const SizedBox(width: 4,),
                Expanded(
                  child: SizedBox(
                      child: container(TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style:  Constant().qOtpInputText,
                        onChanged: (value){
                          if(value.length ==1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),)
                  ),
                ),
                const SizedBox(width: 4,),
                Expanded(
                  child: SizedBox(
                      child: container(TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style:  Constant().qOtpInputText,
                        onChanged: (value){
                          if(value.length ==1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),)
                  ),
                ),
                const SizedBox(width: 4,),
                Expanded(
                  child: SizedBox(
                      child: container(TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style:  Constant().qOtpInputText,
                        onChanged: (value){
                          if(value.length ==1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),)
                  ),
                ),
              ],
            ),
        const SizedBox(height: 8,),
        Center(
          child: CountdownTimer(
            endTime: endTime,
            onEnd: (){
              setState(() {
                sendOtp = false;
              });
            },
            widgetBuilder: (_, CurrentRemainingTime time) {
              if (time == null) {
                return Text("haven't gotten your otp yet? you can now request resend",style: GoogleFonts.ptSans(
                  fontSize: 16.5
                ),textAlign: TextAlign.center,);
              }
              return Text("We wll send you another code in the next ${time.min ==null ?"":time.min}: ${time.sec} sec",
                style: GoogleFonts.ptSans(
                    fontSize: 16.5
                ),
                textAlign: TextAlign.center,);
                //Text('days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
            },
          ),
        ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    color: Colors.grey[200],
                    elevation: 0,
                    onPressed: sendOtp?null:(){
                      resendOTP(context: context);
                    },child: Text("Resend",style:GoogleFonts.poppins(
                      color:  const Color(0xff3A4191),
                      letterSpacing: 0.4,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                  ),
                  ),
                ),
                const SizedBox(width: 7,),
                Expanded(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                      color: const Color(0xff3A4191),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      onPressed: (){},child: Text("Confirm",style: GoogleFonts.poppins(
                      color: Colors.white,
                      letterSpacing: 0.4,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                      ),
                    ),
                ),
              ],
            ),
            const SizedBox(height: 7,),
          ],
        ),
      ),
    );
  }

  void resendOTP({BuildContext context}){
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Popover(
          child: Container(
            height: 210,
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text("Resend Code",style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  )),
                ),
                Text('A verification code will be send to this number',style: GoogleFonts.ptSerif(
                  fontSize: 16,
                ),),
                const SizedBox(height: 5,),
                TextFormField(
                  readOnly: true,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: null,
                  decoration: Constant.qTextDecoration.copyWith(
                    suffixIcon: GestureDetector(
                        onTap: (){
                          Constant().toast(message: "to edit number click change number");
                        },
                        child: const Icon(Icons.report_gmailerrorred_outlined)),
                    hintText: "Phone number",
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
                    onPressed: (){},
                    child: Text("Resend Code",style: GoogleFonts.poppins(
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
        );
      },
      isScrollControlled: true,
    );
  }
}

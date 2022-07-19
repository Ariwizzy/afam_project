import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../model/provider.dart';
import '../widget/pop_over.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController.text = Provider.of<FirstProvider>(context,listen: false).name;
    emailController.text = Provider.of<FirstProvider>(context,listen: false).email;
    phoneNumberController.text= Provider.of<FirstProvider>(context,listen: false).phoneNumber;
    super.initState();
  }
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    final bool btnState = Provider.of<FirstProvider>(context, ).forgotPasswordBtn;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: isLoading ?Center(child: Constant().spinKit):
      Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name",style: GoogleFonts.roboto(
                  color:  const Color(0xff3A4191),
                  fontSize: 15.5,
                  letterSpacing: 0.5
              ),),
              const SizedBox(height: 2.5,),
              TextFormField(
                keyboardType: TextInputType.name,
                maxLines: null,
                decoration: Constant.qTextDecoration.copyWith(
                  hintText: "Enter full name",
                  // suffixIcon: Icon(Icons.mail_outline)
                ),
                validator:(value) =>value.isEmpty  ? "Name field is required" : null,
                controller: nameController,
              ),
              const SizedBox(height: 7,),
              Text("Email Address",style: GoogleFonts.roboto(
                  color:  const Color(0xff3A4191),
                  fontSize: 15.5,
                  letterSpacing: 0.5
              ),),
              const SizedBox(height: 2.5,),
              TextFormField(
                readOnly: true,
                keyboardType: TextInputType.emailAddress,
                maxLines: null,
                decoration: Constant.qTextDecoration.copyWith(
                  suffixIcon: GestureDetector(
                      onTap: (){
                        Constant().toast(message: "Email can't be edited");
                      },
                      child: const Icon(Icons.report_gmailerrorred_outlined)),
                  hintText: "Enter email address",
                  // suffixIcon: Icon(Icons.mail_outline)
                ),
                validator:(value) {
                  if(value.isEmpty){
                    return "email address is required";
                  }else if(!EmailValidator.validate(value)){
                    return "Enter Valid Email";
                  }
                  return null;
                },
                // =>value != null && !EmailValidator.validate(value) ? "Enter Valid Email" : null,
                controller: emailController,
              ),
              const SizedBox(height: 7,),
              Text("Phone Number",style: GoogleFonts.roboto(
                  color:  const Color(0xff3A4191),
                  fontSize: 15.5,
                  letterSpacing: 0.5
              ),),
              const SizedBox(height: 2.5,),
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
                    return "Phone number is required";
                  } else if(phoneNumberController.text.length <10){
                    return "Enter valid phone number";
                  }
                  return null;
                },
                controller: phoneNumberController,
              ),
              const SizedBox(height: 5,),
              GestureDetector(
                onTap: btnState?(){
                  Constant().centerToast(message: "sending email");
                }:(){
                  Constant().passwordReset(context: context,emailController: emailController,onTap: ()async{
                   Provider.of<FirstProvider>(context,listen: false).changeForgotPassBtn(state: true);
                   Navigator.pop(context);
                    try{
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value){
                        Provider.of<FirstProvider>(context,listen: false).changeForgotPassBtn(state: false);
                        Constant().toast(message: "Resent password email sent successfully",color: Constant().appColor);
                      });
                    }on FirebaseAuthException catch(e){
                      Provider.of<FirstProvider>(context,listen: false).changeForgotPassBtn(state: false);
                      Constant().toast(message: e.message);
                    }
                  },);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(btnState?"Sending email....":"Change Password",style: GoogleFonts.poppins(
                        fontSize: 16.5,
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4,),

              errorMessage.isEmpty?Container():Center(child: Text(errorMessage,style: GoogleFonts.poppins(color: Colors.red),textAlign: TextAlign.center,)),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: const Color(0xff3A4191) ,
                  child: Text("Update",style: GoogleFonts.ptSerif(
                      color: Colors.white,
                      letterSpacing: 0.9,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  )),
                  onPressed: ()async{
                    setState(() {
                      isLoading = true;
                      errorMessage ="";
                    });
                    var user = FirebaseAuth.instance.currentUser;
                   if(_formKey.currentState.validate()){
                     try{
                       await FirebaseFirestore.instance.collection("users").doc(user.uid).
                       update({"email":emailController.text,"userid":user.uid,"name": nameController.text,"number":phoneNumberController.text}).then((value) {
                         FirebaseFirestore.instance.collection("users").doc(user.uid).get().then((value) {
                           List   itemCount = value.data()["list"];
                           Provider.of<FirstProvider>(context,listen: false).changeDetails(userIdB :value.data()['userid'].toString().substring(0,6),mineIdb: itemCount.isEmpty ? 0 : value.data()['list'][itemCount.length-1]["mineId"],amountb: value.data()['amount']??0.0,nameB: value.data()["name"]??'',emailB: value.data()["email"]??'',phoneB: value.data()["number"]??'');
                         });
                         Constant().toast(message: "Updated Successfully",color: const Color(0xff3A4191));
                         Navigator.pop(context);
                       });
                     }catch (e){
                       setState(() {
                         isLoading = false;
                         errorMessage = e.toString();
                       });
                     }
                   }
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }

}

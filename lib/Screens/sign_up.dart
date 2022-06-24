// import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../constant.dart';
// class SignUp extends StatefulWidget {
//   const SignUp({Key key}) : super(key: key);
//
//   @override
//   _SignUpState createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   bool showIcon = false;
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     var mq = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         top: false,
//         child: Container(
//           color: const Color(0xFF0086DD),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: mq *0.076,),
//               const Padding(
//                 padding:  EdgeInsets.only(left:20.0),
//                 child: Icon(Icons.arrow_back,color: Colors.white,size: 35),
//               ),
//               SizedBox(height: mq *0.027,),
//               Padding(
//                 padding: const EdgeInsets.only(left:20.0),
//                 child: Text('Sign Up',style: GoogleFonts.roboto(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.5,
//                   color: Colors.white
//                 ),),
//               ),
//               SizedBox(height: mq *0.025,),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   padding:const EdgeInsets.symmetric(horizontal: 20),
//                   decoration:const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: mq *0.025,),
//                       Text("Welcome Back",style: GoogleFonts.ptSans(
//                         fontSize: 20,
//                         letterSpacing: 0.5,
//                         fontWeight: FontWeight.w600
//                       ),),
//                       SizedBox(height: mq *0.007,),
//                       Text("Hello there, sign in to continue!",style: GoogleFonts.ptSans(
//                         color: Colors.grey[400],
//                         letterSpacing: 0.2,
//                         fontWeight: FontWeight.w600
//                       ),),
//                       SizedBox(height: mq *0.019,),
//                       Text("Full Name",style: GoogleFonts.ptSans(
//                         color: const Color(0xffCFD4DA),
//                         fontSize: 15.5
//                       ),),
//                       SizedBox(height: mq *0.007,),
//                       TextFormField(
//                         maxLines: null,
//                         decoration: Constant.qTextDecoration.copyWith(
//                             hintText: "Enter full name",
//                             // suffixIcon: Icon(Icons.mail_outline)
//                         ),
//                         validator:(value) =>value != null && !EmailValidator.validate(value) ? "Enter Valid Email" : null,
//                         // controller: emailController,
//                       ),
//                       SizedBox(height: mq *0.013,),
//                       Text("Email Address",style: GoogleFonts.ptSans(
//                           color: const Color(0xffCFD4DA),
//                           fontSize: 15.5
//                       ),),
//                       SizedBox(height: mq *0.007,),
//                       TextFormField(
//                         maxLines: null,
//                         decoration: Constant.qTextDecoration.copyWith(
//                           hintText: "Enter email address",
//                           // suffixIcon: Icon(Icons.mail_outline)
//                         ),
//                         validator:(value) =>value != null && !EmailValidator.validate(value) ? "Enter Valid Email" : null,
//                         controller: emailController,
//                       ),
//                       SizedBox(height: mq *0.013,),
//                       Text("Phone no",style: GoogleFonts.ptSans(
//                           color: const Color(0xffCFD4DA),
//                           fontSize: 15.5
//                       ),),
//                       SizedBox(height: mq *0.007,),
//                       TextFormField(
//                         maxLines: null,
//                         decoration: Constant.qTextDecoration.copyWith(
//                           hintText: "Enter phone number",
//                           // suffixIcon: Icon(Icons.mail_outline)
//                         ),
//                         validator:(value) =>value != null && !EmailValidator.validate(value) ? "Enter Valid Email" : null,
//                         // controller: passwordController,
//                       ),
//                       SizedBox(height: mq *0.007,),
//                       Text("Password",style: GoogleFonts.ptSans(
//                           color: const Color(0xffCFD4DA),
//                           fontSize: 15.5
//                       ),),
//                       SizedBox(height: mq *0.007,),
//                       TextFormField(
//                         maxLines: null,
//                         decoration: Constant.qTextDecoration.copyWith(
//                           hintText: "Enter password",
//                           suffixIcon:  GestureDetector(
//                               onTap: (){
//                                 setState(() {
//                                   showIcon =! showIcon;
//                                 });
//                               },
//                               child: Icon(showIcon?Icons.visibility:Icons.visibility_off,color: const Color(0xffCFD4DA),))
//                           // suffixIcon: Icon(Icons.mail_outline)
//                         ),
//                         validator:(value) =>value != null && !EmailValidator.validate(value) ? "Enter Valid Email" : null,
//                         controller: passwordController,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: mq*0.02),
//                         child: Text("Forgot password?",style: GoogleFonts.ptSerif(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 0.4,
//                           fontSize: 14.5
//                         ),),
//                       ),
//                       SizedBox(
//                         width: double.infinity,
//                         child: RaisedButton(
//                           elevation: 1,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: 15),
//                           onPressed: ()async{
//                             print(passwordController.text);
//                             await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
//                           },color: Colors.blue,
//                         child: Text("Sign In",style: GoogleFonts.ptSerif(
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           letterSpacing: 0.5
//                         )),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:afam_project/Screens/bookmark_screen.dart';
import 'package:afam_project/Screens/edit_profile.dart';
import 'package:afam_project/Screens/faq.dart';
import 'package:afam_project/Screens/intro.dart';
import 'package:afam_project/Screens/refer.dart';
import 'package:afam_project/Screens/white_paper.dart';
import 'package:afam_project/constant.dart';
import 'package:afam_project/model/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ListTile listTile({String text,IconData icon,Function ontap}){
    return  ListTile(
      onTap: ontap,
      leading: Icon(icon,color:const Color(0xff3A4191)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 20),
      title: Text(text,style: GoogleFonts.ptSerif(
          letterSpacing: 0.6,
          fontSize: 17
      )),
    );
  }
  @override
  Widget build(BuildContext context) {
    String name = Provider.of<FirstProvider>(context).name;
    String email = Provider.of<FirstProvider>(context).email;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff3A4191),
                    image: const DecorationImage(image: AssetImage("images/design.png"))
                  ),
                  height: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                       child: Image.asset("images/user.png",height: 70),
                       radius: 50,
                       backgroundColor: Colors.white,
                     ),
                     const SizedBox(height: 2,),
                      Text(name??'',style: GoogleFonts.ptSerif(
                        fontSize: 18,
                        letterSpacing: 0.5,
                        color: Colors.white,
                      ),),
                     const SizedBox(height: 2,),
                      Text(email??"",style: GoogleFonts.ptSerif(
                        fontSize: 15,
                        letterSpacing: 0.8,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                  listTile(text: "Bookmarked",icon: Icons.bookmark,ontap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const BookMarkScreen()));
                  }),
                  const Divider(thickness: 0.7,),
                  listTile(text: "Edit Profile",icon: Icons.person,ontap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile()));
                  }),
                const Divider(thickness: 0.7),
                listTile(text: "Refer",icon: Icons.workspaces,ontap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Refer()));
                }),
                  const Divider(thickness: 0.7,),
                  listTile(text: "FAQ",icon: Icons.help_outline_outlined,ontap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Faq()));
                  }),
                const Divider(thickness: 0.7,),
                listTile(text: "White Paper",icon: Icons.format_indent_increase_outlined,ontap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const WhitePaper()));
                }),
                const Divider(thickness: 0.7),
                  listTile(text: "Contact Us",icon: Icons.mail,ontap: (){
                    Constant().sendMail();
                  }),
                const Divider(thickness: 0.7),
               const SizedBox(height: 10,),
                GestureDetector(
                  onTap: ()async{
                    showAlertDialog(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Sign Out',style: GoogleFonts.roboto(
                      color: Colors.red,
                      letterSpacing: 0.5,
                      fontSize: 16.5,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",style: GoogleFonts.ptSans(
          fontSize: 16,
          letterSpacing: 0.5
      )),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Sign Out",style: GoogleFonts.ptSans(
        color: Colors.red,
        fontSize: 16,
        letterSpacing: 0.5
      )),
      onPressed:  () async{
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        await FirebaseAuth.instance.signOut();
        localStorage.clear().then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const IntroScreen()));
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Sign Out",style: GoogleFonts.ptSans(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          letterSpacing: 0.5
      )),
      content: Text("Confirm sign out",style: GoogleFonts.ptSans(
          fontSize: 15,
          letterSpacing: 0.5
      )),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

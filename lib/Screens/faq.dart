import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant.dart';
class Faq extends StatelessWidget {
  const Faq({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle(){
      return GoogleFonts.roboto(
          color: const Color(0xff3A4191),
          fontSize: 18,
          letterSpacing: 0.5,
          fontWeight: FontWeight.bold
      );
    }
    TextStyle  textStyle2(){
      return GoogleFonts.ptSerif(
          letterSpacing: 0.5
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Why mining?",style: textStyle()),
           const  SizedBox(height: 5,),
            Text("Ans: The team of FIST network introduced mining as a way of getting the Airdrop because we’re trying to get the most active people mining and using our app worldwide. We can’t just reward everyone the same amount of tokens so mining is very important to know who is consistent in using FSNT app.",
              style: textStyle2()
            ),
            const Divider(thickness: 1,height: 25),
            Text("What are the socials?",style: textStyle()),
            const  SizedBox(height: 5,),
            Text("Ans: FIST network all socials will be up and running in no time, for now you can contact us using our official Email.",  style: textStyle2()),
            const Divider(thickness: 1,height: 25),
            Constant().container(),
            SizedBox(height: 5,),
            Text("When can I place withdrawal?",style: textStyle()),
            const  SizedBox(height: 5,),
            Text("Ans: You can place withdrawal after mining 100+ FSNT and the token will get to you whenever we launch.",style: textStyle2(),),
            const Divider(thickness: 1,height: 25),
            Text("When is the launch?",style: textStyle()),
            const  SizedBox(height: 5,),
            Text("Ans: Q1 2023 as we need enough time to set everything in place to avoid errors during the token launch.",style: textStyle2(),),
            const Divider(thickness: 1,height: 25),
            Text('To know more about FSNT send an email',style: textStyle2(),),
            const  SizedBox(height: 5,),
            GestureDetector(
              onTap: (){
                Constant().sendMail();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text("Fistnetwork9@gmail.com",style: GoogleFonts.ptSerif(
                  color: const Color(0xff3A4191),
                  letterSpacing: 0.5,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}

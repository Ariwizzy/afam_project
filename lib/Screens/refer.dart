import 'package:flutter/services.dart';
import 'package:afam_project/constant.dart';
import 'package:afam_project/model/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
class Refer extends StatefulWidget {
  const Refer({Key key}) : super(key: key);

  @override
  _ReferState createState() => _ReferState();
}

class _ReferState extends State<Refer> {
  @override
  Widget build(BuildContext context) {
   final String userId = Provider.of<FirstProvider>(context).userId;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Refer"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Container(
                alignment: Alignment.center,
                child: Image.asset("images/refer.png",fit: BoxFit.cover,height: 230,),
            ),
            const SizedBox(height: 8),
          Text("Earn 1 FNST for any user that sign up with your referral Code, You will also earn 20% of what your referral is earns. share referral link to start earning.",style: GoogleFonts.ptSerif(
            letterSpacing: 0.4,
            fontSize: 14.8,
          ),textAlign: TextAlign.center),
          const SizedBox(height: 15),
          Constant().container(),
          Text("Referral Code",style: GoogleFonts.ptSerif(
            fontSize: 17,
            color: const Color(0xff3A4191),
            letterSpacing: 0.3
          )),
          ListTile(
            onTap: (){
              Clipboard.setData( ClipboardData(text: userId.toString().substring(0,6).toString()));
              Constant().toast(message: "Copied To Clipboard",color:  Colors.grey);
            },
            trailing: const Icon(Icons.copy,color: Color(0xff3A4191)),
            title: Text(userId.toString().substring(0,6),style: GoogleFonts.ptSerif(
                letterSpacing: 0.6,
                fontSize: 17,
            )),
          ),
            const SizedBox(height: 15),
            Center(
              child: RaisedButton(
                padding: const EdgeInsets.symmetric(vertical: 11,horizontal: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 1,
                color: const Color(0xff3A4191),
                onPressed: (){
                  Share.share(
                    "Mine FSNT using my referralId: ${userId.toString().substring(0,6)} and get 1free FSNT. <Referral link>",
                  );
                },
                child: Text("Share Referral Link",style: GoogleFonts.ptSerif(
                color: Colors.white,
                letterSpacing: 0.5,
                fontWeight: FontWeight.bold,
                fontSize: 17
              )),),
            ),
          ],
        ),
      ),
    );
  }
}

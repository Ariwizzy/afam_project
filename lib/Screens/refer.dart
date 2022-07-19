import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/services.dart';
import 'package:afam_project/constant.dart';
import 'package:afam_project/model/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../widget/ads_code.dart';
class Refer extends StatefulWidget {
  const Refer({Key key}) : super(key: key);

  @override
  _ReferState createState() => _ReferState();
}

class _ReferState extends State<Refer> {
  BannerAd bannerAd;
  bool admobFailToLoad = false;
  @override
  void initState() {
    AppLovinMAX.showBanner(MaxCode().bannerAdUnitId);
    ads();
    super.initState();
  }
  @override
  void dispose() {
    AppLovinMAX.hideBanner(MaxCode().bannerAdUnitId);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   final String userId = Provider.of<FirstProvider>(context).userId;
   print(userId);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Refer"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //     alignment: Alignment.center,
              //     child: Image.asset("images/refer.png",fit: BoxFit.cover,height: 230,),
              // ),
              Lottie.asset(
                'images/referLottie.json',
                width: double.infinity ,
                height: 300,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 8),
            Text("Earn 1 FNST for any user that sign up with your referral Code, You will also earn 20% of what your referral is earn. share referral link to start earning.",style: GoogleFonts.ptSerif(
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
      ),
      bottomNavigationBar: SizedBox(
          height: 80,
          child: AdWidget(ad: bannerAd)),
    );

  }
  void ads(){
    bannerAd = BannerAd(
      adUnitId: AdsCode().banner,
      size: AdSize.banner,
      request: AdRequest(keywords: Constant().adRequest),
      listener: BannerAdListener(
          onAdFailedToLoad: (ad,loadError){
            setState(() {
              admobFailToLoad = true;
            });
          },
          onAdClosed: (ad) => ad.dispose()),
    );
    bannerAd.load();
  }

}

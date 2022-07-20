import 'package:afam_project/Screens/refer.dart';
import 'package:afam_project/constant.dart';
import 'package:afam_project/model/provider.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../widget/ads_code.dart';
import '../widget/pop_over.dart';
class WithDraw extends StatefulWidget {
  final double currentEarning;
  const WithDraw({Key key, this.currentEarning}) : super(key: key);

  @override
  _WithDrawState createState() => _WithDrawState();
}

class _WithDrawState extends State<WithDraw> {
  TextStyle style(){
    return GoogleFonts.ptSans(
        fontSize: 14.5,
        letterSpacing: 0.5
    );
  }
  TextStyle style2(){
    return GoogleFonts.roboto(
      fontSize: 15,
      color: const Color(0xff3A4191),
      letterSpacing: 0.5,
      fontWeight: FontWeight.bold,
    );
  }
  bool showButton = false;
  TextEditingController walletController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String errorMessage = "";
  BannerAd bannerAd;
  @override
  void initState() {
    ads();
    super.initState();
  }
  @override
  void dispose() {
    AppLovinMAX.hideBanner(MaxCode().bannerAdUnitId);
    super.dispose();
  }
  bool admobError =false;
  @override
  Widget build(BuildContext context) {
    admobError? AppLovinMAX.showBanner(MaxCode().bannerAdUnitId):AppLovinMAX.hideBanner(MaxCode().bannerAdUnitId);
    final String walletAddress = Provider.of<FirstProvider>(context).walletAddress;
    int balEarning = 100 - widget.currentEarning.toInt();
    final String userID = Provider.of<FirstProvider>(context).userId;
    if(widget.currentEarning.toInt() >= 100){
      showButton = true;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Withdraw"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const  SizedBox(height: 5,),
              Image.asset("images/withdraw.png",height: 200,width: double.infinity,),
               Text('Minimum Withdrawal 100 FSNT',style: GoogleFonts.ptSerif(
                 fontSize: 16,
                 color: const Color(0xff3A4191),
                 fontWeight: FontWeight.bold,
                 letterSpacing: 0.5,
               ),),
            const  SizedBox(height: 13,),
              !showButton?Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Current Earning ',style: style()),
                    TextSpan(
                      text: '${widget.currentEarning.toInt()} FSNT',
                      style: style2()
                    ),
                    TextSpan(text: ' you need',style: style()),
                    TextSpan(text: ' $balEarning More FSNT',style: style2()),
                    TextSpan(text: ' before you can place withdrawal, you can also refer people to boost your earnings ',style: style()),
                  ],
                ),
                textAlign: TextAlign.center,
              ):Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Current Earning ',style: style()),
                    TextSpan(
                        text: '${widget.currentEarning.toInt()} FSNT',
                        style: style2()
                    ),
                    TextSpan(text: ' you can now add your ERC20 address , Refer your friends to increase your earnings',style: style()),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10,),
              Constant().container(),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      elevation: 1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Refer()));
                        },child: Text("Refer Now",style: GoogleFonts.ptSerif(
                        fontSize: 17,
                        letterSpacing: 0.5,
                        color: Colors.white
                    )),
                        color: const Color(0xff3A4191)
                    ),
                  ),
                  const SizedBox(width: 6,),
                  Expanded(
                    child: RaisedButton(
                        elevation: 1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        onPressed: (){
                          if(walletAddress.isNotEmpty){
                            print("okk");
                            setState(() {
                              walletController.text = walletAddress;
                              _handleFABPressed(userId: userID);
                            });
                          }
                          else if(showButton){
                            _handleFABPressed(userId: userID);
                          }
                          else{
                            Constant().toast(message: "Earn 100 FSNT to add wallet",color:  const Color(0xff3A4191));
                          }
                        },
                        child: isLoading?const SpinKitFadingCircle(
                          color: Colors.white,
                          size: 30.0,
                        ):Text(walletAddress  == null || walletAddress.isEmpty  ?"Add Wallet Address":"Update Address",style: GoogleFonts.ptSerif(
                            fontSize: 17,
                            letterSpacing: 0.5,
                            color: Colors.white
                        )),
                        color:  showButton ? const Color(0xff3A4191) : Colors.grey
                    ),
                  ),
                ],
              ),
              // const Spacer(),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 15),
              //   width: double.infinity,
              //   child: RaisedButton(
              //     elevation: 1,
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
              //     padding: const EdgeInsets.symmetric(vertical: 15,),
              //
              //
              //     color:  showButton ? const Color(0xff3A4191) : Colors.grey
              //   ),
              // ),
              // SizedBox(height: 4,),
            ],
          ),
        ),
      ),
    );

  }
  void _handleFABPressed({String userId}) {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Popover(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              width: double.infinity,
              height: 200,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter ERC20 Address",style: GoogleFonts.poppins(
                    letterSpacing: 0.5,
                    fontSize: 15
                  )),
                  const SizedBox(height: 5,),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    maxLines: null,
                    decoration: Constant.qTextDecoration.copyWith(
                      hintText: "Enter full name",
                      // suffixIcon: Icon(Icons.mail_outline)
                    ),
                    validator:(value) =>value.isEmpty  ? "Enter wallet address" : null,
                    controller: walletController,
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                          color: const Color(0xff3A4191),
                          padding: const EdgeInsets.symmetric(vertical: 9,horizontal: 35),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              setState(() {
                                isLoading = true;
                              });
                              try{
                                await FirebaseFirestore.instance.collection("users").doc(userId).
                                update({"walletAddress" : walletController.text,}).then((value) {
                                  // FirebaseFirestore.instance.collection("users").doc(userId).get().then((value) {
                                  //   List   itemCount = value.data()["list"];
                                  //   Provider.of<FirstProvider>(context,listen: false).changeDetails(userIdB :value.data()['userid'].toString().substring(0,6),mineIdb: itemCount.isEmpty ? 0 : value.data()['list'][itemCount.length-1]["mineId"],amountb: value.data()['amount']??0.0,nameB: value.data()["name"]??'',emailB: value.data()["email"]??'',phoneB: value.data()["number"]??'');
                                  // });
                                  Provider.of<FirstProvider>(context,listen: false).changeWallet(walletA: walletController.text);
                                 Constant().toast(message: "Wallet added Successfully",color:  Colors.grey);
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                                Navigator.pop(context);
                              }catch (e){
                                setState(() {
                                  isLoading = false;
                                  print("jj");
                                  errorMessage = e.toString();
                                  // Constant().toast(message: e.toString(),color:  Colors.grey);
                                });
                                Navigator.pop(context);
                              }
                          }},child: Text("Save",style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        letterSpacing: 0.5,
                      )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      isScrollControlled: true,
    );
  }
  void ads(){
    bannerAd = BannerAd(
      adUnitId: AdsCode().banner,
      size: AdSize.banner,
      request: AdRequest(keywords: Constant().adRequest),
      listener: BannerAdListener(
          onAdClosed: (ad) => ad.dispose(),
          onAdFailedToLoad: (ad,error){
            print("Reason why ads banner Ads did not load $error");
            setState(() {
              admobError = true;
            });
          }
      ),
    );
    bannerAd.load();
  }
}

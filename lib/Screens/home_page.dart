import 'dart:async';
import 'package:afam_project/Screens/withdraw.dart';
import 'package:afam_project/model/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import '../constant.dart';
import '../utilities/notification_service.dart';
import '../widget/ads_code.dart';
import '../widget/pop_over.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showBal = false;
  bool isRewardShow = false;
  bool isRewardLoaded = false;
  bool isMaxAdLoaded = false;
  RewardedAd  myRewarded;
  BannerAd bannerAd;
  LocalNotificationService service;
  bool uploadLoading = false;
  bool admobAdsFailToLoad = false;

  @override
  void initState() {
    _fetchUser();
    RewardedAd.load(
        adUnitId: AdsCode().reward,
        request: const AdRequest(
            contentUrl: "https://lifehappens.org/blog/seeking-financial-security-get-life-insurance/"
        ),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            setState(() {
              admobAdsFailToLoad = false;
            });
            print('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            setState(() {
              isRewardLoaded =true;
              myRewarded = ad;
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: ${error.message}');
            setState(() {
              admobAdsFailToLoad = true;
            });
          },
        ));
    service = LocalNotificationService();
    service.intialize();
    // Timer.periodic( const Duration(seconds: 10), (time) async{
    //   debugPrint("Print after 10 seconds");
    //     //await service.showScheduleNotification(seconds: 10,id: 2, title: "notification tittle", body: "notification Body");
    // });
    // ads();
    super.initState();
  }
  String id;
  List<Map> list =[];
  List itemCount =[];
  bool isLoading = true;
  double amount;
  @override
  Widget build(BuildContext context) {
    print("yo this itz ${DateTime.now().millisecondsSinceEpoch + 1000 * 20}");
    isMaxAdLoaded ? null: initializeRewardedAds();
    // if(!isRewardLoaded){
    //   initializeRewardedAds();
    // }
    final  String name = Provider.of<FirstProvider>(context).name;
    amount =Provider.of<FirstProvider>(context).amount;
    return Scaffold(
      body: isLoading ?Center(child: Constant().spinKit,):SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 4,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("${greeting()} ${name ?? ""}",style: GoogleFonts.ptSerif(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: const Color(0xff000000),
                    letterSpacing: 0.3
                  ),maxLines: 1,overflow: TextOverflow.ellipsis,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        stops: [0.2,1.0,],
                        colors: [
                          Color(0xff55578D),
                          Color(0xff3A4191),
                        ],),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: double.infinity,
                    height: 180,
                    child: Stack(
                      children: [
                        // Positioned(
                        //     bottom: 2,
                        //     child: ClipRRect(
                        //         borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(45)),
                        //         child: Image.asset("images/design.png",width: MediaQuery.of(context).size.width,fit: BoxFit.cover,))
                        // ),
                        Positioned(
                          right: 20,
                          left: 20,
                          top: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total Earnings",style: GoogleFonts.ptSerif(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                  color: Colors.white
                              )),
                              const SizedBox(height: 7,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Text(showBal?'******':"${amount.toStringAsFixed(2)} FSNT",style: GoogleFonts.nunito(
                                        fontSize: showBal ? 29 : 24,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                        color: Colors.white
                                    )),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          showBal =!showBal;
                                        });
                                      },
                                      child:  Padding(
                                        padding:  const EdgeInsets.only(right:8.0),
                                        child:  Icon(showBal?Icons.visibility:Icons.visibility_off_outlined,color: Colors.white,size: 26,),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 20,
                          bottom: 15,
                          left: 20,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                             RaisedButton(
                                  onPressed: isRewardShow?(){
                                    Fluttertoast.showToast(
                                        msg: "Today Task is completed check back tomorrow",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: const Color(0xff3A4191),
                                        textColor: Colors.white,
                                        fontSize: 14.0
                                    );
                                  }:()async{
                                    if(isRewardLoaded){
                                      myRewarded.show(
                                        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) async {
                                          print("hh");
                                          // Reward the user for watching an ad.
                                          setState(() {
                                            uploadLoading = true;
                                            isRewardShow = true;
                                          });
                                          await service.showScheduleNotification(seconds: 1,id: 2, title: "Don’t forget to mine FSNT", body: "Your mining session just ended. Come back to keep mining FSNT");
                                          uploadData(amount);
                                          print("this reward item ${rewardItem.amount}");
                                        },
                                      );
                                    }
                                    else if(admobAdsFailToLoad && isMaxAdLoaded){
                                      print("Max time");
                                     //showAppLovingAds();
                                      showAd();
                                    }
                                    else{
                                      Fluttertoast.showToast(
                                          msg: "Ads Loading....",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: const Color(0xff3A4191),
                                          textColor: Colors.white,
                                          fontSize: 14.0
                                      );
                                    }
                                  },
                                  color: Colors.white,
                                  child:    uploadLoading?const SpinKitFadingCircle(
                                    color: Color(0xff3A4191),
                                    size: 20.0,
                                  ):Text("Mine FSNT",style: GoogleFonts.nunitoSans(
                                    color: const Color(0xff3A4191),
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15
                                )),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                elevation: 1,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 13,
                                    horizontal: 16,
                                  ),
                                ),
                                const Spacer(),
                                RaisedButton(
                                  onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>  WithDraw(currentEarning: double.parse( amount.toStringAsFixed(2)))));
                                 },
                                  color: Colors.white,
                                  child: Text("Withdraw",style: GoogleFonts.nunitoSans(
                                      color: const Color(0xff3A4191),
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  )),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  elevation: 1,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 13,
                                    horizontal: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0,top: 5),
                  child: Text("Mining History",style: GoogleFonts.ptSerif(
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                  )),
                ),
                itemCount.isEmpty ? Container(child: Column(
                  children: [
                    Lottie.asset(
                      'images/history.json',
                      repeat: false,
                      width: MediaQuery.of(context).size.width *1,
                      height: 289,
                      fit: BoxFit.fill,
                    ),
                    Text("No history yet. \n Click mine FSNT to start mining",
                      style: GoogleFonts.ptSerif(fontSize: 16.5,letterSpacing: 0.4),
                    textAlign: TextAlign.center,
                    ),
                  ],
                ),):ListView.builder(
                  reverse: true,
                 physics: const NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                   itemCount:  itemCount.length,
                   itemBuilder:(context,i){
                   // if(i== 3){
                   //   return SizedBox(
                   //       height: 80,
                   //       child: AdWidget(ad: bannerAd),
                   //   );
                   // }
                 return  ListTile(
                   onTap: (){
                     itemCount[i]["RefUserName"] == null ? null: _handleFABPressed(name: itemCount[i]["RefUserName"],amount: double.parse(itemCount[i]["amount"].toString()),date: itemCount[i]["date"]);
                   },
                   title: Text(itemCount[i]['tittle'], style: GoogleFonts.ptSerif(fontSize: 15,letterSpacing: 0.2),),
                   subtitle: Text(itemCount[i]['date'],style: GoogleFonts.ptSerif(letterSpacing: 0.3)),
                   leading:const CircleAvatar(
                     backgroundColor: Color(0xffD4D6E2),
                     child: Icon(Icons.arrow_downward,color: Color(0xff3A4191),),
                   ),
                   trailing: Text("+${itemCount[i]['amount']}0 FSNT",style: GoogleFonts.ptSerif(
                     letterSpacing: 0.5,
                   )),
                 );
               })
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar:
    );
  }
  void _handleFABPressed({String name,double amount,String date}) {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Popover(
          child: Container(
            height: 250,
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  title: const Text("Referal name"),
                  trailing: Text(name,style: GoogleFonts.poppins(fontSize: 16,letterSpacing: 0.2)),
                ),
                Divider(),
                ListTile(
                  title: const Text("Amount"),
                  trailing: Text("${amount.toString()} FSNT",style: GoogleFonts.roboto(fontSize: 17)),
                ),
                ListTile(
                  title: const Text("Date"),
                  trailing: Text(date,style: GoogleFonts.roboto(fontSize: 17)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
    _fetchUser()async{
      // FirebaseFirestore.instance.collection("users").get().then(
      //       (value) {
      //     value.docs.forEach(
      //           (element) {
      //         print(element.id);
      //       },
      //     );
      //   },
      // );
      var user = FirebaseAuth.instance.currentUser;
     try{
       await FirebaseFirestore.instance.collection("users").doc(user.uid).get().then((value) {
         itemCount = value.data()["list"]??[];
         id = value.data()["userid"];
         print(value.data()['referralId']);
         Provider.of<FirstProvider>(context,listen: false).changeDetails(referralIdB: value.data()['referralId']??'',userIdB :value.data()['userid'],mineIdb: itemCount.isEmpty ? 0 : value.data()['list'][itemCount.length-1]["mineId"],amountb: value.data()['amount']??0.0,nameB: value.data()["name"]??'',emailB: value.data()["email"]??'',phoneB: value.data()["number"]??'');
         Provider.of<FirstProvider>(context,listen: false).changeWallet(walletA: value.data()['walletAddress']??'');
       });
     } catch(e){
       print(e);
       setState(() {
         isLoading = false;
       });
     }
      setState(() {
        isLoading = false;
        uploadLoading = false;
      });
    }
  void uploadData(double amount) async{
    final String referralId = Provider.of<FirstProvider>(context,listen: false).referralId??'';
    final String userId = Provider.of<FirstProvider>(context,listen: false).userId;
    final String name = Provider.of<FirstProvider>(context,listen: false).name;
    double addAmount = 0.8;
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hm().format(now);
    double addRefAmount = 0.2;
    var datetime = formatDate(DateTime.now() ?? '', [d, '-', M, '-', yyyy]).toString();
    var user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> user1 = {"mineId": Provider.of<FirstProvider>(context,listen: false).mineID + 1 ,"date": datetime, "amount": 0.80,"tittle":"Mining Successful"};
    FirebaseFirestore.instance.collection("users").doc(user.uid).update({'list': FieldValue.arrayUnion([user1]),"amount":amount + addAmount,"mineId": 1, "lastAdView":formattedTime}).then((value) {
     if(referralId.isEmpty || referralId == null || referralId ==''){
        _fetchUser();
     }else{
       FirebaseFirestore.instance.collection("users").doc(referralId).get().then((value) {
         List list= value.data()["list"];
         Map<String, dynamic> refDetails = {"RefUserId": userId,"RefUserName":name,"date": datetime, "amount": 0.20,"tittle":"Referral Mining Successful","mineId": value.data()['list'][list.length-1]["mineId"]+ 1};
         print(value.data()['amount']);
         FirebaseFirestore.instance.collection("users").doc(referralId).update({'list': FieldValue.arrayUnion([refDetails]),"amount": value.data()['amount'] + addRefAmount,}).then((value) {
           _fetchUser();
         });
       });
     }
    });
  }
  // void ads(){
  //   bannerAd = BannerAd(
  //     adUnitId: AdsCode().banner,
  //     size: AdSize.banner,
  //     request: AdRequest(keywords: Constant().adRequest),
  //     listener: BannerAdListener(
  //       onAdClosed: (ad) => ad.dispose(),
  //         onAdFailedToLoad: (ad,LoadAdError error) {
  //
  //   },),
  //   );
  //   bannerAd.load();
  // }
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  void initializeRewardedAds() {
    print("ohh yh");
    var _rewardedAdRetryAttempt = 0;
    AppLovinMAX.setRewardedAdListener(RewardedAdListener(
        onAdLoadedCallback: (ad) {
          setState(() {
            isMaxAdLoaded = true;
          });
      // Rewarded ad is ready to be shown. AppLovinMAX.isRewardedAdReady(_rewarded_ad_unit_id) will now return 'true'
      print('Rewarded ad loaded from ' + ad.networkName);
      // Reset retry attempt
      _rewardedAdRetryAttempt = 0;
    }, onAdLoadFailedCallback: (adUnitId, error) {
      // Rewarded ad failed to load
      // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
      _rewardedAdRetryAttempt = _rewardedAdRetryAttempt + 1;

      int retryDelay = pow(2, min(6, _rewardedAdRetryAttempt)).toInt();
      print('Rewarded ad failed to load with code ' + error.code.toString() + ' - retrying in ' + retryDelay.toString() + 's');

      Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
        AppLovinMAX.loadRewardedAd(MaxCode().reward);
      });
    }, onAdDisplayedCallback: (ad) async{
      print("onAdReceivedRewardCallback $ad");
      setState(() {
        isRewardShow = true;
        uploadData(amount);
      });
      await service.showScheduleNotification(seconds: 1,id: 2, title: "Don’t forget to mine FSNT", body: "Your mining session just ended. Come back to keep mining FSNT");
    }, onAdDisplayFailedCallback: (ad, error) {
      print("onAdReceivedRewardCallback $ad");
    }, onAdClickedCallback: (ad) {
      print("onAdReceivedRewardCallback $ad");
    }, onAdHiddenCallback: (ad) {
      print("onAdReceivedRewardCallback $ad");
    }, onAdReceivedRewardCallback: (ad, reward) {
      print("onAdReceivedRewardCallback $ad");
    }));
    AppLovinMAX.loadRewardedAd(MaxCode().reward);
  }
  void showAd(){
    if (AppLovinMAX.isRewardedAdReady(MaxCode().reward) != null) {
      AppLovinMAX.showRewardedAd(MaxCode().reward);
    }
  }
  }

///show app loving interstitial ads
//var _interstitialRetryAttempt = 0;
// void initializeInterstitialAds() {
//   print("yo see me");
//   AppLovinMAX.setInterstitialListener(InterstitialListener(
//     onAdLoadedCallback: (ad) {
//       print(Provider.of<FirstProvider>(context).amount);
//       print(Provider.of<FirstProvider>(context).amount);
//       // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
//       print('Interstitial ad loaded from ' + ad.networkName);
//       setState(() {
//         isMaxAdLoaded = true;
//       });
//       // Reset retry attempt
//       _interstitialRetryAttempt = 0;
//     },
//     onAdLoadFailedCallback: (adUnitId, error) {
//       // Interstitial ad failed to load
//       // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
//       _interstitialRetryAttempt = _interstitialRetryAttempt + 1;
//
//       int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();
//       print('Interstitial ad failed to load with code ' + error.code.toString() + ' - retrying in ' + retryDelay.toString() + 's');
//       Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
//         AppLovinMAX.loadInterstitial(MaxCode().interstitialAdUnitId);
//       });
//     },
//     onAdDisplayedCallback: (ad) {
//       print("onAdDisplayedCallback $ad");
//       setState(() {
//         isRewardShow = true;
//       });
//       uploadData(Provider.of<FirstProvider>(context).amount);
//     },
//     onAdDisplayFailedCallback: (ad, error) {
//       print("onAdDisplayFailedCallback $ad");
//     },
//     onAdClickedCallback: (ad) {
//       print("AdClickedCallback $ad");
//     },
//     onAdHiddenCallback: (ad) {
//       print("onAdHiddenCallback $ad");
//     },
//   ));
//
//   // Load the first interstitial
//   AppLovinMAX.loadInterstitial(MaxCode().interstitialAdUnitId);
// }
// void showAppLovingAds(){
//   if (AppLovinMAX.isInterstitialReady(MaxCode().interstitialAdUnitId) != null) {
//     AppLovinMAX.showInterstitial(MaxCode().interstitialAdUnitId);
//   }
// }
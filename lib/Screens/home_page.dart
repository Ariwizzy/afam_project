import 'dart:convert';

import 'package:afam_project/Screens/trash_screen.dart';
import 'package:afam_project/Screens/withdraw.dart';
import 'package:afam_project/model/firebase_model.dart';
import 'package:afam_project/model/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:math';
import '../constant.dart';
import '../widget/pop_over.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showBal = false;

  @override
  void initState() {
    _fetchUser();

    super.initState();
  }
  String id;
  List<Map> list =[];
  List itemCount =[];
  bool isLoading = true;
  int MAX = 5;
  @override
  Widget build(BuildContext context) {
    final  String name = Provider.of<FirstProvider>(context).name;
    final  double amount =Provider.of<FirstProvider>(context).amount;
    return Scaffold(
      body: isLoading ?Center(child: Constant().spinKit,):SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Good Morning ${name.split(" ").elementAt(0) ?? ""}",style: GoogleFonts.ptSerif(
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
                    height: 190,
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
                                  onPressed: (){
                                    uploadData(amount);
                                  },
                                  color: Colors.white,
                                  child: Text("Mine FSNT",style: GoogleFonts.nunitoSans(
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  WithDraw(currentEarning: 90)));
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
                itemCount.isEmpty ? Container(child: Center(child: Text("No history yet",style: GoogleFonts.ptSans(fontSize: 17),)),):ListView.builder(
                 physics: const NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                   itemCount:  itemCount.length,
                   itemBuilder:(context,i){
                   if(i== 0){
                     return Constant().container();
                   }
                 return  ListTile(
                   onTap: (){
                     itemCount[i]["RefUserName"] == null ? null: _handleFABPressed(name: itemCount[i]["RefUserName"],amount: itemCount[i]["amount"],date: itemCount[i]["date"]);
                   },
                   title: Text(itemCount[i]['tittle'], style: GoogleFonts.ptSerif(fontSize: 16,letterSpacing: 0.2),),
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
                  title: Text("Referal name"),
                  trailing: Text(name,style: GoogleFonts.poppins(fontSize: 16.5,letterSpacing: 0.2)),
                ),
                Divider(),
                ListTile(
                  title: Text("Amount"),
                  trailing: Text("${amount.toString()} FSNT",style: GoogleFonts.roboto(fontSize: 17)),
                ),
                ListTile(
                  title: Text("Date"),
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
      });
    }
  void uploadData(double amount)async{
    final String referralId = Provider.of<FirstProvider>(context,listen: false).referralId??'';
    final String userId = Provider.of<FirstProvider>(context,listen: false).userId;
    final String name = Provider.of<FirstProvider>(context,listen: false).name;
    double addAmount = 0.8;
    print(referralId);
    double addRefAmount = 0.2;
    var datetime = formatDate(DateTime.now() ?? '', [d, '-', M, '-', yyyy]).toString();
    var user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> user1 = {"mineId": Provider.of<FirstProvider>(context,listen: false).mineID + 1 ,"date": datetime, "amount": 0.80,"tittle":"Mining Successful"};
    FirebaseFirestore.instance.collection("users").doc(user.uid).update({'list': FieldValue.arrayUnion([user1]),"amount":amount + addAmount,"mineId": 1 }).then((value) {
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
  }


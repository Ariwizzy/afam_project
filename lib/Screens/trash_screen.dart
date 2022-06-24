import 'package:afam_project/model/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class TrashScreen extends StatefulWidget {
  const TrashScreen({Key key}) : super(key: key);

  @override
  _TrashScreenState createState() => _TrashScreenState();
}
 String refId;
  bool idCheck = false;
class _TrashScreenState extends State<TrashScreen> {
  @override
  Widget build(BuildContext context) {
     refId = Provider.of<FirstProvider>(context).userId;
    return Scaffold(
      appBar: AppBar(
      ),
      body: GestureDetector(
          onTap: ands,
          child: const Center(child: Text('check Id'),)),
    );
  }
  void ands()async{
    try{
      await FirebaseFirestore.instance.collection("users").where(FieldPath.documentId, isNotEqualTo: "daVywvOmhdCJWxTWt9DisoZTgz2").get().then((value) {
        for (var element in value.docs) {
          if(element.id == null){
            print('null');
          } else {
            print("done");
          }
        }
      });
    }on FirebaseException catch(e){
      print(e.toString());
    }

  }
  void checkData()async{
    print("pp");
    await FirebaseFirestore.instance.collection("users").get().then(
          (value) {
        for (var element in value.docs) {
            if(element.id.substring(0,6) == refId){
              print(element.id);
            }
          }
      },
    );
  }
}

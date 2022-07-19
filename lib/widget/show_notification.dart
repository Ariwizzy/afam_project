import 'package:afam_project/utilities/notification_service.dart';
import 'package:afam_project/widget/notification_payload.dart';
import 'package:flutter/material.dart';
class ShowNotification extends StatefulWidget {
  const ShowNotification({Key key}) : super(key: key);

  @override
  _ShowNotificationState createState() => _ShowNotificationState();
}

class _ShowNotificationState extends State<ShowNotification> {
  LocalNotificationService service;
  @override
  void initState() {
   service = LocalNotificationService();
   service.intialize();
   listenToNofification();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(onPressed: ()async{
            await service.showNotification(id: 3, title: "notification tittle", body: "notification Body");
          },child: const Text("Show notification"),),
          RaisedButton(onPressed: ()async{
            await service.showScheduleNotification(seconds: 5,id: 2, title: "notification tittle", body: "notification Body");
          },child: Text("Show notification"),),
          RaisedButton(onPressed: ()async{
            await service.showNotificationWithPayload(id: 1, title: "notification tittle", body: "notification Body",payload: "men i did it");

          },child: Text("Show notification"),),
        ],
      ),
    );
  }
  void listenToNofification(){
    service.onNotificationClick.stream.listen(onNotificationListener);
  }

  void onNotificationListener(String payload) {
    if(payload != null  &&payload.isNotEmpty){
      print("payload $payload");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationPayload(text: payload,)));
    }
  }
}

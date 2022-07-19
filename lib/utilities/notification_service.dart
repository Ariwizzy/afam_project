import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart'as tz;
import 'package:rxdart/subjects.dart';
class LocalNotificationService{
  LocalNotificationService();
  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> onNotificationClick = BehaviorSubject();
  Future<void> intialize() async{
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@drawable/ic_launcher");
     IOSInitializationSettings iosInitializationSettings =
    IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );
     final InitializationSettings settings = InitializationSettings(
       android: androidInitializationSettings,
       iOS: iosInitializationSettings,
     );
     await _localNotificationService.initialize(settings,onSelectNotification: onSelectNotification);
  }
  Future<NotificationDetails> _notificationDetails() async{
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "channel_id",
      "channel_name",
      channelDescription: "description",
      importance: Importance.max,
      playSound: true,
      priority: Priority.max,
    );
    const IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    return const NotificationDetails(android: androidNotificationDetails,iOS: iosNotificationDetails);
  }


  Future<void> showNotification({
    @required int id,
    @required String title,
    @required String body,
   })async{
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }


  Future<void> showScheduleNotification({
    @required int id,
    @required String title,
    @required String body,
    @required int seconds,
  })async{
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(id, title, body, tz.TZDateTime.from(DateTime.now().add(Duration(minutes: seconds)), tz.local),details,
    androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showNotificationWithPayload({
    @required int id,
    @required String body,payload,title,
  })async{
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details,payload: payload);
  }
  void onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    print("id $id");
  }

  void onSelectNotification(String payload) {
    print("payload $payload");
    if(payload != null && payload.isNotEmpty){
      onNotificationClick.add(payload);
    }
  }
}
import 'package:afam_project/Screens/email_verif.dart';
import 'package:afam_project/Screens/homeScreen.dart';
import 'package:afam_project/model/provider.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'Screens/intro.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {x
//   await Firebase.initializeApp();
//   print('A bg message just showed up :  ${message.messageId}');
// }
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'This channel is used for important notifications.', // description
//     importance: Importance.high,
//     playSound: true);
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var token = localStorage.getString("userData");
  if(token == null){
    runApp(const MyApp(screenValue: 1,));
  }else {
    //Navigate to Dashboard.
    runApp(const MyApp(screenValue: 0,));
  }
}
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
class MyApp extends StatefulWidget {
  final int screenValue;
  const MyApp({Key key, this.screenValue}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    initSDK();
    super.initState();
  }
  void initSDK()async{
    await AppLovinMAX.initialize('x6gMETQNwzIUvW8N99eEUeP-kbsQpKURCmwMHNF0xPT-pBZ_TV8vxrw1BIQ7twWqTzEAhecwNHgF6LNH7THhL8');
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>FirstProvider(),
      child:     MaterialApp(
        title: 'Fist Network',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Colors.white,
              titleTextStyle: GoogleFonts.ptSerif(
                color: const Color(0xff3A4191),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5
              ),
              elevation: 0,
              actionsIconTheme: const IconThemeData(
                  color:  Color(0xff3A4191)
              ) ,
              iconTheme: const IconThemeData(
                  color:  Color(0xff3A4191)
              )
          ),
          primarySwatch: Colors.blue,
        ),
        home: widget.screenValue ==0? const Homescreen():const IntroScreen(),
      ),
    );
  }
}



// import 'package:afam_project/delete_later/two.dart';
// import 'package:afam_project/utilities/local_notification.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// import 'delete_later/one.dart';
//
//
// ///Receive message when app is in background solution for on message
// Future<void> backgroundHandler(RemoteMessage message) async{
//   print(message.data.toString());
//   print(message.notification.title);
// }
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//       routes: {
//         "red": (_) => One(),
//         "green": (_) => Two(),
//       },
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key,  this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     LocalNotificationService.initialize(context);
//
//     ///gives you the message on which user taps
//     ///and it opened the app from terminated state
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if(message != null){
//         final routeFromMessage = message.data["route"];
//
//         Navigator.of(context).pushNamed(routeFromMessage);
//       }
//     });
//
//     ///forground work
//     FirebaseMessaging.onMessage.listen((message) {
//       if(message.notification != null){
//         print(message.notification.body);
//         print(message.notification.title);
//       }
//
//       LocalNotificationService.display(message);
//     });
//
//     ///When the app is in background but opened and user taps
//     ///on the notification
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       final routeFromMessage = message.data["route"];
//
//       Navigator.of(context).pushNamed(routeFromMessage);
//     });
//
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Center(
//             child: Text(
//               "You will receive message soon",
//               style: TextStyle(fontSize: 34),
//             )),
//       ),
//     );
//   }
// }
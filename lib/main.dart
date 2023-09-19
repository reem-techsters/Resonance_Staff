import 'dart:convert';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/user_model.dart';
import 'package:attendance/routes/getRoutes.dart';
import 'package:attendance/view/pages/today_attendance.dart';
//import 'package:attendance/view/widgets/buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/model_state/user_model_ctrl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// ...
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:hive/hive.dart';
// import 'package:socket_io_client/socket_io_client.dart';

Future<bool> checkSF(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool CheckValue = prefs.containsKey(key);
  if (CheckValue) {
    var obj = jsonDecode(prefs.getString("userModel")!);
    UserModel userModel = UserModel.fromJson(obj);
    final stateUserModelCtrl = Get.put(UserModelController());
    await stateUserModelCtrl.updateUserModel(userModel);
  }
  // else{
  //     FirebaseMessaging messaging = FirebaseMessaging.instance;
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print("fcm: $fcmToken");
  //   UpdateFcmApi(fcm: fcmToken!,phone: ).callApi();
  // }

  return CheckValue;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  //print('User granted permission: ${settings.authorizationStatus}_ $fcmToken');

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    '0',
    'channel name',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.notification!.title.toString()}');

    if (message.notification != null) {
      print(
          'Message also contained a notification: ${message.notification.toString()}');
      await flutterLocalNotificationsPlugin.show(
        1,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    }
  });
  bool loogedIn = await checkSF("userModel");

  LicenseRegistry.addLicense(() async* {
    final licenseLato =
        await rootBundle.loadString('assets/google_fonts/Lato/OFL.txt');
    final licensePoppins =
        await rootBundle.loadString('assets/google_fonts/Poppins/OFL.txt');
    final licenseRobo =
        await rootBundle.loadString('assets/google_fonts/Roboto/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], licenseLato);
    yield LicenseEntryWithLineBreaks(['google_fonts'], licensePoppins);
    yield LicenseEntryWithLineBreaks(['google_fonts'], licenseRobo);
  });

  // var box = await Hive.openBox('userModel');
  // IO.Socket socket = IO.io('ws://socketsbay.com/wss/v2/2/demo/');
  // print(socket.connected);
  // socket.onConnect((_) {
  //   print('connect');
  //   socket.emit('msg', 'test');
  // });
  // socket.on('event', (data) => print(data));
  // socket.onDisconnect((_) => print('disconnect'));
  // socket.on('fromServer', (_) => print(_));

  runApp(GetMaterialApp(
    title: 'Redo Bridge - Staff',
    onGenerateRoute: GetRoutes.generateRoutes,
    routes: {
      'todayAttendance' : (context) => TodayAttendance(),
    },
    theme: ThemeData(
      //can be omitted if you want the default themep
      primarySwatch: Colors.blue,
    ),
    initialRoute:
        loogedIn ? 'todayAttendance' : GetRoutes.pageLogin,
    debugShowCheckedModeBanner: false,
  ));
}

// void hiveRegister()async{
//   await Hive.initFlutter();
//   Hive.registerAdapter(UserModelAdapter());
//   await Hive.openBox<UserModel>('userModelBox');
// // }
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
// class _MyAppState extends State<MyApp> {
// @override
// void initState() {
//   super.initState();
// }
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return  GetMaterialApp(
//       title: 'Flutter Demo',
//       onGenerateRoute: GetRoutes.generateRoutes,
//       // initialRoute: loogedIn?GetRoutes.pageTodayAttendance: GetRoutes.pageLogin,
//     );
//   }
// @override
// void dispose(){
//   }
// }

class Demo extends StatelessWidget {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Strings.bgColor,
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Buttons.blueButtonReason((){}, "Accept"),
              // Buttons.redButtonReason((){}),
              // Buttons.whiteButtonRouded((){},"Verify"),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/services/auth.dart';
import 'package:my_safe_campus/views/login.dart';
import 'package:my_safe_campus/views/notifications_page.dart';
import 'package:my_safe_campus/widgets/custom_bottom_navigation.dart';
import 'package:my_safe_campus/widgets/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/onboarding.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

int? initScreen;
Future<void> main() async {
  //initialize the firebase connection
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);

  // Setup notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  MyApp({Key? key}) : super(key: key) {

    CustomNotification customNotification = CustomNotification();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // RemoteNotification notification = message.notification!;
      // AndroidNotification android = message.notification!.android!;
      if (message.notification != null) {
        customNotification.showNotification(
          remoteNotification: message.notification!
        );
      }
    });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //       // context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [Text(notification.body)],
    //               ),
    //             ),
    //           );
    //         });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MySafe Campus',
      initialRoute:
          initScreen == 0 || initScreen == null ? '/onboard' : '/login',
      routes: {
        '/onboard': (context) => const Onboarding(),
        '/login': (context) => const Login(),
        '/home': (context) => CustomBottomNavigation(auth: Auth(),),
        '/notifications': (context) => const NotificationScreen(),
      },
    );
  }
}

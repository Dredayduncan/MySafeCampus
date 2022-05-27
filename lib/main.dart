import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/services/auth.dart';
import 'package:my_safe_campus/views/chat_screen.dart';
import 'package:my_safe_campus/views/login.dart';
import 'package:my_safe_campus/views/notifications_page.dart';
import 'package:my_safe_campus/widgets/custom_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/onboarding.dart';

int? initScreen;
Future<void> main() async {
  //initialize the firebase connection
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

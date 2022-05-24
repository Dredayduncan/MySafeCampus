import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/views/landingPage.dart';
import 'package:my_safe_campus/views/login.dart';

Future<void> main() async {
  //initialize the firebase connection
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MySafe Campus',
      home: Login(),
    );
  }
}

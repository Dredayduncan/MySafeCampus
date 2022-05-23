import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/views/homeScreen.dart';
import 'package:my_safe_campus/views/login.dart';
import '../services/auth.dart';

class LandingPage extends StatefulWidget {

  LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Auth auth = Auth();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          //Check if the user has signed in
          if (user == null) {
            //Display the signIn page if the user has not logged in
            return Login(auth: auth,);
          }

          // Redirect the user to the main screen if they're logged in already
          return HomeScreen(auth: auth);
          }

          //Display a loading UI while the data is loading
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
      }
    );

  }
}

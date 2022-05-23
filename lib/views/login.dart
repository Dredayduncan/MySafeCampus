import 'package:flutter/material.dart';
import 'package:my_safe_campus/services/auth.dart';

class Login extends StatefulWidget {
  final Auth? auth;
  const Login({Key? key, this.auth}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container();
  } 
}

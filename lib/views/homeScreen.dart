import 'package:flutter/material.dart';
import 'package:my_safe_campus/services/auth.dart';

class HomeScreen extends StatefulWidget {
  final Auth? auth;
  const HomeScreen({Key? key, required this.auth}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

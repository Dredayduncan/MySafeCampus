import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/services/auth.dart';

import '../widgets/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  final Auth? auth;
  const HomeScreen({Key? key, required this.auth}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            color: const Color(0xFF922E2E),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "We’re here for \nyou",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kWhiteTextColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Arcu auctor mattis neque, sed vel turpis posuere mi tortor. Amet eget sem vel amet. ",
                    style: TextStyle(
                      fontSize: 14,
                      color: kWhiteTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          const Text(
            "Click the button to sound an alarm and alert emergency contacts.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kDarkTextColor,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Container(
              decoration: BoxDecoration(),
            ),
          )
        ],
      ),
    );
  }
}

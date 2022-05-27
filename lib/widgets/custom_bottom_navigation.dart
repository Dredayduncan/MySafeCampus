import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/views/homeScreen.dart';
import '../services/auth.dart';
import '../views/blogsandarticles.dart';
import '../views/emergency_services.dart';
import '../views/history.dart';
import '../views/issue_reporting.dart';
import 'package:my_safe_campus/services/auth.dart';

class CustomBottomNavigation extends StatefulWidget {
  final Auth auth;
  const CustomBottomNavigation({Key? key, required this.auth}) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  // This widget is the root of your application.
  int _currentIndex = 0;

  late List screens;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screens = [
      HomeScreen(auth: widget.auth),
      const Articles(),
      Report(auth: widget.auth,),
      EmergencyServices(auth: widget.auth),
      History(auth: widget.auth),
      // const ProfilePage(),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: kAccentColor,
        activeColor: Colors.white,
        inactiveColor: const Color(0xFFc18a8b),
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() {
          _currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
              size: 24,
            ),
            // label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.newspaper,
              size: 24,
            ),
            // label: 'Charities',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.circleExclamation,
              size: 24,
            ),
            // label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.starOfLife,
              size: 24,
            ),
            // label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.clockRotateLeft,
              size: 24,
            ),
            // label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: screens[_currentIndex],
          );
        });
      },
    );
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/services/auth.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/notification.dart';
import 'package:telephony/telephony.dart';

class HomeScreen extends StatefulWidget {
  final Auth? auth;
  const HomeScreen({Key? key, required this.auth}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CustomNotification _notification;
  final telephony = Telephony.instance;

  _HomeScreenState(){

    //TO DO
    /*Make a check for the user being an emergency service and assign
    a push token so they can receive push notifications
     */
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.requestPermission();

    firebaseMessaging.getToken().then((token) {
      if (token != null){
        widget.auth!.updateData(userID: widget.auth!.currentUser!.uid, token: token);
      }
    });

    _notification = CustomNotification(
    //     onClick: (payload) async {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => HomeScreen(auth: widget.auth)));
    // }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            color: kAccentColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "We’re here for \nyou",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kWhiteTextColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Arcu auctor mattis neque, sed vel turpis posuere mi tortor. Amet eget sem vel amet. ",
                    style: TextStyle(
                      fontFamily: 'Quattrocentro',
                      fontSize: 16,
                      color: kWhiteTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Click the button to sound an alarm and alert emergency contacts.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Quattrocentro',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kDarkTextColor,
              ),
            ),
          ),
          SizedBox(height: 90),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 150,
              height: 150,
              child: ElevatedButton(
                onPressed: () {
                  _sendSMS();
                  // _notification.showNotificationToUser(
                  //   title: "Alert Sent!",
                  //   body: "Emergency contacts have received your alert"
                  // );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(kDefaultBackground),
                  shadowColor: MaterialStateProperty.all(
                      kDefaultBackground.withOpacity(1)),
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  elevation: MaterialStateProperty.all(15),
                ),
                child: const Iconify(
                  Ic.baseline_crisis_alert,
                  size: 70,
                  color: kWhiteTextColor,
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  // Send SMS when the emergency button is clicked
  _sendSMS() async {
    telephony.sendSms(to: "0206742892", message: "hello");
  }
}

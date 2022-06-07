import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/services/auth.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:my_safe_campus/services/user_history.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/notification.dart';
import 'package:sms_advanced/sms_advanced.dart';

class HomeScreen extends StatefulWidget {
  final Auth? auth;
  const HomeScreen({Key? key, required this.auth}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CustomNotification _notification;

  _HomeScreenState(){

    // Assign a push token to every user to be able to receive push notifications
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
      appBar: CustomAppBar(
        auth: widget.auth,
      ),
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
          const SizedBox(height: 90),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 150,
              height: 150,
              child: ElevatedButton(
                onPressed: () {
                  _sendSMS();
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
    // Instantiate user history object
    UserHistory historyManager = UserHistory(userID: widget.auth!.currentUser!.uid);

    // Instantiate sender object
    SmsSender sender = SmsSender();

    // Get the emergency contacts to send to
    String address = "0206742892, 0202220086";

    // Create the alert message
    SmsMessage message = SmsMessage(address, 'Hello flutter world!');

    // Add a listener to check when the message has been sent or not
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        historyManager.updateEmergencyButtonHits(status: "Sent");
        _notification.showNotificationToUser(
            title: "Alert Sent!",
            body: "Emergency contacts have received your alert"
        );
      } else if (state == SmsMessageState.Delivered) {
        historyManager.updateEmergencyButtonHits(status: "Delivered");
        _notification.showNotificationToUser(
            title: "Alert Sent!",
            body: "Emergency contacts have received your alert"
        );
      }
      else {
        historyManager.updateEmergencyButtonHits(status: "Failed");
        showDialog(
          context: context,
          builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'The alert message could not be sent. Please check if you have credit and try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          )
        );
      }
    });
    sender.sendSms(message);
  }
}

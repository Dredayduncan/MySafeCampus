import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/services/auth.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import '../widgets/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  final Auth? auth;
  const HomeScreen({Key? key, required this.auth}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // set up notifications by instantiate the notification object
  late FlutterLocalNotificationsPlugin _notifications;

  _HomeScreenState() {
    // set up notifications
    _notifications = FlutterLocalNotificationsPlugin();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();

    const settings = InitializationSettings(
      android: android,
      iOS: iOS
    );

    _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(auth: widget.auth))
        );
      }
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
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 150,
              height: 150,
              child: ElevatedButton(
                onPressed: () {
                  _showNotification(
                      title: "Alert Sent!",
                      body: "Emergency contacts have received your alert."
                  );
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

  // The function responsible for sending push notifications
  Future _showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async => _notifications.show(
    id,
    title,
    body,
    await _notificationDetails(), //Await because this is an async function
  );

  Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'Local Notification',
        channelDescription: "Channel Description",
        importance: Importance.high,
      ),
      iOS: IOSNotificationDetails(),
    );
  }
}

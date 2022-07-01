import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/services/auth.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:my_safe_campus/services/emergency_contacts.dart';
import 'package:my_safe_campus/services/user_history.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/notification.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  final Auth? auth;
  const HomeScreen({Key? key, required this.auth}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CustomNotification _notification;

  _HomeScreenState() {
    // Assign a push token to every user to be able to receive push notifications
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.requestPermission();

    firebaseMessaging.getToken().then((token) {
      if (token != null) {
        widget.auth!
            .updateData(userID: widget.auth!.currentUser!.uid, token: token);
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
                    "Welcome to My Safe Campus. This app serves as a channel for reporting sexual misconduct and other sexually inappropriate activities.  ",
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
    UserHistory historyManager =
        UserHistory(userID: widget.auth!.currentUser!.uid);

    EmergencyContacts emergency =
        EmergencyContacts(currentUserID: widget.auth!.currentUser!.uid);

    Map<String, dynamic>? currentUser =
        await emergency.getContactInfo(uid: widget.auth!.currentUser!.uid);

    List<String> emergencyContacts =
        await emergency.getEmergencyContactNumbers();

    var location = await _getLocation();

    if (location == false){
      return;
    }

    Map data = {
      "sender": currentUser!['name'].split(" ")[0],
      "message":
      "This is a MySafeCampus Emergency Alert from ${currentUser['name']}. I need help! Find me at https://maps.google.com/?q=${location.latitude},${location.longitude}",
      "recipients": emergencyContacts
    };

    var url = Uri.parse("https://sms.arkesel.com/api/v2/sms/send");
    var response = await http.post(url,
        headers: {
          "api-key": SMSAPIKEY,
          "Content-Type": "application/json",
        },
        body: jsonEncode(data));

    if (jsonDecode(response.body)['status'] == "success") {
      historyManager.updateEmergencyButtonHits(status: "Sent");
      _notification.showNotificationToUser(
          title: "Alert Sent!",
          body: "Emergency contacts have received your alert");
    } else {
      historyManager.updateEmergencyButtonHits(status: "Failed");
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'The alert message could not be sent. Please check if you have credit and try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        )
      );
    }

    return response.body;
  }

  _getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled){
      _serviceEnabled = await location.requestService();

      if (!_serviceEnabled){
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Error'),
              content: const Text(
                'Location service could not be enabled.'
                    'Please try again and enable location permission.'
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            )
        );

        return false;
      }
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Error'),
                  content: const Text(
                      'Emergency Alert could not be sent because location permissions have not been granted.'
                          'Please try again and enable location permission.'
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                )
        );

        return false;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }
}

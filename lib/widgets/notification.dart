import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "dart:convert" show json;
import "package:http/http.dart" as http;

class CustomNotification{

  // set up notifications by instantiate the notification object
  final FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final String _endpoint = "https://fcm.googleapis.com/fcm/send";
  final String _contentType = "application/json";
  final String _authorization =
  "key=AAAAvxAX6gE:APA91bEB3Vl2o3cjX9KLRmSqwsP4-m0QdLbKUxyVz5J3PzwKgFY6gJJ27A4P-_W4dIGH-CGRMwRFGE902JKSiKd9wdYWjNKavI81iX3Qh-f6u1iGE2icR1fynTtcwWQZQNUhoI2JbNHg";

  CustomNotification({onClick}){
    // set up notifications
    // _notifications = FlutterLocalNotificationsPlugin();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: iOS);

    notifications.initialize(settings, onSelectNotification: onClick);
  }

  // The function responsible for sending push notifications
  Future showNotification({
    int id = 0,
    // required String title,
    // required String body,
    required RemoteNotification remoteNotification
  }) async =>
    notifications.show(
      id,
      remoteNotification.title,
      remoteNotification.body,
      await _notificationDetails(), //Await because this is an async function
  );

  // The function responsible for sending local notifications
  Future showNotificationToUser({
    int id = 0,
    required String title,
    required String body,
  }) async =>
      notifications.show(
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
        playSound: true,
        enableVibration: true,
      ),
      iOS: IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        subtitle: 'MySafe Campus',
      ),
    );
  }

// Send  notification to recipient's device
  Future<http.Response> sendNotification({
    required String to,
    required String title,
    required String body,
  }) async {
    try {
      final dynamic data = json.encode(
        {
          "to": to,
          "priority": "high",
          "notification": {
            "title": "title",
            "body": "body",
          },
          "content_available": true
        },
      );
      http.Response response = await http.post(
        Uri.parse(_endpoint),
        body: data,
        headers: {
          "Content-Type": _contentType,
          "Authorization": "key=AAAAvxAX6gE:APA91bEB3Vl2o3cjX9KLRmSqwsP4-m0QdLbKUxyVz5J3PzwKgFY6gJJ27A4P-_W4dIGH-CGRMwRFGE902JKSiKd9wdYWjNKavI81iX3Qh-f6u1iGE2icR1fynTtcwWQZQNUhoI2JbNHg"
        },
      );

      // print(response.body);
      return response;
    } catch (error) {
      throw Exception(error);
    }
  }

}
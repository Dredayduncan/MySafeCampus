import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:my_safe_campus/model/user_model.dart';
import 'package:my_safe_campus/services/emergency_contacts.dart';
import 'package:my_safe_campus/services/user_history.dart';
import 'package:my_safe_campus/views/chat_screen.dart';

import '../constants.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String label;
  final bool? notif;
  String? currentUserID;
  String messageID;
  String? respondentID;
  bool? personalContact;
  String? pushToken;

  CustomListTile({
    Key? key,
    this.messageID = "",
    required this.title,
    required this.subtitle,
    required this.label,
    this.pushToken,
    this.notif = false,
    this.personalContact = false,
    this.currentUserID,
    this.respondentID
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          height: 70.0,
          width: 60.0,
          color: kDefaultBackground,
          child: Center(
              child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Quattrocentro',
              fontSize: 20.0,
            ),
          )),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'Poppins', fontSize: 14.0, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontFamily: 'Quattrocentro'),
      ),
      trailing: notif == false
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.call),
                  iconSize: 20.0,
                  color: kDefaultBackground,
                  onPressed: () {
                    _callNumber(subtitle).then((value) {
                      if (value == false) {
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Error'),
                            content: Text('Unable to connect to $title'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    });
                  },
                ),
                personalContact == true
                  ? IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    iconSize: 20.0,
                    color: kDefaultBackground,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext
                        context) =>
                          AlertDialog(
                            title: const Text(
                                'Delete Contact'),
                            content:
                            const Text(
                                'Are you sure you want to delete this contact?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(
                                    context,
                                    'Cancel'),
                                child: const Text(
                                    'Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  EmergencyContacts emergency = EmergencyContacts(currentUserID: currentUserID!);
                                  emergency.removeEmergencyContact(name: title, contact: subtitle).then((value) {
                                    if (value == false){
                                      Navigator.pop(context, 'Delete');
                                      return showDialog(
                                          context: context,
                                          builder: (BuildContext
                                          context) =>
                                              AlertDialog(
                                                title: const Text(
                                                    'Error'),
                                                content:
                                                const Text(
                                                    'Contact could not be deleted.'),
                                                actions: <
                                                    Widget>[
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(
                                                        context,
                                                        'OK'),
                                                    child: const Text(
                                                        'OK'),
                                                  ),
                                                ],
                                              ));
                                    }
                                    else {
                                      Navigator.pop(context, 'Delete');
                                      return showDialog(
                                          context: context,
                                          builder: (BuildContext
                                          context) =>
                                              AlertDialog(
                                                title: const Text(
                                                    'Contact Deleted'),
                                                content:
                                                const Text(
                                                    'The contact has been successfully deleted.'),
                                                actions: <
                                                    Widget>[
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(
                                                        context,
                                                        'OK'),
                                                    child: const Text(
                                                        'OK'),
                                                  ),
                                                ],
                                              ));
                                    }
                                  });

                                },
                                child: const Text(
                                    'Delete'),
                              )
                            ],
                          )
                      );
                    },
                  )
                  : IconButton(
                    icon: const Icon(Icons.chat),
                    iconSize: 20.0,
                    color: kDefaultBackground,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            respondentName: title,
                            senderID: currentUserID!,
                            messageID: messageID,
                            respondentID: respondentID!,
                            pushToken: pushToken!
                          )
                        )
                      );
                    },
                  ),
              ],
            )
          : SizedBox(width: 0),
    );
  }

  Future<bool?> _callNumber(String number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);

    // Update the database with the call attempt
    UserHistory historyManager = UserHistory(userID: currentUserID!);
    historyManager.updateUserCalls(calleeName: title, status: res == true ? "Success" : "Failed");

    return res;
  }
}

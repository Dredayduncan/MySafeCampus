import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
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
                personalContact == true ? const SizedBox.shrink() : IconButton(
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
    return res;
  }
}

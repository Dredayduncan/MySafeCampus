import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/widgets/custom_appbar.dart';
import 'package:my_safe_campus/widgets/custom_list_tile.dart';
import '../services/auth.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class EmergencyServices extends StatefulWidget {
  final Auth auth;
  const EmergencyServices({Key? key, required this.auth}) : super(key: key);

  @override
  State<EmergencyServices> createState() => _EmergencyServicesState();
}

class _EmergencyServicesState extends State<EmergencyServices> {
  List contacts = [
    {"label": "FR", "title": "First Respondent Team", "subtitle": "0322043112", "respondentID": "2"},
    {"label": "FR", "title": "Andrew", "subtitle": "0322043112", "respondentID": "1"},
    {"label": "FR", "title": "Akwasi", "subtitle": "0322043112", "respondentID": "3"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Emergency Services",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final contact = await FlutterContactPicker.pickPhoneContact();
          } on UserCancelledPickingException catch (e) {
            if (e == 'CANCELLED') {
              return;
            }
            return;
          }
        },
        backgroundColor: kDefaultBackground,
        elevation: 10,
        child: const FaIcon(FontAwesomeIcons.addressBook),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: CustomListTile(
              currentUserID: widget.auth.currentUser!.uid,
              title: contacts[index]["title"],
              label: contacts[index]["label"],
              subtitle: contacts[index]["subtitle"],
              messageID: widget.auth.currentUser!.uid + contacts[index]["respondentID"],
              respondentID: contacts[index]["respondentID"]

            ),
          );
        },
      ),
    );
  }
}

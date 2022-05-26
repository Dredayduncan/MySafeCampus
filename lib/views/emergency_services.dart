import 'package:flutter/material.dart';
import 'package:my_safe_campus/widgets/custom_appbar.dart';
import 'package:my_safe_campus/widgets/custom_list_tile.dart';

class EmergencyServices extends StatefulWidget {
  const EmergencyServices({Key? key}) : super(key: key);

  @override
  State<EmergencyServices> createState() => _EmergencyServicesState();
}

class _EmergencyServicesState extends State<EmergencyServices> {
  List contacts = [
    {"label": "FR", "title": "First Respondent Team", "subtitle": "0322043112"},
    {"label": "FR", "title": "Andrew", "subtitle": "0322043112"},
    {"label": "FR", "title": "Akwasi", "subtitle": "0322043112"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Emergency Services",
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: CustomListTile(
              title: contacts[index]["title"],
              label: contacts[index]["label"],
              subtitle: contacts[index]["subtitle"],
            ),
          );
        },
      ),
    );
  }
}

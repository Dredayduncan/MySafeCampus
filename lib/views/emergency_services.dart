import 'package:flutter/material.dart';
import 'package:my_safe_campus/widgets/custom_appbar.dart';
import 'package:my_safe_campus/constants.dart';

class EmergencyServices extends StatefulWidget {
  const EmergencyServices({Key? key}) : super(key: key);

  @override
  State<EmergencyServices> createState() => _EmergencyServicesState();
}

class _EmergencyServicesState extends State<EmergencyServices> {
  List contacts = [
    {"label": "FR", "title": "First Respondent Team", "subtitle": "0322043112"},
    {"label": "FR", "title": "First Respondent Team", "subtitle": "0322043112"},
    {"label": "FR", "title": "First Respondent Team", "subtitle": "0322043112"},
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
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    height: 70.0,
                    width: 60.0,
                    color: kDefaultBackground,
                    child: Center(
                        child: Text(
                      contacts[index]["label"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quattrocentro',
                        fontSize: 20.0,
                      ),
                    )),
                  ),
                ),
                title: Text(
                  contacts[index]["title"],
                  style: const TextStyle(fontFamily: 'Quattrocentro'),
                ),
                subtitle: Text(
                  contacts[index]['subtitle'],
                  style: const TextStyle(fontFamily: 'Quattrocentro'),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20.0,
                  color: kDefaultBackground,
                ),
              ),
            );
          }),
    );
  }
}

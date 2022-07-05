import 'package:flutter/material.dart';

import '../constants.dart';

class CustomHistoryTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  String? reportStatus;
  String? alertStatus;
  String? callStatus;

  CustomHistoryTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.reportStatus,
    this.alertStatus,
    this.callStatus
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          height: 50.0,
          width: 50.0,
          color: kAccentColor.withOpacity(0.88),
          child: Center(
            child: Icon(
              icon,
              color: const Color(0xFFFFFFFF),
            )
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14.0,
            fontWeight: FontWeight.w600
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontFamily: 'Quattrocentro',
          color: reportStatus != null
            ? reportStatus == "Resolved"
              ? success
              : reportStatus == "Pending"
                ? pending
                : kAccentColor
            :  alertStatus != null
              ? alertStatus == "Sent"
                ? success
                : kAccentColor
              : callStatus != null
                ? callStatus == "Success"
                  ? success
                  : kAccentColor
                : null
        ),
      ),
    );
    print(reportStatus);
  }
}

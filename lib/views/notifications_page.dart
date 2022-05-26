import 'package:flutter/material.dart';
import 'package:my_safe_campus/widgets/custom_appbar.dart';
import 'package:my_safe_campus/widgets/custom_list_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notifications',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CustomListTile(
              title: 'Alert',
              subtitle: 'Emergency alert sent',
              label: 'N',
              notif: true,
            ),
            CustomListTile(
              title: 'Alert',
              subtitle: 'Emergency alert sent',
              label: 'N',
              notif: true,
            ),
          ],
        ),
      ),
    );
  }
}

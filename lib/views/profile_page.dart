import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/views/login.dart';
import 'package:my_safe_campus/widgets/custom_appbar.dart';
import 'package:my_safe_campus/widgets/custom_list_tile.dart';
import '../services/auth.dart';

class ProfileScreen extends StatefulWidget {
  Auth? auth;

  ProfileScreen({Key? key, this.auth}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
        showNotif: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              // contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: kWhiteTextColor,
                ),
                backgroundColor: kDefaultBackground,
              ),
              title: Text('Username'),
              subtitle: Text('Contact'),
            ),
            ListTile(
              minLeadingWidth: 10,
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          widget.auth!.signOut().then((value) =>
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const Login())));
                        },
                        child: const Text('Logout'),
                      )
                    ],
                  ),
                );
              },
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

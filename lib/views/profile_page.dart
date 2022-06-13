import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/views/login.dart';
import 'package:my_safe_campus/widgets/custom_appbar.dart';
import '../services/auth.dart';

class ProfileScreen extends StatefulWidget {
  Auth? auth;

  ProfileScreen({Key? key, this.auth}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String email;

  Widget _currentPage = const Center(
    child: CircularProgressIndicator(
      color: kDefaultBackground,
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    // Get the data from the database
    DocumentSnapshot<Map<String, dynamic>> query = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(widget.auth!.currentUser!.uid)
        .get();

    // Get the user's data
    var data = query.data();

    username = data!['name'];
    email = data['email'];

    setState(() {
      _currentPage = buildContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Profile',
          showNotif: false,
        ),
        body: _currentPage);
  }

  Widget buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            // contentPadding: EdgeInsets.all(0),
            leading: const CircleAvatar(
              child: Icon(
                Icons.person,
                color: kWhiteTextColor,
              ),
              backgroundColor: kDefaultBackground,
            ),
            title: Text(username),
            subtitle: Text(email),
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
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                                (r) => false));
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
    );
  }
}

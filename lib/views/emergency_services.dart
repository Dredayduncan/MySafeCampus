import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/services/emergency_contacts.dart';
import 'package:my_safe_campus/widgets/custom_appbar.dart';
import 'package:my_safe_campus/widgets/custom_list_tile.dart';
import '../services/auth.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

import '../widgets/custom_tab_label.dart';

class EmergencyServices extends StatefulWidget {
  final Auth auth;
  const EmergencyServices({Key? key, required this.auth}) : super(key: key);

  @override
  State<EmergencyServices> createState() => _EmergencyServicesState();
}

class _EmergencyServicesState extends State<EmergencyServices> {
  late EmergencyContacts contacts;
  late List emergencyServices;

  @override
  void initState() {
    super.initState();
    contacts = EmergencyContacts(currentUserID: widget.auth.currentUser!.uid);
    generateEmergencyContacts();
  }

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
            await contacts.addEmergencyContact(
                name: contact.fullName!, contact: contact.phoneNumber!.number!);
          } on UserCancelledPickingException catch (e) {
            if (e == 'CANCELLED') {
              return;
            }
          }
        },
        backgroundColor: kDefaultBackground,
        elevation: 10,
        child: const FaIcon(FontAwesomeIcons.addressBook),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TabBar(
              labelColor: Color(0xFF1E1E1E),
              labelStyle: TextStyle(fontFamily: 'Quattrocentro'),
              indicator: BoxDecoration(
                color: kDefaultBackground,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              indicatorWeight: 2,
              indicatorPadding: EdgeInsets.only(top: 40),
              tabs: [
                Tab(
                  child: CustomTabLabel(label: "Ashesi"),
                ),
                Tab(
                  child: CustomTabLabel(label: "Personal"),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: emergencyServices.length,
                    itemBuilder: (BuildContext context, int index) {
                      return emergencyServices[index];
                    },
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: contacts.getUserEmergencyContacts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      //Check if an error occurred
                      if (snapshot.hasError) {
                        return const Text("Something went wrong");
                      }

                      // Check if the connection is still loading
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: kDefaultBackground,
                          ),
                        );
                      }

                      // Check if there has been no conversation between them
                      if (snapshot.data == null) {
                        return const Center(child: Text("Say Something."));
                      }

                      // Get the chats between the user and the respondent
                      var doc = snapshot.data as DocumentSnapshot;

                      try {
                        List userContacts = doc['emergencyContacts'];
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: userContacts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: CustomListTile(
                                currentUserID: widget.auth.currentUser!.uid,
                                title: userContacts[index]["name"],
                                label: "FR",
                                subtitle: userContacts[index]["contact"],
                                personalContact: true,
                              ),
                            );
                          },
                        );
                      } catch (error) {
                        return const SizedBox.shrink();
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  generateEmergencyContacts() async {
    emergencyServices = await contacts.getEmergencyContacts();
    setState(() {});
  }
}

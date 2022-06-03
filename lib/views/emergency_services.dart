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
  bool isEmergencyContact;

  EmergencyServices({
    Key? key,
    required this.auth,
    this.isEmergencyContact = false
  }) : super(key: key);

  @override
  State<EmergencyServices> createState() => _EmergencyServicesState();
}

class _EmergencyServicesState extends State<EmergencyServices> {
  late EmergencyContacts contacts;
  late List emergencyServices;
  Widget _emergencyServicePage = const Center(
    child:  CircularProgressIndicator(
      color: kDefaultBackground,
    ),
  );

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
      floatingActionButton: widget.isEmergencyContact == true
        ? null
        : FloatingActionButton(
          onPressed: () async {
            try {
              final contact = await FlutterContactPicker.pickPhoneContact();
              await contacts.addEmergencyContact(name: contact.fullName!, contact: contact.phoneNumber!.number!);
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
      body: widget.isEmergencyContact == true
        ? _emergencyServicePage
        : DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                labelColor: const Color(0xFF1E1E1E),
                labelStyle: const TextStyle(fontFamily: 'Quattrocentro'),
                indicator: const BoxDecoration(
                  color: kDefaultBackground,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                indicatorWeight: 2,
                indicatorPadding: const EdgeInsets.only(top: 40),
                tabs: [
                  const Tab(
                    child: CustomTabLabel(
                        label: "Ashesi"),
                  ),
                  Tab(
                    child: CustomTabLabel(
                        label: widget.isEmergencyContact == true ? "Users" : "Personal"),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _emergencyServicePage,
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: emergencyServices.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return emergencyServices[index];
                    //   },
                    // ),
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
                  ]
                )
              )
            ]
          )
        )
    );
  }

  generateEmergencyContacts() async {
    // await contacts.getChatList(emergencyContactID: widget.auth.currentUser!.uid);
    emergencyServices = widget.isEmergencyContact == true
        ? await contacts.getChatList(emergencyContactID: widget.auth.currentUser!.uid)
        : await contacts.getEmergencyContacts(isEmergencyContact: widget.isEmergencyContact);
    if (emergencyServices.isEmpty){
      setState(() {
        _emergencyServicePage = const Center(
          child: Text("You have no conversations"),
        );
      });
    }
    else{
      setState(() {
        _emergencyServicePage = ListView.builder(
          shrinkWrap: true,
          itemCount: emergencyServices.length,
          itemBuilder: (BuildContext context, int index) {
            return emergencyServices[index];
          },
        );
      });
    }
  }
}

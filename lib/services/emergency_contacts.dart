import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/widgets/custom_list_tile.dart';

class EmergencyContacts {
  final String currentUserID;

  EmergencyContacts({required this.currentUserID});

  // Get the user's timeline
  Future<List> getEmergencyContactIDs() async {
    List ids = [];

    //Get all the ids of emergency contacts and save in the ids list
    return FirebaseFirestore.instance
        .collection("emergencyContacts")
        .get()
        .then((value) async {
      List<DocumentSnapshot> allDocs = value.docs;

      // get the ids of the emergency contacts
      for (var element in allDocs) {
        Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;

        if (data != null && data['contactID'].id != currentUserID) {
          ids.add(data['contactID'].id);
        }
      }

      return ids;
    });
  }

  // Get the user's timeline
  Future<List> getEmergencyContacts({required isEmergencyContact}) async {
    List emergencyContacts = [];

    //Get all the ids of the emergency contacts
    List ids = await getEmergencyContactIDs();

    for (var id in ids) {
      var contactInfo = await getContactInfo(uid: id);

      emergencyContacts.add(Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: CustomListTile(
            currentUserID: currentUserID,
            title: contactInfo!["name"],
            label: "FR",
            subtitle: contactInfo["contact"],
            messageID: isEmergencyContact == false
                ? currentUserID + contactInfo["id"]
                : contactInfo["id"] + currentUserID,
            respondentID: contactInfo["id"],
            pushToken: contactInfo["pushToken"]),
      ));
    }
    return emergencyContacts;
  }

  // Get the emergency contacts the user has added
  Stream<DocumentSnapshot>? getUserEmergencyContacts() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .snapshots();
  }

  // Add an emergency contact
  Future<dynamic> addEmergencyContact({name, contact}) async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    return users
        .doc(currentUserID)
        .update({
          "emergencyContacts": FieldValue.arrayUnion([
            {
              "name": name,
              "contact": contact,
            }
          ])
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  // Get user's info
  Future<Map<String, dynamic>?> getContactInfo({uid}) async {
    // Get the data from the database
    DocumentSnapshot<Map<String, dynamic>> query =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    // Get the user's data
    var data = query.data();
    data?['id'] = uid;

    return data;
  }

  // Method to retrieve the user's that have messaged the emergency Contact

  Future<List> getChatList({required emergencyContactID}) async {

    // Get all the emergency contacts
    CollectionReference emergencyContacts = FirebaseFirestore.instance.collection("emergencyContacts");

    return await emergencyContacts
      .where('contactID', isEqualTo: FirebaseFirestore.instance.collection('users').doc(emergencyContactID))
      .get()
      .then((value) async {

      // Retrieve the list of users the emergency contact has conversations with
      List userChats = value.docs;

      // check if there are no conversations
      if (!userChats[0].data().containsKey("conversations")){
        return [];
      }

      List conversations = userChats[0].data()['conversations'];

      List users = [];

      /* Loop through the ids of the users with conversations and add them to
      the list
       */
      for (var id in conversations){
        var contactInfo = await getContactInfo(uid: id['userID']);
        users.add(
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: CustomListTile(
                  currentUserID: currentUserID,
                  title: contactInfo!["name"],
                  label: "UR",
                  subtitle: contactInfo["contact"],
                  messageID: contactInfo["id"] + currentUserID,
                  respondentID: contactInfo["id"],
                  pushToken: contactInfo["pushToken"]
              ),
            ));
      }

      return users;

    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/model/emergency_contact_model.dart';
import 'package:my_safe_campus/widgets/custom_list_tile.dart';

class EmergencyContacts {
  final String currentUserID;

  EmergencyContacts({required this.currentUserID});

  // // Get all emergency contacts
  // Future<QuerySnapshot<Map<String, dynamic>>> getEmergencyContactIDs() {
  //
  //   return FirebaseFirestore.instance
  //       .collection("emergencyContacts").get();
  //
  // }

  // Get the user's timeline
  Future<List> getEmergencyContactIDs() async {

    List ids = [];

    //Get all the ids of emergency contacts and save in the ids list
    return FirebaseFirestore.instance.collection("emergencyContacts").get().then((value) async {
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

  // // Get all emergency contacts
  // List<> getEmergencyContacts() async {
  //   var ids = await getEmergencyContactIDs();
  //   return FirebaseFirestore.instance
  //       .collection("emergencyContacts").snapshots();
  //
  // }

  // Get the user's timeline
  Future<List> getEmergencyContacts() async {
    List emergencyContacts = [];

    //Get all the ids of the emergency contacts
    List ids = await getEmergencyContactIDs();

    for (var id in ids){
      var contactInfo = await getContactInfo(uid: id);
      emergencyContacts.add(
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: CustomListTile(
              currentUserID: currentUserID,
              title: contactInfo!["name"],
              label: "FR",
              subtitle: contactInfo["contact"],
              messageID: currentUserID + contactInfo["id"],
              respondentID: contactInfo["id"]
        ),
      ));
    }
    return emergencyContacts;

    // //Get all the people the user is following
    // return FirebaseFirestore.instance.collection("users").get().then((
    //     value) async {
    //   List<DocumentSnapshot> allDocs = value.docs;
    //
    //   // get the posts of all the users being followed
    //   for (var element in allDocs) {
    //     Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
    //
    //     if (data != null && data['following'].id == authID) {
    //       List userPosts = await getUserPosts(uid: data['followed'].id);
    //       posts.addAll(userPosts);
    //     }
    //   }
    //
    //   return posts;
    // });
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

    return users.doc(currentUserID).update({
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
    DocumentSnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    // Get the user's data
    var data = query.data();
    data?['id'] = uid;

    return data;
  }
}
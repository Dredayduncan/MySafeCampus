import 'package:cloud_firestore/cloud_firestore.dart';

class UserHistory {
  final String userID;

  UserHistory({required this.userID});

  // Get SMS's that were sent when the emergency button was clicked
  Stream<QuerySnapshot> getUserSMS() {
    return FirebaseFirestore.instance
        .collection("emergencyButtonHits")
        .where("userID", isEqualTo: FirebaseFirestore.instance.collection('users').doc(userID))
        .snapshots();
  }

  // Get all the calls the user has made
  Stream<QuerySnapshot> getUserCalls() {
    return FirebaseFirestore.instance
        .collection("userCalls")
        .where("userID", isEqualTo: FirebaseFirestore.instance.collection('users').doc(userID))
        .snapshots();
  }

  // Get reports that the user has filed
  Stream<QuerySnapshot> getUserReports() {
    return FirebaseFirestore.instance
        .collection("reports")
        .where("userID", isEqualTo: FirebaseFirestore.instance.collection('users').doc(userID))
        .snapshots();
  }

  // Record when the emergency button was pressed and at what time
  Future<dynamic> updateEmergencyButtonHits({status}) async {
    CollectionReference emergencyButtonHits = FirebaseFirestore.instance.collection("emergencyButtonHits");

    return emergencyButtonHits
      .add({
      "userID": FirebaseFirestore.instance.collection('users').doc(userID),
      "timeSent": DateTime.now(),
      "status": status
    })
        .then((value) => true)
        .catchError((error) => false);
  }

  // Record when the emergency button was pressed and at what time
  Future<dynamic> updateUserCalls({calleeName, status}) async {
    CollectionReference userCalls = FirebaseFirestore.instance.collection("userCalls");

    return userCalls
        .add({
      "userID": FirebaseFirestore.instance.collection('users').doc(userID),
      "timeCalled": DateTime.now(),
      "status": status,
      "calleeName": calleeName
    })
        .then((value) => true)
        .catchError((error) => false);
  }

  // Record when the emergency button was pressed and at what time
  Future<dynamic> updateReports({formDetails}) async {
    CollectionReference reports = FirebaseFirestore.instance.collection("reports");

    return reports
      .add({
        "userID": FirebaseFirestore.instance.collection('users').doc(userID),
        "timeReported": DateTime.now(),
        "status": "Pending",
        "formDetails": formDetails
    })
        .then((value) => true)
        .catchError((error) => false);
  }

  // Record when the emergency button was pressed and at what time
  Future<dynamic> updateCancelledReports() async {
    CollectionReference reports = FirebaseFirestore.instance.collection("reports");

    return reports
        .add({
      "userID": FirebaseFirestore.instance.collection('users').doc(userID),
      "timeCancelled": DateTime.now(),
      "status": "Cancelled",
      "formDetails": {}
    })
        .then((value) => true)
        .catchError((error) => false);
  }


}
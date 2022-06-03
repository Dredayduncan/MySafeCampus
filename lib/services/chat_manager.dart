import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_safe_campus/widgets/notification.dart';

class ChatManager {
  final String userID;

  ChatManager({required this.userID});

  // Method to handle image uploads to firebase
  uploadFile(File image, String fileName) {
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(image);

    return uploadTask;
  }

  // Get the chats the current user has with the given respondent
  Stream<DocumentSnapshot>? getChatStream({required messageID}) {

    return FirebaseFirestore.instance
        .collection("messages")
        .doc(messageID)
        .snapshots();
  }

  /* Start a new conversation with the respondent where the messageID
    is a concatenation of the sender's id and the recipient's id
  */
  Future<dynamic> startConversation({messageID, recipientID, chat, pushToken, senderName}) async {
    CollectionReference messages = FirebaseFirestore.instance.collection(
        "messages");

    // Add the user to the list of users that the emergency contact has chat with


    return messages.doc(messageID).set({
      "sender": FirebaseFirestore.instance.collection('users').doc(userID),
      "recipient": FirebaseFirestore.instance.collection('users').doc(recipientID),
      "chat": FieldValue.arrayUnion([
        {
          "chat": chat,
          "sender": FirebaseFirestore.instance.collection('users').doc(userID),
          "timeSent": DateTime.now()
        }
      ])
    })
    .then((value) {
      addUserToContactConversationList(emergencyContactID: recipientID);
      CustomNotification customNotification = CustomNotification();
      customNotification.sendNotification(
          to: pushToken,
          title: "Message from Andrew",
          body: chat
      );
    })
        .catchError((error) => false);
  }

  // Send a chat to the respondent
  Future<dynamic> sendChat({messageID, chat, pushToken}) async {
    CollectionReference messages = FirebaseFirestore.instance.collection(
        "messages");

    return messages.doc(messageID).update({
      "chat": FieldValue.arrayUnion([
        {
          "chat": chat,
          "sender": FirebaseFirestore.instance.collection('users').doc(userID),
          "timeSent": DateTime.now()
        }
      ])
    })
      .then((value) {
          CustomNotification customNotification = CustomNotification();
          customNotification.sendNotification(
              to: pushToken,
              title: "Message from Andrew",
              body: chat
          );
    })
      .catchError((error) => false);
  }

  // Add the user to the link of conversations an emergency contact has
  Future<dynamic> addUserToContactConversationList({emergencyContactID}) async {
    // Get the document id of the emergency contact
    DocumentReference emergencyContact = FirebaseFirestore.instance.collection('users').doc(emergencyContactID);

    // Get all the emergency contacts
    CollectionReference emergencyContacts = FirebaseFirestore.instance.collection("emergencyContacts");

    /* Get the ID of the document in the emergency services table that belongs
     to the emergency contact
     */
    return await emergencyContacts
      .where('contactID', isEqualTo: emergencyContact)
      .get()
      .then((value) {

        // Add the user to the list of users that the emergency contact has conversations with
        return emergencyContacts.doc(value.docs[0].id).update({
          "conversations": FieldValue.arrayUnion([
            {
              "userID": userID,
            }
          ])
        })
            .then((value) => true)
            .catchError((error) => false);
      });
  }



}

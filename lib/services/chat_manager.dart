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
    if (messageID == "") {
      return null;
    }

    return FirebaseFirestore.instance
        .collection("messages")
        .doc(messageID)
        .snapshots();
  }

  /* Start a new conversation with the respondent where the messageID
    is a concatenation of the sender's id and the recipient's id
  */
  Future<dynamic> startConversation({messageID, recipientID, chat}) async {
    CollectionReference messages = FirebaseFirestore.instance.collection(
        "messages");

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
        .then((value) => true)
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
              to: "f0pGtlmaT_C6uqldsZb1aN:APA91bHjpAyUxLAMTLmp_wk9XoukrKXmkZvt2ZNX-Gdqx2O2RNa70E6VzVyOmgnjscTmRfo799kHM205hB_Ekizx9faQB04Ogw4quLuaYPUsiHMajT5fXoOFUTlwi2SQD3ZfCKfOwH1W",
              title: "Message from Andrew",
              body: chat
          );
    })
      .catchError((error) => false);
  }


}

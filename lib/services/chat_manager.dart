import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatManager{
  final String userID;

  ChatManager({required this.userID});

  // Method to handle image uploads to firebase
  uploadFile(File image, String fileName){
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(image);

    return uploadTask;
  }

  // Get the chats the current user has with the given respondent
  Stream<DocumentSnapshot>? getChatStream({required messageID}) {
    if (messageID == ""){
      return null;
    }

    return FirebaseFirestore.instance
      .collection("messages")
      .doc(messageID)
      .snapshots();
  }

  // Send a chat to the respondent
  Future<dynamic> sendChat({messageID, chat}) async {
    CollectionReference messages = FirebaseFirestore.instance.collection("messages");

    return messages.doc(messageID).update({
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

  //Upload a




}
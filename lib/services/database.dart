import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final String authID;

  Database({required this.authID});

  // Check if conversation exists
  Future<bool> hasConversation(respondentID) async {

    //Get all the messages
    return FirebaseFirestore.instance.collection("messages").get().then((value) async {
      List<DocumentSnapshot> allDocs = value.docs;

      // loop through the messages
      for (var element in allDocs) {
        Map<String, dynamic>? message = element.data() as Map<String, dynamic>?;

        // Check if the user has messaged userID
        if (message!['sender'].id == authID &&  message['recipient'].id == respondentID) {
          return true;
        }
      }

      return false;
    });
  }

  // Send a chat
  Future<dynamic> sendChat({chatID, recipientID, chat}) async {
    CollectionReference chats = FirebaseFirestore.instance.collection("chats");

    // Check if this user has a conversation with the other
    // bool hasConvo = await hasConversation(recipientID);

    // Check if a chat already exists between the participants
    if (chatID != ""){
      return chats.doc(chatID).update({
        "chat": FieldValue.arrayUnion([
          {
            "senderID": FirebaseFirestore.instance.collection('users').doc(
                authID),
            "chat": chat,
            "timeSent": DateTime.now()
          }
        ])
      })
      .then((value) => chatID)
      .catchError((error) => null);
    }

    // If there is no existing chat, create a new one.
    int len = 0;
    await chats.get().then((value) => len = value.docs.length);

    len = len + 1;
    return chats.doc(len.toString()).set({
      "chat": FieldValue.arrayUnion([
        {
          "senderID": FirebaseFirestore.instance.collection('users').doc(authID),
          "chat": chat,
          "timeSent": DateTime.now()
        }
      ])
    }).then((value) {

      return addMessage(
        recipientID: recipientID,
        chatID: FirebaseFirestore.instance.collection('chats').doc(len.toString()),
      );
    })
        .catchError((error) => null);
  }

  // Add conversation to message
  Future<dynamic> addMessage({recipientID, chatID}) {
    //Get the data
    CollectionReference messages = FirebaseFirestore.instance.collection("messages");

    return messages.add({
      "sender": FirebaseFirestore.instance.collection('users').doc(authID),
      "recipient": FirebaseFirestore.instance.collection('users').doc(recipientID),
      "chatID": chatID
    })
        .then((value) => chatID.id)
        .catchError((error) => null);
  }

}
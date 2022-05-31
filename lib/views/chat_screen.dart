import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/model/messages_model.dart';
import 'package:my_safe_campus/model/user_model.dart';
import 'package:my_safe_campus/services/chat_manager.dart';
import 'package:my_safe_campus/widgets/custom_appbar.dart';
import 'package:my_safe_campus/widgets/custom_textfield.dart';

import '../model/chat_model.dart';
import '../widgets/notification.dart';

class ChatScreen extends StatefulWidget {
  final String messageID;
  final String senderID;
  final String respondentName;
  final String respondentID;

  const ChatScreen({
    Key? key,
    required this.messageID,
    required this.senderID,
    required this.respondentName,
    required this.respondentID
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatController = TextEditingController();
  // Initialise the chat manager
  late ChatManager chatManager;

  // Initialise a variable to check if a conversation is new or not
  bool newChat = false;

  late CustomNotification _notification;

  // _HomeScreenState(){
  //   _notification = CustomNotification(onClick: (payload) async {
  //     return;
  //   });
  //   //   Navigator.push(
  //   //       context,
  //   //       MaterialPageRoute(
  //   //           builder: (context) => (auth: widget.auth)));
  //   // });
  // }

  @override
  void initState() {
    super.initState();
    chatManager = ChatManager(userID: widget.senderID);
    _notification = CustomNotification(onClick: (payload) async {
      return;
    });
    _notification.registerNotification();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.respondentName,
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      bottomSheet: Container(
        width: double.infinity,
        color: kWhiteTextColor,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  child: CustomTextField(
                    controller: _chatController,
                    hintText: 'Type message',
                    onChanged: (value) {},
                    validator: (validator) {},
                    icon: Icons.message,
                    borderless: true,
                    suffixIcon: IconButton(
                      color: Colors.grey,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.image,
                      ),
                    ),
                    sendMsg: IconButton(
                      onPressed: () {
                        if (_chatController.text.isEmpty) {
                          return;
                        }
                        else if (newChat){
                          chatManager.startConversation(
                            messageID: widget.messageID,
                            chat: _chatController.text,
                            recipientID: widget.respondentID
                          );

                          setState(() {
                            newChat = false;
                          });
                        }
                        else {
                          chatManager.sendChat(
                            messageID: widget.messageID,
                            chat: _chatController.text,
                          );
                        }

                        _chatController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: StreamBuilder<DocumentSnapshot>(
          stream: chatManager.getChatStream(messageID: "1"),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
              setState(() {
                newChat = true;
              });

              return const Center(child: Text("Say Something."));
            }

            // Get the chats between the user and the respondent
            var doc = snapshot.data as DocumentSnapshot;
            List chats = doc['chat'];

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.11,
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: chats.length,
                      itemBuilder: ((context, index) {
                        // final Chat chat = chats[index];
                        bool isMe = chats[index]["sender"].id == widget.senderID;

                        return _buildMessage(chats[index], isMe);
                      }),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

_buildMessage(Map<String, dynamic> message, bool isMe) {
  return BubbleSpecialThree(
    text: message["chat"],
    color: isMe ? kDefaultBackground : kDefaultBackground.withOpacity(0.7),
    tail: true,
    textStyle: const TextStyle(color: Colors.white, fontSize: 16),
    isSender: isMe ? true : false,
  );
}

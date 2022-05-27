import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/model/messages_model.dart';
import 'package:my_safe_campus/model/user_model.dart';
import 'package:my_safe_campus/services/chat_manager.dart';
import 'package:my_safe_campus/widgets/custom_appbar.dart';
import 'package:my_safe_campus/widgets/custom_textfield.dart';

import '../model/chat_model.dart';

class ChatScreen extends StatefulWidget {
  final String chatID;
  final String sender;

  const ChatScreen({Key? key, required this.chatID, required this.sender})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatController = TextEditingController();
  // Initialise the chat manager
  late ChatManager chatManager;

  @override
  void initState() {
    super.initState();
    chatManager = ChatManager(userID: 'JhgCXwOw8KfYGOvotDjvHbHlJ2l2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.sender,
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
                        } else {
                          chatManager.sendChat(
                            messageID: widget.chatID,
                            chat: _chatController.text,
                          );
                          _chatController.clear();
                        }
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
          stream: chatManager.getChatStream(messageID: widget.chatID),
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

            if (snapshot.data == null) {
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
                      bottom: MediaQuery.of(context).size.height * 0.08,
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: chats.length,
                      itemBuilder: ((context, index) {
                        // final Chat chat = chats[index];
                        bool isMe = chats[index]["sender"].id ==
                            "JhgCXwOw8KfYGOvotDjvHbHlJ2l2";
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

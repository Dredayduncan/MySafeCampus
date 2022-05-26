import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/model/messages_model.dart';
import 'package:my_safe_campus/model/user_model.dart';
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

  final User currentUser = User(
    '0',
    'Akwasi',
    'emailAddress',
  );

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
                      onPressed: () {},
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: chats.length,
              itemBuilder: ((context, index) {
                final Chat chat = chats[index];
                bool isMe = chat.sender == currentUser.name;
                return _buildMessage(chat, isMe);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

_buildMessage(Chat message, bool isMe) {
  return BubbleSpecialThree(
    text: message.chat,
    color: isMe ? kDefaultBackground : kDefaultBackground.withOpacity(0.7),
    tail: true,
    textStyle: const TextStyle(color: Colors.white, fontSize: 16),
    isSender: isMe ? true : false,
  );
}

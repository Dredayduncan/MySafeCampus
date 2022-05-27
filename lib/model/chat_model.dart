class Chat {
  final String sender;
  final String timeSent;
  final String chat;
  final String chatID;

  Chat(
      {required this.sender,
      required this.timeSent,
      required this.chat,
      required this.chatID});
}

List<Chat> chats = [
  Chat(
    sender: 'Akwasi',
    timeSent: 'timeSent',
    chat: 'Hello Sir',
    chatID: 'chatID',
  ),
  Chat(
    sender: 'Andrew',
    timeSent: 'timeSent',
    chat: 'Yeah Hello',
    chatID: 'chatID',
  ),
  Chat(
    sender: 'Akwasi',
    timeSent: 'timeSent',
    chat: 'How are you?',
    chatID: 'chatID',
  ),
  Chat(
    sender: 'Andrew',
    timeSent: 'timeSent',
    chat: 'I\'m good you?',
    chatID: 'chatID',
  ),
  Chat(
    sender: 'Akwasi',
    timeSent: 'timeSent',
    chat: 'Fine!',
    chatID: 'chatID',
  ),
  Chat(
    sender: 'Akwasi',
    timeSent: 'timeSent',
    chat:
        'I want to tell you something cool but I fear you will say I am too Jon!!!',
    chatID: 'chatID',
  ),
];

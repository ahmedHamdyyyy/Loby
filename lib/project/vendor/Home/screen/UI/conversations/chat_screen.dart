import 'package:flutter/material.dart';

import 'all_widget_chats.dart';

class ChatScreenVendor extends StatefulWidget {
  const ChatScreenVendor({super.key, required this.userName, required this.userImage, this.isOnline = false});
  final String userName, userImage;
  final bool isOnline;

  @override
  State<ChatScreenVendor> createState() => _ChatScreenVendorState();
}

class _ChatScreenVendorState extends State<ChatScreenVendor> {
  final TextEditingController _messageController = TextEditingController();

  final List<ChatMessage> _messages = [
    ChatMessage(text: "Hello ! howe are you ?", isMe: false, time: "12:20 PM"),
    ChatMessage(text: "Lorem ipsum dolor sit amet, consecr text adipiscing", isMe: false, time: "12:20 PM"),
    ChatMessage(text: "Hey! How have you ?", isMe: true, time: "12:15 PM"),
    ChatMessage(text: "Lorem ipsum dolor sit amet,", isMe: true, time: "12:15 PM"),
    ChatMessage(text: "Lorem ipsum dolor sit,", isMe: false, time: "12:20 PM"),
    ChatMessage(text: "Lorem ipsum dolor sit amet,", isMe: false, time: "12:20 PM"),
    ChatMessage(text: "Lorem ipsum dolor sit amet,", isMe: true, time: "12:20 PM"),
    ChatMessage(text: "Lorem ipsum dolor sit amet,", isMe: true, time: "12:20 PM"),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50),
          const ChatScreenHeader(),
          const SizedBox(height: 22),
          UserInfoHeader(userName: widget.userName, userImage: widget.userImage, isOnline: widget.isOnline),
          MessagesList(messages: _messages),
          MessageInputBox(controller: _messageController),
        ],
      ),
    );
  }
}

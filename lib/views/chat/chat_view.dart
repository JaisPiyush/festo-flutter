import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<types.Message> messages = [];
  final user = const types.User(id: '12354');
  final user2 = const types.User(id: '123254');
  @override
  Widget build(BuildContext context) {
    return Chat(
        messages: messages,
        onSendPressed: (text) {
          final message = types.TextMessage(
              author: user2,
              id: text.text,
              text: text.text,
              metadata: text.metadata,
              repliedMessage: text.repliedMessage);
          setState(() {
            messages.insert(0, message);
          });
        },
        user: user);
  }
}

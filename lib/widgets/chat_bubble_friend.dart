import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubbleFriend extends StatelessWidget {
  const ChatBubbleFriend({
    super.key,
    required this.message,
  });
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
            color: Color.fromARGB(255, 3, 56, 99)),
        child: Text(message.message),
      ),
    );
  }
}

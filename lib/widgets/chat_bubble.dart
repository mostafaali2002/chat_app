import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            color: Colors.blue),
        child: Text(
          message.message,
          style:const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

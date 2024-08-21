import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_bubble_friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});
  static String id = "ChatBubble";

  @override
  State<ChatView> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatView> {
  CollectionReference message =
      FirebaseFirestore.instance.collection("message");
  TextEditingController controller = TextEditingController();
  final constrain = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder(
      stream: message.orderBy("date", descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 90,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40)),
                ),
                centerTitle: true,
                title: Column(
                  children: [
                    Image.asset(
                      Klogo,
                      height: 50,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                    const Text(
                      "Chat",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: constrain,
                      reverse: true,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email
                            ? ChatBubble(message: messageList[index])
                            : ChatBubbleFriend(message: messageList[index]);
                      },
                    ),
                  ),
                  TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      message.add({
                        "message": value,
                        "date": DateTime.now(),
                        "id": email,
                      });
                      controller.clear();
                      constrain.animateTo(
                        0,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.send),
                      hintText: "Send Message",
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                  )
                ],
              ));
        } else {
          return Center(child: const CircularProgressIndicator());
        }
      },
    );
  }
}

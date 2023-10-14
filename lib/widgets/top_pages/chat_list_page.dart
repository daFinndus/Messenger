import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/chat_box_demo.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: const Column(
            children: [
              ChatBoxDemo(title: "Mary", imagePath: "assets/images/mary.png"),
              ChatBoxDemo(title: "Leon", imagePath: "assets/images/leon.png"),
              ChatBoxDemo(title: "Raj", imagePath: "assets/images/rajesh.png"),
              ChatBoxDemo(title: "Tom", imagePath: "assets/images/thomas.png"),
            ],
          ),
        ),
      ),
    );
  }
}

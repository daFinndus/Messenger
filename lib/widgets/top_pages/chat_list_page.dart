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
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: const <Widget>[
        ChatBoxDemo(title: "Mary", imagePath: "assets/images/mary.png"),
        ChatBoxDemo(title: "Leon", imagePath: "assets/images/leon.png"),
        ChatBoxDemo(title: "Raj", imagePath: "assets/images/rajesh.png"),
        ChatBoxDemo(title: "Tom", imagePath: "assets/images/thomas.png"),
        ChatBoxDemo(title: "Felix", imagePath: "assets/images/mary.png"),
        ChatBoxDemo(title: "James", imagePath: "assets/images/leon.png"),
        ChatBoxDemo(title: "Peter", imagePath: "assets/images/rajesh.png"),
        ChatBoxDemo(title: "Dieter", imagePath: "assets/images/thomas.png"),
        ChatBoxDemo(title: "Darren", imagePath: "assets/images/mary.png"),
        ChatBoxDemo(title: "Finn", imagePath: "assets/images/leon.png"),
        ChatBoxDemo(title: "Jonas", imagePath: "assets/images/rajesh.png"),
        ChatBoxDemo(title: "Simon", imagePath: "assets/images/thomas.png"),
      ],
    );
  }
}

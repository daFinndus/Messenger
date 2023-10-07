import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/chat_box.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: const Column(
        children: [
          ChatBox(title: "Mary", imagePath: "assets/images/mary.png"),
          ChatBox(title: "Leon", imagePath: "assets/images/leon.png"),
          ChatBox(title: "Rajesh", imagePath: "assets/images/rajesh.png"),
          ChatBox(title: "Thomas", imagePath: "assets/images/thomas.png"),
        ],
      ),
    );
  }
}

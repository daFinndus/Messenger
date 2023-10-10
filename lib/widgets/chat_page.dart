import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';
import 'package:messenger/widgets/components/chat_box_demo.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.brightColor,
        title: Text(
          'Chats',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkColor),
        ),
      ),
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

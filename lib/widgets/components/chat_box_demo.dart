import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';
import 'package:messenger/widgets/elements/chat_page.dart';

// Custom chat box for the chat list
class ChatBoxDemo extends StatefulWidget {
  final String title;
  final String imagePath;

  const ChatBoxDemo({super.key, required this.title, required this.imagePath});

  @override
  State<ChatBoxDemo> createState() => _ChatBoxDemoState();
}

class _ChatBoxDemoState extends State<ChatBoxDemo> {
  // Function to route to a certain chat
  void routeToChat(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => routeToChat(
          ChatPage(title: widget.title, imagePath: widget.imagePath)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56.0),
            color: AppColors.primaryColor),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                  radius: 28, backgroundImage: AssetImage(widget.imagePath)),
            ),
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brightColor),
            ),
          ],
        ),
      ),
    );
  }
}

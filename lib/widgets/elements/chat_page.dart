import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';

class ChatPage extends StatelessWidget {
  final String title;
  final String imagePath;

  const ChatPage({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                  radius: 20.0, backgroundImage: AssetImage(imagePath)),
            ),
            Text(title)
          ],
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      // Here should be the chat elements
    );
  }
}

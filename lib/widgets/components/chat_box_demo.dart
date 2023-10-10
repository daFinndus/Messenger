import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';

class ChatBoxDemo extends StatelessWidget {
  final String title;
  final String imagePath;

  const ChatBoxDemo({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                radius: 28, backgroundImage: AssetImage(imagePath)),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.brightColor),
          ),
        ],
      ),
    );
  }
}

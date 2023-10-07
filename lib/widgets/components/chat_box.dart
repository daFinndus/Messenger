import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';

class ChatBox extends StatelessWidget {
  final String title;
  final String imagePath;

  const ChatBox({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
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
                color: AppColors.darkColor),
          ),
        ],
      ),
    );
  }
}

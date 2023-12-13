import 'package:flutter/material.dart';

import 'package:messenger/constants/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String timestamp;
  final Color color;

  const ChatBubble(
      {super.key,
      required this.message,
      required this.timestamp,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: color,
      ),
      child: Column(
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.brightColor,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              timestamp,
              style: TextStyle(fontSize: 8.0, color: AppColors.brightColor),
            ),
          ),
        ],
      ),
    );
  }
}

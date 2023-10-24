import 'package:flutter/material.dart';

import 'package:messenger/constants/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final String message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: AppColors.primaryColor,
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: AppColors.brightColor,
        ),
      ),
    );
  }
}

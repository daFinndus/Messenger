import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';

class ChatField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool obscureText;

  const ChatField(
      {super.key,
      required this.controller,
      required this.text,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: TextField(
        style: TextStyle(color: AppColors.brightColor),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 1.0,
            ),
          ),
          fillColor: AppColors.primaryColor,
          filled: true,
          hintText: text,
          hintStyle: TextStyle(
            color: AppColors.lightColor,
          ),
        ),
      ),
    );
  }
}

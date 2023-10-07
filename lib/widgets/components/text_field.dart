import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool obscure;

  const CustomTextField(
      {super.key,
      required this.title,
      required this.obscure,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: AppColors.darkColor),
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: title,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.darkColor)),
      ),
    );
  }
}

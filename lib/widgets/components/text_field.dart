import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final IconData? icon;
  final String text;
  final TextEditingController controller;
  final bool obscure;

  const CustomTextField(
      {super.key,
      required this.text,
      required this.obscure,
      required this.controller,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            color: AppColors.secondaryColor,
          ),
          filled: true,
          fillColor: AppColors.brightColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

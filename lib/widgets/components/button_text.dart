import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';

class CustomTextButton extends StatefulWidget {
  final String title;
  final Function function;

  const CustomTextButton(
      {super.key, required this.title, required this.function});

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: TextButton(
        onPressed: () => widget.function(),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.brightColor,
          ),
        ),
      ),
    );
  }
}

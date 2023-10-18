import 'package:flutter/material.dart';
import 'package:messenger/variables/app_colors.dart';

class CustomBoxButton extends StatefulWidget {
  final String title;
  final Function function;

  const CustomBoxButton(
      {super.key, required this.title, required this.function});

  @override
  State<CustomBoxButton> createState() => _CustomBoxButtonState();
}

class _CustomBoxButtonState extends State<CustomBoxButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 384.0,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: ElevatedButton(
        onPressed: () => widget.function(),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.all(8),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: AppColors.brightColor,
          ),
        ),
      ),
    );
  }
}

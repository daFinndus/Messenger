import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';

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
      height: 54.0,
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => widget.function(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            AppColors.brightColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

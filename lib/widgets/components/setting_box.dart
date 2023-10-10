import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';

class CustomSettingBox extends StatefulWidget {
  final Function function;
  final String title;
  const CustomSettingBox({super.key, required this.function, required this.title});

  @override
  State<CustomSettingBox> createState() => _CustomSettingBoxState();
}

class _CustomSettingBoxState extends State<CustomSettingBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    )));
  }
}

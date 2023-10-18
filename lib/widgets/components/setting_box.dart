import 'package:flutter/material.dart';
import 'package:messenger/variables/app_colors.dart';

class CustomSettingBox extends StatefulWidget {
  final String title;
  final Function function;

  const CustomSettingBox(
      {super.key, required this.title, required this.function});

  @override
  State<CustomSettingBox> createState() => _CustomSettingBoxState();
}

class _CustomSettingBoxState extends State<CustomSettingBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.0,
      child: ElevatedButton(
        onPressed: () => widget.function(),
        style: TextButton.styleFrom(
          backgroundColor: AppColors.brightColor,
          padding: const EdgeInsets.all(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.greyColor)
          ],
        ),
      ),
    );
  }
}

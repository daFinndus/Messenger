import 'package:flutter/material.dart';
import 'package:messenger/variables/app_colors.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Themes",
          style: TextStyle(color: AppColors.brightColor),
        ),
      ),
    );
  }
}

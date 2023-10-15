import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Change Password",
          style: TextStyle(color: AppColors.brightColor),
        ),
      ),
    );
  }
}

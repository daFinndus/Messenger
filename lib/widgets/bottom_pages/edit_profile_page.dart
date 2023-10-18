import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: AppColors.brightColor),
        ),
      ),
    );
  }
}

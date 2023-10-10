import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';

class CustomSettingCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const CustomSettingCard(
      {super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      color: AppColors.primaryColor,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.brightColor),
        ),
        leading: CircleAvatar(
          radius: 20.0,
          backgroundImage: AssetImage(imagePath),
        ),
        trailing: Icon(
          Icons.edit,
          color: AppColors.brightColor,
        ),
      ),
    );
  }
}

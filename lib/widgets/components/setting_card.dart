import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';

// Custom widget with a gesture detector for the settings page
class CustomSettingCard extends StatefulWidget {
  final String title; // Title of the setting card
  final String imagePath; // Image path of the setting card
  final Function function; // Function for the setting card

  const CustomSettingCard(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.function});

  @override
  State<CustomSettingCard> createState() => _CustomSettingCardState();
}

class _CustomSettingCardState extends State<CustomSettingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(32.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(56.0),
          color: AppColors.primaryColor),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
                radius: 28, backgroundImage: AssetImage(widget.imagePath)),
          ),
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.brightColor),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => widget.function(),
            child: Icon(Icons.edit, color: AppColors.brightColor),
          )
        ],
      ),
    );
  }
}

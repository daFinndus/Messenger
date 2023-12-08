import 'dart:io';

import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

//TODO: Create an edit profile page
//TODO: This should be changeable from the settings page: first and last name, profile picture, birthday
//TODO: USe the same logic as in the personal data page

class _EditProfilePageState extends State<EditProfilePage> {
  bool imageExistent = false; // Check if the user has a profile picture
  XFile? image; // Store the image

  // Display error message
  void displayErrorMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: imageExistent
                  ? Image.file(
                      File(image!.path),
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.person_rounded,
                      size: 96.0,
                      color: AppColors.primaryColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

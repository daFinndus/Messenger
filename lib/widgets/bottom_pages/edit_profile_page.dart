import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

//TODO: Create an edit profile page
//TODO: This should be changeable from the settings page: first and last name, profile picture, birthday
//TODO: USe the same logic as in the personal data page

class _EditProfilePageState extends State<EditProfilePage> {
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
    );
  }
}

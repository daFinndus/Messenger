import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';
import 'package:messenger/widgets/components/setting_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/widgets/components/setting_card.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingPage> {
  void uselessFunction() {} // Function Placeholder

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.brightColor,
        title: Text(
          'Settings',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: AppColors.darkColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomSettingCard(
                title: "Darren", imagePath: "assets/images/darren.jpg"),
            CustomSettingBox(title: "Themes", function: uselessFunction),
            CustomSettingBox(
                title: "Change Password", function: uselessFunction),
            CustomSettingBox(title: "Language", function: uselessFunction),
            CustomSettingBox(
                title: "Sign Out", function: FirebaseAuth.instance.signOut),
          ],
        ),
      ),
    );
  }
}

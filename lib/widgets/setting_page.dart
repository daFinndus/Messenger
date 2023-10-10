import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';
import 'package:messenger/widgets/components/setting_box.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.brightColor,
            title: Text(
              'Settings',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkColor),
            )),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              margin: const EdgeInsets.all(8.0),
              color: Colors.teal,
              child: const ListTile(
                title: Text("MokTripleA", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white),),
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/Moktriplea.png"),
                ),
                  trailing: Icon(Icons.edit, color: Colors.white,)
              ),
            ),
            CustomSettingBox(title: "Themes", function: FirebaseAuth.instance.signOut),
            CustomSettingBox(title: "Change Password", function: FirebaseAuth.instance.signOut),
            CustomSettingBox(title: "Language", function: FirebaseAuth.instance.signOut),
            CustomSettingBox(title: "Sign Out", function: FirebaseAuth.instance.signOut),
          ],
        )
      )
       );
  }
}

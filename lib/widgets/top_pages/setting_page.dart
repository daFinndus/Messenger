import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/setting_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/widgets/components/setting_card.dart';
import 'package:messenger/widgets/bottom_pages/change_password_page.dart';
import 'package:messenger/widgets/bottom_pages/edit_profile_page.dart';
import 'package:messenger/widgets/bottom_pages/imprint_page.dart';
import 'package:messenger/widgets/bottom_pages/theme_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingPage> {
  // Function to route to another page
  void routeToPage(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          CustomSettingCard(
              title: "Darren",
              imagePath: "assets/images/darren.jpg",
              function: () => routeToPage(const EditProfilePage())),
          CustomSettingBox(
              title: "Themes", function: () => routeToPage(const ThemePage())),
          CustomSettingBox(
              title: "Change Password",
              function: () => routeToPage(const ChangePasswordPage())),
          CustomSettingBox(
              title: "Imprint",
              function: () => routeToPage(const ImprintPage())),
          CustomSettingBox(
              title: "Sign Out", function: FirebaseAuth.instance.signOut),
        ],
      ),
    );
  }
}

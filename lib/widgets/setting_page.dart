import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/setting_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/widgets/components/setting_card.dart';
import 'package:messenger/widgets/elements/change_password_page.dart';
import 'package:messenger/widgets/elements/edit_profile_page.dart';
import 'package:messenger/widgets/elements/imprint_page.dart';
import 'package:messenger/widgets/elements/theme_page.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSettingCard(
                title: "Darren",
                imagePath: "assets/images/darren.jpg",
                function: () => routeToPage(const EditProfilePage())),
            CustomSettingBox(
                title: "Themes",
                function: () => routeToPage(const ThemePage())),
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
      ),
    );
  }
}

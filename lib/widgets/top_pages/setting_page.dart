import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/setting_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String firstName = "";

  @override
  void initState() {
    super.initState();
    updateData("firstName");
  }

  // Function to route to another page
  void routeToPage(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  // Bad solution, needs a fix
  void updateData(String field) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var value = documentSnapshot.get(field);
        setState(() {
          firstName = value;
        });
      } else {
        setState(() {
          firstName = "No first Name in database";
        });
      }
    }).catchError((error) {
      setState(() {
        firstName = "Error detecting first Name";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomSettingCard(
            title: firstName,
            imagePath: "assets/images/darren.jpg",
            function: () => routeToPage(const EditProfilePage())),
        CustomSettingBox(
            title: "Themes", function: () => routeToPage(const ThemePage())),
        CustomSettingBox(
            title: "Change Password",
            function: () => routeToPage(const ChangePasswordPage())),
        CustomSettingBox(
            title: "Imprint", function: () => routeToPage(const ImprintPage())),
        CustomSettingBox(
            title: "Sign Out", function: FirebaseAuth.instance.signOut),
      ],
    );
  }
}

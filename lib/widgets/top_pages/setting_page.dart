import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/widgets/components/setting_box.dart';
import 'package:messenger/widgets/components/setting_card.dart';
import 'package:messenger/widgets/bottom_pages/change_password_page.dart';
import 'package:messenger/widgets/bottom_pages/edit_profile_page.dart';
import 'package:messenger/widgets/bottom_pages/imprint_page.dart';
import 'package:messenger/widgets/bottom_pages/theme_page.dart';
import 'package:messenger/constants/app_names.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingPage> {
  String firstName = AppNames.userName;

  @override
  void initState() {
    super.initState();
    fetchFirstName();
  }

  // Function to route to another page
  void routeToPage(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  // Function to fetch the first name of the user
  Future<String> fetchFirstName() async {
    try {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        var value = documentSnapshot.get("firstName");
        return value;
      } else {
        return "No Entry registered in database";
      }
    } catch (error) {
      return "Error while fetching name";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: fetchFirstName(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          String firstName = snapshot.data!;
          return ListView(
            children: [
              CustomSettingCard(
                title: firstName,
                imagePath: "assets/images/darren.jpg",
                function: () => routeToPage(const EditProfilePage()),
              ),
              CustomSettingBox(
                title: "Themes",
                function: () => routeToPage(const ThemePage()),
              ),
              CustomSettingBox(
                title: "Change Password",
                function: () => routeToPage(const ChangePasswordPage()),
              ),
              CustomSettingBox(
                title: "Imprint",
                function: () => routeToPage(const ImprintPage()),
              ),
              CustomSettingBox(
                title: "Sign Out",
                function: FirebaseAuth.instance.signOut,
              ),
            ],
          );
        }
      },
    );
  }
}

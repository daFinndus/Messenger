import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/widgets/components/setting_box.dart';
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
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Function to fetch the first name of the user
  Future<List<String>> fetchUserData() async {
    try {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        String firstName = documentSnapshot.get("firstName");
        String imageURL = documentSnapshot.get("imageURL");
        return [firstName, imageURL];
      } else {
        return ["", ""];
      }
    } catch (e) {
      return ["", ""];
    }
  }

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
    return FutureBuilder<List>(
      future: fetchUserData(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          String firstName = snapshot.data![0];
          String imageURL = snapshot.data![1];
          return ListView(
            children: [
              CustomSettingCard(
                title: firstName,
                imageURL: imageURL,
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

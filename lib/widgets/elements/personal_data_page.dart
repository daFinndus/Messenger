import 'package:flutter/material.dart';
import 'package:messenger/tab_page.dart';
import 'package:messenger/widgets/components/button_text.dart';
import 'package:messenger/widgets/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthdayController = TextEditingController();

  Future addUserDetails(String firstName, String lastName) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set(
        {
          'firstName': firstName,
          'lastName': lastName,
        },
      );
      routeToTabPage();
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Error in registering user data $e",
              style: const TextStyle(fontSize: 12.0),
            ),
          );
        },
      );
    }
  }

  // Route to personal_data_page.dart
  void routeToTabPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TabPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: [
          const Text("Please enter the following details."),
          CustomTextField(
              title: 'First Name',
              obscure: false,
              controller: firstNameController),
          CustomTextField(
              title: 'Last Name',
              obscure: false,
              controller: lastNameController),
          CustomTextButton(
              title: "Done",
              function: () => addUserDetails(
                  firstNameController.text, lastNameController.text))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:messenger/widgets/tab_page.dart';
import 'package:messenger/widgets/components/button_text.dart';
import 'package:messenger/widgets/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalDataPage extends StatefulWidget {
  final String email;
  final String password;

  const PersonalDataPage({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  // Function to add personal user details and register the user
  void setupUser(String firstName, String lastName) {
    addUserDetails(firstNameController.text, lastNameController.text);
    registerUser();
  }

  // Function to add the personal user details
  Future addUserDetails(String firstName, String lastName) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set(
        {
          "email": widget.email,
          "firstName": firstName,
          "lastName": lastName,
        },
      );
    } on Exception catch (e) {
      showErrorMessage(e.toString());
    }
  }

  // Display AlertDialog with a given String
  void showErrorMessage(String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
        );
      },
    );
  }

  // Display AlertDialog when the password is too weak
  void weakPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text(
            "Password is too weak, please use at least 6 characters",
          ),
        );
      },
    );
  }

  // Display AlertDialog when the given mail address is already in use
  void emailInUseMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text(
            "This email is already in use",
          ),
        );
      },
    );
  }

  // Route to personal_data_page.dart
  void routeToTabPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TabPage(),
      ),
    );
  }

  // Create user with email and password
  Future registerUser() async {
    // Widget to display the process -> instant feedback
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Create user with firebase
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: widget.email, password: widget.password);

      // Deactivate progress indicator when finished creating user
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Deactivate progress indicator when finding an error
      Navigator.pop(context);
      if (e.code == "weak-password") {
        weakPasswordMessage();
      } else if (e.code == "email-already-in-use") {
        emailInUseMessage();
      } else {
        showErrorMessage(e.code);
      }
    }
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
            title: "Sign up",
            function: () => setupUser(
              firstNameController.text,
              lastNameController.text,
            ),
          )
        ],
      ),
    );
  }
}

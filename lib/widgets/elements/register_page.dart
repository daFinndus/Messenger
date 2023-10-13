// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/button_box.dart';
import 'package:messenger/widgets/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
<<<<<<< Updated upstream
=======
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
>>>>>>> Stashed changes
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Function to perform the registration for the user
  void registerUser() async {
    // Check if password and confirm password are the same
    if (passwordController.text == confirmPasswordController.text) {
      // Widget to display the process -> instant feedback
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Sign up user with firebase
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
<<<<<<< Updated upstream
=======

        // Function to add user details to the firestore database
        addUserDetails(emailController.text);

>>>>>>> Stashed changes
        // Get rid of the loading circle if signup is complete
        Navigator.pop(context);

        //Add here route to personal_data_page.dart
      } on FirebaseAuthException catch (e) {
        // Get rid of the loading circle if an error occurs
        Navigator.pop(context);
        if (e.code == "weak-password") {
          weakPasswordMessage();
        } else if (e.code == "email-already-in-use") {
          emailInUseMessage();
        } else {
          // Display a dialog containing the error message
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  e.code,
                  style: const TextStyle(fontSize: 12.0),
                ),
              );
            },
          );
        }
      }
    } else {
      // If 'password' and 'confirm password' aren't the same
      wrongDuplicatePasswordMessage();
    }
<<<<<<< Updated upstream
=======
  }

  // Function to add user details to the firestore database
  Future addUserDetails(String email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(
      {
        'email': email,
      },
    );
>>>>>>> Stashed changes
  }

  // Display AlertDialog when the passwords aren't the same
  void wrongDuplicatePasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              "'Password' and 'Confirm Password' are not the same",
            ),
          );
        });
  }

  // Display AlertDialog when the password is too weak
  void weakPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Password is too weak, please use at least 6 characters"),
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
          title: Text("This email is already in use"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: [
          CustomTextField(
<<<<<<< Updated upstream
=======
              title: 'First Name',
              obscure: false,
              controller: firstNameController),
          CustomTextField(
              title: 'Last Name',
              obscure: false,
              controller: lastNameController),
          CustomTextField(
>>>>>>> Stashed changes
              title: "Email", obscure: false, controller: emailController),
          CustomTextField(
              title: "Register", obscure: true, controller: passwordController),
          CustomTextField(
              title: "Confirm Password",
              obscure: true,
              controller: confirmPasswordController),
          Container(
            width: 384.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: CustomBoxButton(title: "Sign up", function: registerUser),
          ),
        ],
      ),
    );
  }
}

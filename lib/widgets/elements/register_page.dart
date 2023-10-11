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
          });

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        _fireStore.collection('users').doc(userCredential.user!uid).set({
          'uid : userCrede'
        });

        // Get rid of the loading circle if signup is complete
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // Get rid of the loading circle if an error occurs
        Navigator.pop(context);
        if (e.code == "weak-password") {
          weakPasswordMessage();
        } else if (e.code == "email-already-in-use") {
          emailInUseMessage();
        } else {
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
      wrongDuplicatePasswordMessage();
    }
  }

  // Display AlertDialog when the passwords aren't the same
  void wrongDuplicatePasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              "'Password' and 'Confirm Password' are not equal.",
              style: TextStyle(fontSize: 12.0),
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
          title: Text("Password is too weak."),
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
          title: Text("This email is already in use."),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32.0),
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: [
          CustomTextField(
              title: "Email", obscure: false, controller: emailController),
          CustomTextField(
              title: "Password", obscure: true, controller: passwordController),
          CustomTextField(
              title: "Confirm Password",
              obscure: true,
              controller: confirmPasswordController),
          Container(
              width: 384.0,
              margin: const EdgeInsets.only(top: 24.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              child: CustomBoxButton(title: "Sign up", function: registerUser))
        ],
      ),
    );
  }
}

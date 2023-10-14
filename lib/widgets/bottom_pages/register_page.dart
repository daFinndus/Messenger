import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/button_box.dart';
import 'package:messenger/widgets/components/text_field.dart';
import 'package:messenger/widgets/bottom_pages/personal_data_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Function to perform the registration for the user
  Future registerUser() async {
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

      // Sign up user with firebase
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        addUserDetails(emailController.text);
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

  // Route to personal_data_page.dart
  void routeToPersonalDataPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PersonalDataPage(),
      ),
    );
  }

  // Function to add user details to the database
  Future addUserDetails(String email) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'email': email,
      });
    } on Exception catch (e) {
      print(e);
    }
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
              title: "Email", obscure: false, controller: emailController),
          CustomTextField(
              title: "Password", obscure: true, controller: passwordController),
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

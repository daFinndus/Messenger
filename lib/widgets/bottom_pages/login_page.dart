import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/button_box.dart';
import 'package:messenger/widgets/components/text_field.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/constants/app_names.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Function to perform the login for the user
  Future loginUser() async {
    // Widget to display the process -> instant feedback
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Sign in user with firebase
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // Get rid of the loading circle if login is complete
      if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // Get rid of the loading circle if an error occurs
      if (context.mounted) {
        Navigator.pop(context);
      }
      if (e.code == "user-not-found") {
        if (context.mounted) {
          displayErrorMessage(context, "The entered user data wasn't found");
        }
      } else if (e.code == "wrong-password") {
        if (context.mounted) {
          displayErrorMessage(context, "The password is incorrect");
        }
      } else if (e.code == "invalid-email") {
        if (context.mounted) {
          displayErrorMessage(context, "The entered email is invalid");
        }
      } else {
        if (context.mounted) {
          displayErrorMessage(context, e.code);
        }
      }
    }
  }

  void displayErrorMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: [
          const SizedBox(
            height: 64.0,
          ),
          CircleAvatar(
            radius: 64.0,
            backgroundColor: AppColors.brightColor,
            backgroundImage: const AssetImage("assets/logos/ic_launcher.png"),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            AppNames.appTitle,
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: AppColors.brightColor,
            ),
          ),
          Text(
            AppNames.appWelcome,
            style: TextStyle(
              fontSize: 20.0,
              color: AppColors.brightColor,
            ),
          ),
          const SizedBox(
            height: 64.0,
          ),
          CustomTextField(
              icon: Icons.email,
              text: "Email",
              obscure: false,
              controller: emailController),
          CustomTextField(
              icon: Icons.lock,
              text: "Password",
              obscure: true,
              controller: passwordController),
          const SizedBox(
            height: 80.0,
          ),
          SizedBox(
            width: 384.0,
            child: CustomBoxButton(title: "Sign in", function: loginUser),
          ),
        ],
      ),
    );
  }
}

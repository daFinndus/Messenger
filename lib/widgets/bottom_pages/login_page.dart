import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/button_box.dart';
import 'package:messenger/widgets/components/text_field.dart';
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
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Get rid of the loading circle if an error occurs
      Navigator.pop(context);
      if (e.code == "user-not-found") {
        userNotFoundMessage();
      } else if (e.code == "wrong-password") {
        wrongPasswordMessage();
      } else if (e.code == "invalid-email") {
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
  }

  // Display AlertDialog when the user wasn't found
  void userNotFoundMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("No user found with email : '$emailController'"),
        );
      },
    );
  }

  // Display AlertDialog when the passwords is wrong
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Wrong password"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(
            height: 64.0,
          ),
          const CircleAvatar(
            radius: 64.0,
            backgroundImage: AssetImage("assets/logos/ic_launcher.png"),
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
              icon: Icons.password,
              text: "Password",
              obscure: true,
              controller: passwordController),
          SizedBox(
            width: 384.0,
            child: CustomBoxButton(title: "Sign in", function: loginUser),
          ),
        ],
      ),
    );
  }
}

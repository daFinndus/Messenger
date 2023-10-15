import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/button_box.dart';
import 'package:messenger/widgets/components/text_field.dart';
import 'package:messenger/widgets/bottom_pages/personal_data_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Route to personal_data_page.dart
  void routeToPersonalDataPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PersonalDataPage(
          email: emailController.text,
          password: passwordController.text,
        ),
      ),
    );
  }

  void goToNextPage() {
    // Check if email and password was entered
    if (emailController.text != "" && passwordController.text != "") {
      // Check if password and confirm password are the same
      if (passwordController.text == confirmPasswordController.text) {
        // Transfer email and password and route to next page
        routeToPersonalDataPage();
      } else {
        wrongDuplicatePasswordMessage();
      }
    } else {
      checkEmailAndPassword();
    }
  }

  // Display AlertDialog when the needed details weren't entered
  void checkEmailAndPassword() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text(
            "Please enter email and password",
          ),
        );
      },
    );
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
              icon: Icons.email,
              text: "Email",
              obscure: false,
              controller: emailController),
          CustomTextField(
              icon: Icons.password,
              text: "Password",
              obscure: true,
              controller: passwordController),
          CustomTextField(
              icon: Icons.password_outlined,
              text: "Confirm Password",
              obscure: true,
              controller: confirmPasswordController),
          CustomBoxButton(title: "Next", function: goToNextPage),
        ],
      ),
    );
  }
}

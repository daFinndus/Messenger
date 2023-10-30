import 'package:flutter/material.dart';
import 'package:messenger/constants/app_names.dart';
import 'package:messenger/widgets/components/button_box.dart';
import 'package:messenger/widgets/components/text_field.dart';
import 'package:messenger/widgets/bottom_pages/personal_data_page.dart';
import 'package:messenger/constants/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void goToNextPage() {
    // Check if email and password was entered
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      // Check if password and confirm password are the same
      if (passwordController.text == confirmPasswordController.text) {
        // Transfer email and password and route to next page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PersonalDataPage(
              email: emailController.text,
              password: passwordController.text,
            ),
          ),
        );
      } else {
        // Display error message
        displayErrorMessage(context, "Passwords aren't the same");
      }
    } else {
      // Display error message
      displayErrorMessage(context, "Please enter email and password");
    }
  }

  // Display error message
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
            AppNames.appSubtitle,
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
          CustomTextField(
              icon: Icons.lock,
              text: "Confirm Password",
              obscure: true,
              controller: confirmPasswordController),
          SizedBox(
            width: 384.0,
            child: CustomBoxButton(
              title: "Next",
              function: goToNextPage,
            ),
          )
        ],
      ),
    );
  }
}

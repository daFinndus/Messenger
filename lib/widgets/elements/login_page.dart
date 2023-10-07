import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/button_box.dart';
import 'package:messenger/widgets/components/text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void loginUser() {} // Function to perform the login for the user

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const CustomTextField(title: "Email", obscure: false),
          const CustomTextField(title: "Password", obscure: true),
          Container(
            width: 384.0,
            margin: const EdgeInsets.only(top: 24.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: CustomBoxButton(title: "Sign in", function: loginUser),
          ),
        ],
      ),
    );
  }
}

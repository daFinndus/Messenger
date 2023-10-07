import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/button_box.dart';
import 'package:messenger/widgets/components/text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  void registerUser() {} // Function to register the user

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: [
          const CustomTextField(title: "Email", obscure: false),
          const CustomTextField(title: "Password", obscure: true),
          const CustomTextField(title: "Confirm Password", obscure: true),
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

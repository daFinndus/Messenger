import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/button_text.dart';
import 'package:messenger/widgets/bottom_pages/login_page.dart';
import 'package:messenger/widgets/bottom_pages/register_page.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/constants/app_names.dart';

class GreetPage extends StatefulWidget {
  const GreetPage({super.key});

  @override
  State<GreetPage> createState() => _GreetPage();
}

class _GreetPage extends State<GreetPage> {
  bool _greetState = false;

  void greetStateToggle() {
    setState(() {
      _greetState = !_greetState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Visibility(visible: _greetState, child: const LoginPage()),
          Visibility(visible: !_greetState, child: const RegisterPage()),
          Visibility(
            visible: _greetState,
            child: CustomTextButton(
                title: "Not a user yet? Sign up.", function: greetStateToggle),
          ),
          Visibility(
            visible: !_greetState,
            child: CustomTextButton(
                title: "User already? Sign in.", function: greetStateToggle),
          )
        ],
      ),
    );
  }
}

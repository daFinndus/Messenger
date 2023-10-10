import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/tab_page.dart';
import 'package:messenger/widgets/chat_page.dart';
import 'package:messenger/widgets/greet_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const TabPage();
          } else {
            return const GreetPage();
          }
        },
      ),
    );
  }
}

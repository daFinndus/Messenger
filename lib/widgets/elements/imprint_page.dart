import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';

class ImprintPage extends StatelessWidget {
  const ImprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Imprint",
          style: TextStyle(color: AppColors.brightColor),
        ),
      ),
      body: const Column(
        children: [Text("This app is made by Darren and Finn. ~ 05.10.2023")],
      ),
    );
  }
}

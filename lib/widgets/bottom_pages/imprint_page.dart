import 'package:flutter/material.dart';
import 'package:messenger/variables/app_colors.dart';

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
    );
  }
}

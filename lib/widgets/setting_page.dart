import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';
import 'package:messenger/widgets/components/setting_box.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: Text(
              'Settings',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.brightColor),
            )),
        body: Center(
            child: Container(
                margin: const EdgeInsets.all(16.0), child: const Column())));
  }
}

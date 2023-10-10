import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';
import 'package:messenger/widgets/chat_page.dart';
import 'package:messenger/widgets/empty_page.dart';

class TabPage extends StatelessWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.access_alarm)),
                Tab(icon: Icon(Icons.chat)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
            title: Text(
              "Swift Messenger",
              style: TextStyle(color: AppColors.brightColor),
            ),
          ),
          body: const TabBarView(
            children: [
              EmptyPage(),
              ChatPage(),
              EmptyPage(),
            ],
          ),
        ),
      ),
    );
  }
}

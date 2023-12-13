import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/constants/app_names.dart';
import 'package:messenger/widgets/top_pages/news_page.dart';
import 'package:messenger/widgets/top_pages/chat_list_page.dart';
import 'package:messenger/widgets/top_pages/setting_page.dart';

class TabPage extends StatelessWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.newspaper, color: AppColors.brightColor)),
                Tab(icon: Icon(Icons.chat, color: AppColors.brightColor)),
                Tab(icon: Icon(Icons.settings, color: AppColors.brightColor)),
              ],
            ),
            title: Text(
              AppNames.appTitle,
              style: TextStyle(color: AppColors.brightColor),
            ),
          ),
          body: const TabBarView(
            children: [
              NewsPage(),
              ChatList(),
              SettingPage(),
            ],
          ),
        ),
      ),
    );
  }
}

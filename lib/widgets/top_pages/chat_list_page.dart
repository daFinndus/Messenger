import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger/widgets/bottom_pages/chat_page.dart';
import 'package:messenger/widgets/components/chat_box_demo.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUserList());
  }
}

// build a list of users except for the current logged in user
Widget _buildUserList(DocumentSnapshot document) {
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading..');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      });
}

//build individual user list items
Widget _buildUserListItem(DocumentSnapshot document) {
  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

  //dispaly all users except current user
  if(_auth.currentUser!.email != data['email']) {
    return ListTile(
      title: data['email'],
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>   ChatPage(title: , imagePath: imagePath, receiverUserEmail: receiverUserEmail, receiverUserID: receiverUserID),),);
      }

    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/widgets/bottom_pages/chat_page.dart';
import 'package:messenger/constants/app_colors.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
    );
  }

  // Get the data of all available users except the current user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((document) => _buildUserListItem(document))
              .toList(),
        );
      },
    );
  }

  // Build the list item for each user
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (FirebaseAuth.instance.currentUser!.uid != data["uid"]) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColors.primaryColor,
        ),
        child: ListTile(
          textColor: AppColors.brightColor,
          titleTextStyle:
              const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          leading: SizedBox(
            width: 48.0,
            height: 48.0,
            child: CachedNetworkImage(
              imageUrl: data["imageURL"],
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          title: data["firstName"].toString().isNotEmpty
              ? Text(data["firstName"] + " " + data["lastName"])
              : const Text("Unknown User"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  title: data["firstName"] + " " + data["lastName"],
                  imageURL: data["imageURL"],
                  receiverUserEmail: data["email"],
                  receiverUserID: data["uid"],
                ),
              ),
            );
          },
        ),
      );
    }
    return Container();
  }
}

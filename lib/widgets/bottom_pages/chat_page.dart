import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/services/chat_function/chat_service.dart';
import 'package:messenger/widgets/components/chat_bubble.dart';
import 'package:messenger/widgets/components/chat_field.dart';
import 'package:messenger/constants/app_colors.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final String imageURL;
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatPage(
      {super.key,
      required this.title,
      required this.imageURL,
      required this.receiverUserEmail,
      required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    // Only send message if there is something to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      // Clear the text controller after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72.0,
        iconTheme: IconThemeData(
          color: AppColors.brightColor,
        ),
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              width: 44.0,
              height: 44.0,
              child: CachedNetworkImage(
                imageUrl: widget.imageURL,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Text(
              widget.title,
              style: TextStyle(color: AppColors.brightColor),
            )
          ],
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserID, _firebaseAuth.currentUser!.uid),
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
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // Build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return Container(
      alignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            ChatBubble(
              message: (data['message']),
              timestamp: data['timestamp'].toDate().toString().substring(0, 19),
              color: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? AppColors.primaryColor
                  : AppColors.contrastColor,
            ),
          ],
        ),
      ),
    );
  }

// Build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: ChatField(
            controller: _messageController,
            text: "Enter message...",
            obscureText: false,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 8.0, right: 16.0),
          child: IconButton(
            color: AppColors.primaryColor,
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_circle_up,
              size: 36.0,
            ),
          ),
        )
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/chat_function/chat_service.dart';
import 'package:messenger/widgets/components/chat_bubble.dart';
import 'package:messenger/widgets/components/chat_field.dart';
import 'package:messenger/constants/app_colors.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final String imagePath;
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatPage(
      {super.key,
      required this.title,
      required this.imagePath,
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
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 24.0,
                backgroundImage: AssetImage(
                  widget.imagePath,
                ),
              ),
            ),
            Text(widget.title)
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
          return Text("Error${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
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

    // Align the messages tot the right if the sender is the current user, otherwise to the left
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: (data['message'])),
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
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: MyTextField(
              controller: _messageController,
              text: "Enter message...",
              obscureText: false,
            ),
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

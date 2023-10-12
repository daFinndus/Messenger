import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/model/message.dart';

class ChatPage extends StatelessWidget {
  final String title;
  final String imagePath;
  //get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;


  const ChatPage({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                  radius: 20.0, backgroundImage: AssetImage(imagePath)),
            ),
            Text(title)
          ],
        ),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }

  _fireStore.collection('users').doc(userCredential.user!uid).set({
  'uid : userCredential.user!.uid',
  email: email,
  })
  ;
  //Send Message
  Future<void> sendMessage(String receiverId, String message) async {
    // get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    // create a new message
    Message newMessage = Message(
      senderId: CurrentUserId,
      senderEmail: CurrentUserEmail,
      receiverId: receiverId,
      timestamp: timestamp,
      message: message,
    );

    // construct chat room id from current user id and receiver id

    //add new message to database
  }
//get messages
}

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/model/message.dart';
import 'package:flutter/material.dart';

//get instance of auth and firestore
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;


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

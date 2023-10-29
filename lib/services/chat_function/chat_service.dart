import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/services/chat_function/message.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
// Get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

// Function to send a message and save it to the database
  Future<void> sendMessage(String receiverId, String message) async {
    // Get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    // Make a timestamp
    final Timestamp timestamp = Timestamp.now();
    // Create a new message with certain details
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      timestamp: timestamp,
      message: message,
    );

    // Construct chat room id from current user id and receiver id
    List<String> ids = [currentUserId, receiverId];
    // Sort the ids (this ensures the chat room id is always the same for any pair of people
    ids.sort();
    // Combine the ids into a single string to use a chatroomID
    String chatRoomId = ids.join("_");

    // Add new message to database
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // Function to get the messages from the database and display them in the chat
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // Construct chat room id from user ids
    List<String> ids = [userId, otherUserId];
    ids.sort();
    // Combine the ids into a single string to use a chatroomID
    String chatRoomId = ids.join("_");

    // Get the messages from the database
    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}

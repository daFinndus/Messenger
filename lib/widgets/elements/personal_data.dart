import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class  PersonalDataPage extends StatefulWidget {
  const  PersonalDataPage({super.key});

  @override
  State< PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State< PersonalDataPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthdayController = TextEditingController();

  Future addUserDetails(String email, String firstName, String lastName) async {
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).set({
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
    child: Column(
    children: [
    CustomTextField(
    title: 'First Name', obscure: false, controller: firstNameController),
    CustomTextField(
    title: 'Last Name', obscure: false, controller: lastNameController)
    ]));
  }
}

import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/button_box.dart';
import 'package:messenger/widgets/components/date_picker.dart';
import 'package:messenger/widgets/components/text_field.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/constants/app_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalDataPage extends StatefulWidget {
  final String email;
  final String password;

  const PersonalDataPage({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  // DateTime variable to store the selectedDate
  DateTime? selectedDate;

  // Return the date as selectedDate
  void handleDateSelected(DateTime? date) {
    setState(() {
      selectedDate = date;
    });
  }

  // Function to add personal user details and register the user
  void setupUser(String firstName, String lastName) async {
    // Widget to display the process -> instant feedback
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Create the user
    await registerUser();

    // Store user details
    await addUserDetails(
      firstNameController.text,
      lastNameController.text,
      selectedDate,
    );

    // Pop the loading circle
    if (context.mounted) {
      Navigator.pop(context);
    }

    // This will pop the current route
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  // Create user with email and password
  Future registerUser() async {
    // Create user with firebase
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: widget.email, password: widget.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        if (context.mounted) {
          displayErrorMessage(context, "The password is too weak");
        }
      } else if (e.code == "email-already-in-use") {
        if (context.mounted) {
          displayErrorMessage(context, "The email is already in use");
        }
      } else {
        if (context.mounted) {
          displayErrorMessage(context, e.code);
        }
      }
    }
  }

  // Function to add the personal user details
  Future addUserDetails(
      String firstName, String lastName, DateTime? birthday) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set(
        {
          "email": widget.email,
          "firstName": firstName,
          "lastName": lastName,
          "birthday": birthday,
          "uid": FirebaseAuth.instance.currentUser?.uid
        },
      );
    } on Exception catch (e) {
      if (context.mounted) {
        displayErrorMessage(context, e.toString());
      }
    }
  }

  // Display error message
  void displayErrorMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppNames.appTitle,
          style: TextStyle(color: AppColors.brightColor),
        ),
        iconTheme: IconThemeData(
          color: AppColors.brightColor,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              child: Text(
                "Please enter the following details",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brightColor),
              ),
            ),
            CustomTextField(
                icon: Icons.insert_emoticon_rounded,
                text: "First Name",
                obscure: false,
                controller: firstNameController),
            CustomTextField(
                icon: Icons.insert_emoticon_sharp,
                text: "Last Name",
                obscure: false,
                controller: lastNameController),
            CustomDatePicker(
              text: "Please enter your birthday",
              onDateSelected: handleDateSelected, // Pass the callback function
            ),
            CustomBoxButton(
              title: "Sign up",
              function: () => setupUser(
                firstNameController.text,
                lastNameController.text,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/button_box.dart';
import 'package:messenger/widgets/components/datepicker.dart';
import 'package:messenger/widgets/tab_page.dart';
import 'package:messenger/variables/app_colors.dart';
import 'package:messenger/widgets/components/text_field.dart';
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
    Navigator.pop(context);

    // This will pop the current route
    Navigator.of(context).pop();
  }

  // Create user with email and password
  Future registerUser() async {
    // Create user with firebase
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: widget.email, password: widget.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        weakPasswordMessage();
      } else if (e.code == "email-already-in-use") {
        emailInUseMessage();
      } else {
        showErrorMessage(e.code);
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
        },
      );
    } on Exception catch (e) {
      showErrorMessage(e.toString());
    }
  }

  // Display AlertDialog with a given String
  void showErrorMessage(String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
        );
      },
    );
  }

  // Display AlertDialog when the password is too weak
  void weakPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text(
            "Password is too weak, please use at least 6 characters",
          ),
        );
      },
    );
  }

  // Display AlertDialog when the given mail address is already in use
  void emailInUseMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text(
            "This email is already in use",
          ),
        );
      },
    );
  }

  // Route to personal_data_page.dart
  void routeToTabPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TabPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Swift Messenger",
          style: TextStyle(color: AppColors.brightColor),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              child: const Text(
                "Please enter the following details",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            CustomTextField(
                title: "First Name",
                obscure: false,
                controller: firstNameController),
            CustomTextField(
                title: "Last Name",
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

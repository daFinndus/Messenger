import 'dart:io';

import 'package:flutter/material.dart';
import 'package:messenger/widgets/components/button_box.dart';
import 'package:messenger/widgets/components/date_picker.dart';
import 'package:messenger/widgets/components/text_field.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/constants/app_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

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

  XFile? image; // Store the image
  String imageURL = ""; // Store the image URL
  String imageName = ""; // Store the name of the image

  bool imageExistent = false; // Check if the user has a profile picture

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
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      // Check if the image was taken
      if (image != null) {
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

        await uploadImage();

        // Store user details
        await addUserDetails(
          firstNameController.text,
          lastNameController.text,
          imageURL,
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
      } else {
        if (context.mounted) {
          displayErrorMessage(context, "Please select a profile picture");
        }
      }
    } else {
      if (context.mounted) {
        displayErrorMessage(context, "Please fill in all the fields");
      }
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
  Future addUserDetails(String firstName, String lastName, String imageURL,
      DateTime? birthday) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set(
        {
          "email": widget.email,
          "firstName": firstName,
          "imageURL": imageURL,
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

  // Function to pick an image with the camera or gallery
  void pickImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    XFile? picture = await picker.pickImage(source: source);

    // Exit the function if no picture was taken
    if (picture == null) return;

    // Transfer the picture to our image variable
    image = picture;
    // Choosing a unique file name
    imageName = DateTime.now().millisecondsSinceEpoch.toString();

    // Update our boolean and the picture
    setState(() {
      imageExistent = true;
    });
  }

  Future<String> uploadImage() async {
    // Create a reference of our firebase storage
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child("profile_pictures/${FirebaseAuth.instance.currentUser?.uid}")
        .child(imageName);

    // Handle errors
    try {
      // Store the file in firebase storage
      await imageReference.putData(
        await image!.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // Store the download url in the database
      imageURL = await imageReference.getDownloadURL();
    } catch (e) {
      if (context.mounted) {
        displayErrorMessage(context, e.toString());
      }
    }
    // In case of an error return an empty string
    return "";
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
      body: SingleChildScrollView(
        child: Container(
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
                    color: AppColors.brightColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Container(
                width: 128.0,
                height: 128.0,
                decoration: BoxDecoration(
                  color: AppColors.brightColor,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: GestureDetector(
                  onTap: () => pickImage(ImageSource.gallery),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.0),
                    child: imageExistent
                        ? Image.file(
                            File(image!.path),
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person_rounded,
                            size: 96.0,
                            color: AppColors.primaryColor,
                          ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => pickImage(ImageSource.camera),
                    icon: Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.brightColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => pickImage(ImageSource.gallery),
                    icon: Icon(
                      Icons.folder_rounded,
                      color: AppColors.brightColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8.0,
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
                onDateSelected:
                    handleDateSelected, // Pass the callback function
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
      ),
    );
  }
}

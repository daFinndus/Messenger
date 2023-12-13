import 'dart:io';

import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/widgets/components/button_box.dart';
import 'package:messenger/widgets/components/text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Reference storageReference = FirebaseStorage.instance
      .ref()
      .child("profile_pictures/${FirebaseAuth.instance.currentUser?.uid}");

  XFile? image; // Store the image
  String imageURL = ""; // Store the image URL
  String imageName = ""; // Store the name of the image

  bool imageEdited = false; // Check if the image was edited

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  // Function to pick an image from the gallery
  void pickImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();

    // Pick an image with the chosen source
    try {
      XFile? picture = await picker.pickImage(source: source);

      // Display error message if an error appears while picking an image
      if (picture == null) {
        if (context.mounted) {
          displayErrorMessage(context, "Could not pick image");
        }
      }

      // Transfer the picture to our image variable
      image = picture;
      // Choosing a unique file name
      imageName = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload the image to our firebase storage
      await uploadImage();

      // Update our boolean and the picture
      setState(() {
        imageEdited = true;
      });
    } catch (e) {
      if (context.mounted) {
        displayErrorMessage(context, e.toString());
      }
    }
  }

  Future<String> uploadImage() async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child("profile_pictures/${FirebaseAuth.instance.currentUser?.uid}")
        .child(imageName);

    // Put the image in our firebase storage
    try {
      await imageReference.putData(
        await image!.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // Store the new download url
      imageURL = await imageReference.getDownloadURL();
    } catch (e) {
      if (context.mounted) {
        displayErrorMessage(context, e.toString());
      }
    }
    // In case of an error return an empty string
    return "";
  }

  Future<void> updateData() async {
    try {
      // Store our edited data in a map
      Map<String, dynamic> updatedData = {};

      // Check if the image was edited and add it
      if (imageEdited) {
        updatedData["imageURL"] = imageURL;
      }

      // Check if the first name is not empty and add it
      if (firstNameController.text.isNotEmpty) {
        updatedData["firstName"] = firstNameController.text;
      }

      // Check if the last name is not empty and add it
      if (lastNameController.text.isNotEmpty) {
        updatedData["lastName"] = lastNameController.text;
      }

      // Update data if there is data to update
      if (updatedData.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .update(updatedData);
        if (context.mounted) {
          displayErrorMessage(context, "Data updated successfully");
        }
      } else {
        displayErrorMessage(context, "No data to update");
      }
    } catch (e) {
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
        iconTheme: IconThemeData(
          color: AppColors.brightColor,
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: AppColors.brightColor),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16.0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => pickImage(ImageSource.gallery),
                  child: Container(
                    width: 128.0,
                    height: 128.0,
                    decoration: BoxDecoration(
                      color: AppColors.brightColor,
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32.0),
                      child: imageEdited
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
                CustomBoxButton(
                  title: "Update data",
                  function: () => updateData(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

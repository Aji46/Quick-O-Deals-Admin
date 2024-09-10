// import 'dart:io';  // Add this for File

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class CategoryController extends GetxController {
//   var categories = <String>[].obs;
//   var imageUrl = ''.obs;  // RxString to hold the image URL
//   TextEditingController categoryController = TextEditingController();

//   final ImagePicker _picker = ImagePicker();

//   Future<void> pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       String imageUrl = await uploadImageToFirebase(pickedFile);
//       this.imageUrl.value = imageUrl;
//     }
//   }

//   Future<String> uploadImageToFirebase(XFile pickedFile) async {
//     final storageRef = FirebaseStorage.instance
//         .ref()
//         .child('categories/${categoryController.text}.jpg');
//     await storageRef.putFile(File(pickedFile.path));
//     String downloadUrl = await storageRef.getDownloadURL();
//     return downloadUrl;
//   }

//   void addCategory() async {
//     if (categoryController.text.isNotEmpty && imageUrl.isNotEmpty) {
//       final docRef = FirebaseFirestore.instance
//           .collection('category')
//           .doc(categoryController.text);
      
//       await docRef.set({
//         'imageUrl': imageUrl.value,
//       });

//       categories.add(categoryController.text);
//       categoryController.clear();
//       imageUrl.value = '';  // Reset the image URL after adding the category
//     }
//   }
// }

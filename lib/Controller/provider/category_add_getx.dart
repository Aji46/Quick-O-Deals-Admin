import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:quickdealsadmin/Model/category_model.dart';

class CategoryController extends GetxController {
  final categoryController = TextEditingController();
  final imageFile = Rx<XFile?>(null);  // Use XFile instead of File
  final categories = <CategoryModel>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile.value = pickedFile;
    }
  }

  Future<void> addCategory(BuildContext context) async {
    if (categoryController.text.isNotEmpty && imageFile.value != null) {
      try {
        log("Starting the image upload process...");
        String fileName = basename(imageFile.value!.name);
        log("Image file name: $fileName");

        Reference firebaseStorageRef = _storage.ref().child('category_images/$fileName');
        UploadTask uploadTask;

        if (kIsWeb) {
          log("Running on the web platform...");
          // Use readAsBytes for web to get Uint8List
          Uint8List? imageData = await imageFile.value!.readAsBytes();
          uploadTask = firebaseStorageRef.putData(imageData);
        } else {
          log("Running on a mobile platform (Android or iOS)...");
          // For mobile, putFile can still be used with XFile
          uploadTask = firebaseStorageRef.putFile(File(imageFile.value!.path));
        }

        log("Uploading the file...");
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        log("File uploaded successfully, download URL: $downloadUrl");

        // Save the category with the image URL in Firestore
        // CategoryModel newCategory = CategoryModel(
        //   name: categoryController.text,
        //   imageUrl: downloadUrl,
        // );


        

       // await _firestore.collection('category').add(newCategory.toJson());
    
       await _firestore.collection("category").doc(categoryController.text).set({
        "name":categoryController.text,
        "image":downloadUrl

       });

        // Update the local state
        //categories.add(newCategory);

        // Clear the input fields
        categoryController.clear();
        imageFile.value = null;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category added successfully!')),
        );
      } catch (error) {
        log("Error during category addition: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add category: $error')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide a category name and image')),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final snapshot = await _firestore.collection('category').get();
      if (snapshot.docs.isNotEmpty) {
        categories.value = snapshot.docs.map((doc) {
          print(".........................${categories.value}");
          return CategoryModel.fromJson(doc.data());
          
        }).toList();
      } else {
        categories.clear();
      }
    } catch (e) {
      print('Error fetching categories: $e');
      categories.clear();
    }
  }
}



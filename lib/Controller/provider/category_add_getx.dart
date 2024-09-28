import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:quickdealsadmin/Model/category_model.dart';

class CategoryController extends GetxController {
  final categoryController = TextEditingController();
  final imageFile = Rx<XFile?>(null);
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
          Uint8List? imageData = await imageFile.value!.readAsBytes();
          uploadTask = firebaseStorageRef.putData(imageData);
        } else {
          log("Running on a mobile platform (Android or iOS)...");
          uploadTask = firebaseStorageRef.putFile(File(imageFile.value!.path));
        }

        log("Uploading the file...");
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        log("File uploaded successfully, download URL: $downloadUrl");

        await _firestore.collection("category").doc(categoryController.text).set({
          "name": categoryController.text,
          "image": downloadUrl
        });

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
      final querySnapshot = await _firestore.collection('category').get();
      final categoryList = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return CategoryModel(
          name: data['name'],
          imageUrl: data['image'],
        );
      }).toList();
      categories.assignAll(categoryList);
    } catch (e) {
      log("Error fetching categories: $e");
    }
  }

  // Future<void> fetchCategoryDetails(String categoryName) async {
  //   try {
  //     final doc = await _firestore.collection('category').doc(categoryName).get();
  //     if (doc.exists) {
  //       final data = doc.data()!;
  //       categoryController.text = data['name'];
  //       imageFile.value = XFile((await _downloadImage(data['image'])) as String);
  //     }
  //   } catch (e) {
  //     log("Error fetching category details: $e");
  //   }
  // }

  Future<void> updateCategory(String oldName) async {
    if (categoryController.text.isNotEmpty && imageFile.value != null) {
      try {
        String fileName = basename(imageFile.value!.name);
        Reference firebaseStorageRef = _storage.ref().child('category_images/$fileName');
        UploadTask uploadTask = kIsWeb
            ? firebaseStorageRef.putData(await imageFile.value!.readAsBytes())
            : firebaseStorageRef.putFile(File(imageFile.value!.path));
        
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        await _firestore.collection("category").doc(oldName).update({
          "name": categoryController.text,
          "image": downloadUrl
        });

        int index = categories.indexWhere((cat) => cat.name == oldName);
        if (index != -1) {
          categories[index] = CategoryModel(name: categoryController.text, imageUrl: downloadUrl);
        }

        categoryController.clear();
        imageFile.value = null;

       Fluttertoast.showToast(
  msg: "Category added successfully!",
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  backgroundColor: Colors.green,
  textColor: Colors.white,
);

      } catch (error) {
        log("Error updating category: $error");
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to update category: $error')),
        );
      }
    } else {
        Fluttertoast.showToast(
  msg: "Please provide a imane and catogory name",
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  backgroundColor: Colors.green,
  textColor: Colors.white,
);
    }
  }

  Future<void> deleteCategory(String categoryName) async {
    try {
      await _firestore.collection('category').doc(categoryName).delete();
      categories.removeWhere((category) => category.name == categoryName);
    } catch (e) {
      log("Error deleting category: $e");
    }
  }

  Future<List<int>> _downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      log("Error downloading image: $e");
      rethrow;
    }
  }
}

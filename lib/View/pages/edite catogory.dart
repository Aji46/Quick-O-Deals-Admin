// // Example UI
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quickdealsadmin/Controller/provider/category_add_getx.dart';

// class EditCategoryPage extends StatelessWidget {
//   final CategoryController controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Edit Category')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: controller.categoryController,
//               decoration: InputDecoration(labelText: 'Category Name'),
//             ),
//             SizedBox(height: 16),
//             Obx(() {
//               return controller.imageFile.value != null
//                   ? Image.file(File(controller.imageFile.value!.path))
//                   : Text('No image selected');
//             }),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () async {
//                 await controller.pickImage();
//               },
//               child: Text('Pick Image'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () async {
//                 await controller.updateCategoryName("/* current category name */)");
//               },
//               child: Text('Update Name'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await controller.updateCategoryImage("");
//               },
//               child: Text('Update Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

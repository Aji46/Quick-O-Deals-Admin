import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickdealsadmin/Controller/provider/category_add_getx.dart';
import 'package:quickdealsadmin/View/widgets/Show%20Dilog/show%20dilog.dart';
import 'package:quickdealsadmin/View/widgets/circle%20avathar/circle_avathar.dart';
import 'package:quickdealsadmin/View/widgets/coustom_button.dart';
import 'package:quickdealsadmin/View/widgets/textformfiled/coustom_text.dart';

class CategoryView extends StatelessWidget {
  final CategoryController _controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Get screen size from LayoutBuilder's constraints
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            // Calculate cross axis count based on screen width
            int crossAxisCount;
            if (screenWidth > 1200) {
              crossAxisCount = 5; // For larger screens
            } else if (screenWidth > 800) {
              crossAxisCount = 3; // For medium screens
            } else {
              crossAxisCount = 2; // For smaller screens
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _controller.pickImage,
                        child: Obx(() {
                          return Stack(
                            children: [
                              CategoryAvatar(
                                avatarUrl: _controller.imageFile.value != null
                                    ? _controller.imageFile.value!.path
                                    : '',
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextFormField(
                          labelText: "Enter the category",
                          controller: _controller.categoryController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          buttonText: "Add Category",
                          onPressed: () => _controller.addCategory(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                    endIndent: 20,
                    indent: 20,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Obx(() {
                      if (_controller.categories.isEmpty) {
                        return const Center(
                          child: Text('No categories available.'),
                        );
                      } else {
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: screenWidth > 1200
                                ? 6 / 5
                                : (screenWidth > 800 ? 5 / 6 : 4 / 5),
                          ),
                          itemCount: _controller.categories.length,
                          itemBuilder: (context, index) {
                            final category = _controller.categories[index];
                            return Card(
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: screenWidth > 800 ? 50 : 30,
                                    child: Image.network(
                                      category.imageUrl,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Text('Failed to load image$error');
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    category.name,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await _controller.fetchCategories();
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('Edit Category'),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: _controller.pickImage,
                                                        child: Obx(() {
                                                          return CategoryAvatar(
                                                            avatarUrl: _controller.imageFile.value != null
                                                                ? _controller.imageFile.value!.path
                                                                : '',
                                                          );
                                                        }),
                                                      ),
                                                      CustomTextFormField(
                                                        labelText: "Enter the category",
                                                        controller: _controller.categoryController,
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        _controller.updateCategory(category.name);
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('Update'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => Navigator.of(context).pop(),
                                                      child: const Text('Cancel'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(Icons.edit, color: Colors.blue),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            bool confirm = await showDeleteConfirmationDialog(context);
                                            if (confirm) {
                                              _controller.deleteCategory(category.name);
                                            }
                                          },
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

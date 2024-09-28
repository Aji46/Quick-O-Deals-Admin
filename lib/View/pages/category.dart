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
        child: Padding(
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
              Flexible(
                child: Obx(() {
                  if (_controller.categories.isEmpty) {
                    return const Center(child: Text('No categories available.'));
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 6 / 5,
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
                                radius: 50,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                                  child: Text('Update'),
                                                ),
                                                TextButton(
                                                  onPressed: () => Navigator.of(context).pop(),
                                                  child: Text('Cancel'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        bool confirm = await showDeleteConfirmationDialog(context);
                                        if (confirm) {
                                          _controller.deleteCategory(category.name); 
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
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
        ),
      ),
    );
  }
}

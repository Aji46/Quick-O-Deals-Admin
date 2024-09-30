import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickdealsadmin/View/pages/product_detaile.dart';
import 'package:shimmer/shimmer.dart';
// Adjust your import

class ProfileDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> person = Get.arguments;

    final String name = person['username'] ?? 'No Name';
    final String avatarUrl = person['profilePicture'] ?? '';
    final String email = person['email'] ?? 'No Email';
    final String documentId = person['documentId'] ?? 'No ID';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            avatarUrl.isNotEmpty
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(avatarUrl),
                  )
                : const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person),
                  ),
            const SizedBox(height: 16),
            Text(name, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(email, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text('Document ID: $documentId', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Expanded(child: _buildProductList(documentId, name)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(String userId, String name) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user_products')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerEffect();
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Error loading products."));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No products found."));
        }

        final products = snapshot.data!.docs;

        return Column(
          children: [
            Text("Added Products by $name"),
            const SizedBox(height: 16),
            Flexible(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, // Adjust for responsiveness
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final productData = product.data() as Map<String, dynamic>;
                  final productId = product.id; 
                  final productName = productData['productName'] ?? 'Unnamed Product';
                  final productPrice = productData['productPrice']?.toString() ?? '0';
                  final productImages = productData['images'] as List<dynamic>? ?? [];
                  final productImage = productImages.isNotEmpty ? productImages[0] : '';

                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => const ProductDetailPage(),
                        arguments: {'productId': productId, 'productData': productData},
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: productImage.isNotEmpty
                                ? Image.network(
                                    productImage,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return _buildImagePlaceholder();
                                    },
                                  )
                                : _buildImagePlaceholder(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              productName,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '\$$productPrice',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Adjust as needed
        childAspectRatio: 0.75,
      ),
      itemCount: 10, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  color: Colors.white, // Placeholder color
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 8,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 8,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Icon(
        Icons.image,
        size: 40,
        color: Colors.white,
      ),
      alignment: Alignment.center,
    );
  }
}

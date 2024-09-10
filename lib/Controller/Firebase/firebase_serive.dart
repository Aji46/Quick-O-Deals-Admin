import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCategory(String categoryName) async {
    try {
      await _firestore.collection('category').doc(categoryName).set({
        'name': categoryName,
      });
    } catch (e) {
      print('Error adding category: $e');
      // Handle errors appropriately in production
    }
  }
}

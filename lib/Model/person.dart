import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  final String name;
  final String avatarUrl;

  Person({required this.name, required this.avatarUrl});

  factory Person.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Person(
      name: data['name'] ?? '',
      avatarUrl: data['avatarUrl'] ?? '',
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class PeopleController extends GetxController {
//   var people = <Map<String, dynamic>>[].obs; // Observable list of people
//   var filteredPeople = <Map<String, dynamic>>[].obs; // Observable list for search results

//   // Fetch all people from Firestore
//   Future<void> fetchPeople() async {
//     final results = await FirebaseFirestore.instance.collection('users').get();
//     people.assignAll(results.docs.map((doc) => doc.data()).toList());
//     filteredPeople.assignAll(people); // Initialize filteredPeople with all users
//   }

//   // Filter the list based on the search query
//   void filterPeople(String query) {
//     if (query.isEmpty) {
//       filteredPeople.assignAll(people); // Show all when query is empty
//     } else {
//       filteredPeople.assignAll(people.where((person) {
//         return (person['username'] as String).toLowerCase().contains(query.toLowerCase());
//       }).toList());
//     }
//   }
// }

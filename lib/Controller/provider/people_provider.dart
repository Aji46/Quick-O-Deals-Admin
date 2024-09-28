import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PeopleController extends GetxController {
  var people = <Map<String, dynamic>>[].obs;
    var filteredPeople = <Map<String, dynamic>>[].obs;
 // Observable list of people

  @override
  void onInit() {
    super.onInit();
    fetchPeople();
     loadPeople();
  }
 // Assuming a list of maps for user data


  void loadPeople() {
    // Load people from Firestore or any other source
    // Example: people.addAll([...]);
  }

  void filterPeople(String query) {
    if (query.isEmpty) {
      filteredPeople.value = people;
    } else {
      filteredPeople.value = people.where((person) {
        final username = person['username']?.toLowerCase() ?? '';
        return username.contains(query.toLowerCase());
      }).toList();
    }
  }

  Future<void> fetchPeople() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
      people.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (error) {
      print('Error fetching people: $error');
      // Handle error appropriately
    }
  }
}

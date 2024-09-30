import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PeopleController extends GetxController {
  var people = <Map<String, dynamic>>[].obs;
  var filteredPeople = <Map<String, dynamic>>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPeople();
    debounce(searchQuery, (_) => filterPeople(), time: const Duration(milliseconds: 300));
  }

  Future<void> fetchPeople() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
      people.value = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['documentId'] = doc.id; // Add documentId to each document's data
        return data;
      }).toList();
      filteredPeople.value = people; // Initialize filtered list with all people
    } catch (error) {
      print('Error fetching people: $error');
    }
  }

  void filterPeople() {
    if (searchQuery.isEmpty) {
      filteredPeople.value = people;
    } else {
      filteredPeople.value = people.where((person) {
        final username = person['username']?.toLowerCase() ?? '';
        return username.contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }
}

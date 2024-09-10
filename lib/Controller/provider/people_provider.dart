import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PeopleController extends GetxController {
  var people = <Map<String, dynamic>>[].obs; // Observable list of people

  @override
  void onInit() {
    super.onInit();
    fetchPeople();
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

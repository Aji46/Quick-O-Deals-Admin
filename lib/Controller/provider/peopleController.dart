import 'package:get/get.dart';
import 'package:quickdealsadmin/Controller/provider/people_provider.dart';

class Peoplecontroller extends GetxController {
  var searchQuery = ''.obs; // Observable search query

  void updateSearch(String query) {
    searchQuery.value = query;
    // Call the filterPeople method directly from PeopleController if needed
    Get.find<PeopleController>().filterPeople(query);
  }
}

import 'package:get/get.dart';

class SidePanelController extends GetxController {
  // Use RxString for reactive state management
  var selectedPage = 'page'.obs;

  // Method to update the selected page
  void selectPage(String page) {
    selectedPage.value = page;
  }
}

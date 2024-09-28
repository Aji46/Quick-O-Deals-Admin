import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickdealsadmin/Controller/provider/side_panal_provider.dart';
import 'package:quickdealsadmin/View/pages/profile_page.dart';

class SidePanel extends StatelessWidget {
  const SidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch the SidePanelController instance using Get.find
    final SidePanelController sidePanelController = Get.find<SidePanelController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              // Use Get.to for navigation
              Get.to(() => const ProfilePage());
            },
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/ava.png'),
                ),
                SizedBox(width: 8),
                Text("aji"),
              ],
            ),
          ),
        ),
        Obx(() => _buildSidePanelItem(
          'Dashboard',
          Icons.dashboard,
          sidePanelController.selectedPage.value == 'Dashboard',
          sidePanelController,
        )),
        Obx(() => _buildSidePanelItem(
          'People',
          Icons.people,
          sidePanelController.selectedPage.value == 'People',
          sidePanelController,
        )),
        Obx(() => _buildSidePanelItem(
          'Category',
          Icons.assignment,
          sidePanelController.selectedPage.value == 'Category',
          sidePanelController,
        )),
      ],
    );
  }

  Widget _buildSidePanelItem(
    String title,
    IconData icon,
    bool isSelected,
    SidePanelController sidePanelController,
  ) {
    return InkWell(
      onTap: () {
        // Update selected page only
        sidePanelController.selectPage(title);
      },
      splashColor: Colors.blue.withOpacity(0.2),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue : const Color.fromARGB(255, 2, 112, 247),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.blue : const Color.fromARGB(255, 0, 0, 0),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickdealsadmin/Controller/provider/side_panal_provider.dart';
import 'package:quickdealsadmin/View/pages/category.dart';
import 'package:quickdealsadmin/View/pages/dashboard.dart';
import 'package:quickdealsadmin/View/pages/people.dart';
import 'package:quickdealsadmin/View/widgets/side_panal/side_panal.dart';

class BaseLayout extends StatelessWidget {
  const BaseLayout({super.key, required Dashboard content});

  @override
  Widget build(BuildContext context) {
    // Fetch the SidePanelController instance using Get.find
    final SidePanelController sidePanelController =
        Get.find<SidePanelController>();

    return Scaffold(
      // appBar: const CustomAppBar(), // Include CustomAppBar on each page
      body: Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            const SidePanel(), // Keep SidePanel constant
            Expanded(
              child: Obx(() {
                // Use Obx to reactively build the widget based on selectedPage changes
                switch (sidePanelController.selectedPage.value) {
                  case 'Dashboard':
                    return const Dashboard();
                  case 'People':
                    return const People();
                  case 'Category':
                    return CategoryView();
                  default:
                    return const SizedBox(); // Default widget or page
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

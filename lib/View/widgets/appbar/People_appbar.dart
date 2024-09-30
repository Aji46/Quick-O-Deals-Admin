import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickdealsadmin/Controller/provider/people_provider.dart';

class PeopleCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PeopleCustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final PeopleController peopleController = Get.find<PeopleController>();

    return AppBar(
      title: const Text('People'),
      actions: [
        Container(
          width: 200,
          margin: const EdgeInsets.only(right: 10),
          child: TextField(
            onChanged: (value) {
              // Updating search query directly
              peopleController.searchQuery.value = value;
            },
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 2, 112, 247)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: Color.fromARGB(255, 2, 112, 247)),
          onPressed: () {
            // Action for notifications
          },
        ),
      ],
    );
  }
}

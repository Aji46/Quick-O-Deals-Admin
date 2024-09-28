

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickdealsadmin/Controller/provider/peopleController.dart';

class PeopleCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PeopleCustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final Peoplecontroller searchController = Get.put(Peoplecontroller());

    return AppBar(
      title: const Text('People'),
      actions: [
        Container(
          width: 200,
          margin: const EdgeInsets.only(right: 10),
          child: Obx(() => TextField(
                onChanged: searchController.updateSearch,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 2, 112, 247)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              )),
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: Color.fromARGB(255, 2, 112, 247)),
          onPressed: () {
            print('Notification Pressed');
          },
        ),
      ],
    );
  }
}

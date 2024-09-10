import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
     
      actions: [
        Container(
          width: 200,
          margin: const EdgeInsets.only(right: 10),
          child: TextField(
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
            print('Notification Pressed');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

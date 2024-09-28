import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String avatarUrl;

  const ProfileAvatar({super.key, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundImage: avatarUrl.isNotEmpty
          ? NetworkImage(avatarUrl)
          : AssetImage('assets/ava.png') as ImageProvider,
      backgroundColor: Colors.grey[200],
    );
  }
}

class CategoryAvatar extends StatelessWidget {
  final String avatarUrl;

  const CategoryAvatar({super.key, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundImage: avatarUrl.isNotEmpty
          ? NetworkImage(avatarUrl)
          : const AssetImage('assets/category.png'),
      backgroundColor: const Color.fromARGB(255, 55, 55, 55),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String avatarUrl;

  const ProfileAvatar({Key? key, required this.avatarUrl}) : super(key: key);

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

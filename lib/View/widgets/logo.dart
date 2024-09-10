import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/QOD logo.png", 
      height: 110,
      width: 250,
    );
  }
}
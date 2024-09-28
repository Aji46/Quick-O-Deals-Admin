import 'package:flutter/material.dart';
import 'package:quickdealsadmin/View/widgets/appbar/dash_searchbar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
          appBar: DashSearchbar(),
      body: SafeArea(child: Text('Dashboard Page'),),
    );
  }
}

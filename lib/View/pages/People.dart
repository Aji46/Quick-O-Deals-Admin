import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickdealsadmin/Controller/provider/people_provider.dart';
import 'package:quickdealsadmin/View/widgets/appbar/appbar.dart';

class People extends StatelessWidget {
  const People({super.key});

  @override
  Widget build(BuildContext context) {
    final PeopleController peopleController = Get.find<PeopleController>();

    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Obx(() {
          // Observing the people list from the controller
          final peopleData = peopleController.people;

          if (peopleData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemCount: peopleData.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 1);
            },
            itemBuilder: (BuildContext context, int index) {
              final person = peopleData[index];
              final String name = person['username'] ?? 'No Name';
              final String avatarUrl = person['profilePicture'] ?? '';

              return ListTile(
                leading: avatarUrl.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(avatarUrl),
                      )
                    : const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                title: Text(name),
              );
            },
          );
        }),
      ),
    );
  }
}

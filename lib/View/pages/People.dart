import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickdealsadmin/Controller/provider/people_provider.dart';
import 'package:quickdealsadmin/View/pages/user_detaile_page.dart';
import 'package:quickdealsadmin/View/widgets/appbar/People_appbar.dart';

class People extends StatelessWidget {
  const People({super.key});

  @override
  Widget build(BuildContext context) {
    final PeopleController peopleController = Get.put(PeopleController());

    return Scaffold(
      appBar: const PeopleCustomAppBar(),
      body: SafeArea(
        child: Obx(() {
          final peopleData = peopleController.filteredPeople;

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
              final String documentId = person['documentId'] ?? '';

              return ListTile(
                leading: avatarUrl.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(avatarUrl),
                        onBackgroundImageError: (error, stackTrace) {
                          // Handle image load error
                          print('Failed to load image: $error');
                        },
                      )
                    : const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                title: Text(name),
                subtitle: Text('Document ID: $documentId'),
              onTap: () {
  Get.to(() => ProfileDetailPage(), arguments: {
    'username': person['username'] ?? 'Unknown',
    'profilePicture': person['profilePicture'] ?? '',
    'email': person['email'] ?? 'No Email',
    'documentId': documentId.isNotEmpty ? documentId : 'No Document ID',
  });
},

              );
            },
          );
        }),
      ),
    );
  }
}

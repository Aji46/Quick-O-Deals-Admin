// import 'package:flutter/material.dart';

// class PeoplePage extends StatelessWidget {
//   const PeoplePage({super.key});

//   @override
//   Widget build(BuildContext context) {
   
//     final List<String> people = ['John Doe', 'Jane Smith', 'Alex Johnson', 'Emily Davis'];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('People'),
//       ),
//       body: ListView.separated(
//         itemCount: people.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(people[index]),
//             leading: const Icon(Icons.person),
//             onTap: () {
//               // Handle tap event, e.g., navigate to a detail page
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Tapped on ${people[index]}')),
//               );
//             },
//           );
//         },
//         separatorBuilder: (context, index) {
//           return const Divider(); // Separator between items
//         },
//       ),
//     );
//   }
// }


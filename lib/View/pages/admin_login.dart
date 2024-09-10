// // lib/View/pages/login_screen.dart
// import 'package:flutter/material.dart';
// import 'package:quickdealsadmin/View/pages/home.dart';

// import '../widgets/logo.dart';
// import '../widgets/textformfiled/coustom_text.dart';
// import '../widgets/validation/validation.dart';

// class LoginScreen extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   LoginScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Align(
//                     alignment: Alignment.topLeft,
//                     child: Logo(),
//                   ),
//                   const SizedBox(height: 30),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.bottomLeft,
//                       child: Image.asset(
//                         "assets/OIG1 (1).jpeg",
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Right side (login form)
//             Align(
//               alignment: Alignment.centerRight,
//               child: Center(
//                 child: SingleChildScrollView(
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       width: 500,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 255, 255, 255),
//                         border: Border.all(color: Colors.black, width: 2.0),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CustomTextFormField(
//                             controller: emailController,
//                             labelText: "Email",
//                             keyboardType: TextInputType.emailAddress,
//                             validator: (value) =>
//                                 ValidationUtils.validateemail(value),
//                           ),
//                           CustomTextFormField(
//                             controller: passwordController,
//                             labelText: "Password",
//                             validator: (value) =>
//                                 ValidationUtils.validate(value, 'Password'),
//                             isPassword: true,
//                           ),
//                           const SizedBox(height: 20),
//                           ElevatedButton(
                           
//                           const SizedBox(height: 10),
//                           TextButton(
//                             onPressed: () {
//                               // Implement forgot password functionality
//                             },
//                             child: const Text('Forgot Password?'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

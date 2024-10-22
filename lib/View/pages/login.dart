import 'package:flutter/material.dart';
import 'package:quickdealsadmin/Controller/login_controll.dart';
import 'package:quickdealsadmin/View/widgets/loginform/loginform.dart';

import '../widgets/logo.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = LoginController(context);

    // MediaQuery to get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 900; // Desktop breakpoint
    final isMediumScreen = screenWidth > 600 && screenWidth <= 900; // Tablet breakpoint
    final isSmallScreen = screenWidth <= 600; // Mobile breakpoint

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (isLargeScreen)
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Logo(),
                        ),
                        const SizedBox(height: 30),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.asset(
                              "assets/OIG1 (1).jpeg",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  flex: isLargeScreen ? 1 : (isMediumScreen ? 2 : 3), // Adjust flex based on screen size
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        width: isLargeScreen
                            ? 500
                            : (isMediumScreen ? screenWidth * 0.6 : screenWidth * 0.85), // Responsive width
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoginForm(
                                formKey: _formKey,
                                emailController: emailController,
                                passwordController: passwordController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

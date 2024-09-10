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

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
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
            Align(
              alignment: Alignment.centerRight,
              child: Center(
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 500,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
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
      ),
    );
  }
}

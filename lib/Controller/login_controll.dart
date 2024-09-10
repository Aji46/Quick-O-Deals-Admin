import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {
  final BuildContext context;

  LoginController(this.context);

  Future<void> login(String email, String password) async {
    const allowedEmail = 'ajilesh47@gmail.com';
    const allowedPassword = '8943381295';

    if (email == allowedEmail && password == allowedPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        Navigator.pushReplacementNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        _showErrorDialog(e.message ?? 'An error occurred');
      } catch (e) {
        // For general exceptions that aren't Firebase-specific
        _showErrorDialog('An unexpected error occurred');
      }
    } else {
      _showErrorDialog('Invalid email or password');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

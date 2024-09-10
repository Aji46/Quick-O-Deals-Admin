import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickdealsadmin/Controller/provider/email_auth.dart';
import 'package:quickdealsadmin/View/pages/dashboard.dart';
import 'package:quickdealsadmin/View/pages/home.dart';
import 'package:quickdealsadmin/View/widgets/coustom_button.dart';
import 'package:quickdealsadmin/View/widgets/textformfiled/coustom_text.dart';
import 'package:quickdealsadmin/View/widgets/validation/validation.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>(); 

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                controller: emailController,
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                validator: (value) => ValidationUtils.validateemail(value),
              ),
              CustomTextFormField(
                controller: passwordController,
                labelText: "Password",
                validator: (value) => ValidationUtils.validate(value, 'Password'),
                isPassword: true,
              ),
              const SizedBox(height: 24.0),
              CustomButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() == true) {
                    try {
                      await authController.signInWithEmailAndPassword(
                        emailController.text,
                        passwordController.text,
                      );

                      if (authController.user.value != null) {
                        Get.off(() => const BaseLayout(content: Dashboard()));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                  }
                },
                buttonText: 'Sign In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

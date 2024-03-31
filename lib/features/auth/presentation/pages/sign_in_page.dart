import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_architecture/features/auth/presentation/pages/sign_up_page.dart';

import '../../../../core/theme/app_palette.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_btn.dart';

class SignInPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignInPage(),
      );
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Sign In.',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AuthField(
                  hintText: 'Email',
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                AuthField(
                  hintText: 'Password',
                  controller: passwordController,
                  isObscureText: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        AuthGradientBtn(
          buttonText: 'Sign In',
          onPressed: () {
            if (formKey.currentState!.validate()) {
              // context.read<AuthBloc>().add(
              //   AuthSignUp(
              //     email: emailController.text.trim(),
              //     password: passwordController.text.trim(),
              //     name: nameController.text.trim(),
              //   ),
              // );
            }
          },
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.push(context, SignUpPage.route());
          },
          child: RichText(
            text: TextSpan(
              text: 'Don\'t have an account? ',
              style: Theme.of(context).textTheme.titleMedium,
              children: [
                TextSpan(
                  text: 'Sign Up',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppPalette.gradient2,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

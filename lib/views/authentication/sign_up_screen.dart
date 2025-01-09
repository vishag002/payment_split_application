import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_application/controller/auth_controller.dart';
import 'package:split_application/views/authentication/login_screen.dart';
import 'package:split_application/views/bottom_nav_bar_screen.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();

    final authController = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _header(),
          _emailfield(_emailController),
          _passwordfield(_passwordController),
          _confirmPasswordField(_confirmPasswordController),
          _signUpButton(context, ref, _emailController, _passwordController,
              _confirmPasswordController),
          _alreadyHaveAnAccount(context),
        ],
      ),
    );
  }
}

Widget _header() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      "Sign Up",
      style: TextStyle(fontSize: 30),
    ),
  );
}

Widget _emailfield(_emailController) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: "Email",
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget _passwordfield(_passwordController) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: "Password",
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget _confirmPasswordField(_confirmPasswordController) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      controller: _confirmPasswordController,
      decoration: InputDecoration(
        hintText: "Confirm Password",
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget _signUpButton(
    BuildContext context,
    WidgetRef ref,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () async {
        if (passwordController.text == confirmPasswordController.text) {
          final authController = ref.read(authControllerProvider.notifier);
          await authController.signUp(
              emailController.text, passwordController.text);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Passwords do not match!")),
          );
        }
      },
      child: Container(
        width: 50,
        height: 50,
        child: Center(
          child: Text("Sign Up"),
        ),
      ),
    ),
  );
}

Widget _loginButton(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      child: Container(
        width: 50,
        height: 50,
        child: Center(
          child: Text("Login"),
        ),
      ),
    ),
  );
}

Widget _alreadyHaveAnAccount(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
      child: Center(
        child: Text("Already have an account? Login"),
      ),
    ),
  );
}

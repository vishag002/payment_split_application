import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_application/controller/auth_controller.dart';
import 'package:split_application/views/authentication/sign_up_screen.dart';
import 'package:split_application/views/bottom_nav_bar_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _header(),
          _emailfield(_emailController),
          _passwordfield(_passwordController),
          loginButton(
            context,
            _emailController,
            _passwordController,
            ref,
          ),
          _newUserRegistration(context),
        ],
      ),
    );
  }
}

Widget _header() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      "Login",
      style: TextStyle(fontSize: 30),
    ),
  );
}

Widget _emailfield(_emailController) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: "Email",
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter a valid email';
        }
        return null;
      },
    ),
  );
}

Widget _passwordfield(_passwordController) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: "Password",
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter a password';
        }
        return null;
      },
    ),
  );
}

Widget loginButton(
  context,
  _emailController,
  _passwordController,
  WidgetRef ref,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () async {
        if (_emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          final authController = ref.read(authControllerProvider.notifier);
          await authController.signIn(
              _emailController.text, _passwordController.text);
          authController.signIn(
            _emailController.text,
            _passwordController.text,
          );
          login(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("login credentials dont match")),
          );
        }
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

void login(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
  );
}

Widget _newUserRegistration(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpScreen()),
        );
      },
      child: Center(
        child: Text("New User Registration ?"),
      ),
    ),
  );
}

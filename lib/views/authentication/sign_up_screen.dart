import 'package:flutter/material.dart';
import 'package:split_application/views/authentication/login_screen.dart';
import 'package:split_application/views/bottom_nav_bar_screen.dart';
import 'package:split_application/views/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _header(),
          _emailfield(),
          _passwordfield(),
          _confirmPasswordField(),
          _signUpButton(context),
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

Widget _emailfield() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Email",
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget _passwordfield() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Password",
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget _confirmPasswordField() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Confirm Password",
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget _signUpButton(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        signUp(context);
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

void signUp(context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
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

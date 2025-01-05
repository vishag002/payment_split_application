import 'package:flutter/material.dart';
import 'package:split_application/views/authentication/sign_up_screen.dart';
import 'package:split_application/views/bottom_nav_bar_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _header(),
          _emailfield(),
          _passwordfield(),
          LoginButton(context),
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

Widget LoginButton(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        login(context);
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

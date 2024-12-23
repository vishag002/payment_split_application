import 'package:flutter/material.dart';
import 'package:split_application/utilis/components/app_dimensions.dart';
import 'package:split_application/views/bottom_nav_bar_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          // Setup MediaQuery dimensions
          AppDimensions.setup(context);
          return BottomNavBarScreen();
        },
      ),
    );
  }
}

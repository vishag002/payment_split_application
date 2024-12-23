import 'package:flutter/material.dart';

class AppDimensions {
  // Initialize with default values, will be overridden in setup
  static double screenWidth = 0;
  static double screenHeight = 0;

  // Setup method to initialize dimensions
  static void setup(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  // Percentage-based dimensions
  static double widthPercentage(double percent) {
    return screenWidth * (percent / 100);
  }

  static double heightPercentage(double percent) {
    return screenHeight * (percent / 100);
  }
}

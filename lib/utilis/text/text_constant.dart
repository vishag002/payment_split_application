import 'package:flutter/material.dart';
import 'package:split_application/utilis/colors/color_constant.dart';

class AppTextStyles {
  // Standard Text Sizes
  static const double smallTextSize = 12.0; // Captions, Hints
  static const double regularTextSize = 14.0; // Body Text
  static const double mediumTextSize = 16.0; // Subheadings
  static const double largeTextSize = 20.0; // Headings
  static const double extraLargeTextSize = 24.0; // Titles

  // Font Weights
  static const FontWeight lightWeight = FontWeight.w300;
  static const FontWeight regularWeight = FontWeight.w400;
  static const FontWeight mediumWeight = FontWeight.w500;
  static const FontWeight semiBoldWeight = FontWeight.w600;
  static const FontWeight boldWeight = FontWeight.w700;

  // Text Styles
  static const TextStyle mainHeading = TextStyle(
    fontSize: extraLargeTextSize, // Use for headings
    fontWeight: boldWeight,
    color: AppColors.primaryTextColor,
  );
  static const TextStyle headingStyle = TextStyle(
    fontSize: largeTextSize, // Use for headings
    fontWeight: boldWeight,
    color: AppColors.primaryTextColor,
  );
  static const TextStyle subHeadingStyle = TextStyle(
    fontSize: mediumTextSize, // Use for headings
    fontWeight: boldWeight,
    color: AppColors.primaryTextColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: regularTextSize, // Use for body text
    fontWeight: regularWeight,
    color: AppColors.primaryTextColor,
  );

  static const TextStyle captionStyle = TextStyle(
    fontSize: smallTextSize, // Use for captions or hints
    fontWeight: regularWeight,
    color: AppColors.secondaryTextColor,
  );
}

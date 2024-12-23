import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:split_application/utilis/colors/color_constant.dart';
import 'package:split_application/utilis/text/text_constant.dart';
import 'package:split_application/views/expense_screen.dart';
import 'package:split_application/views/home_screen.dart';
import 'package:split_application/views/profile_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          ExpenseScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: bottomBarStyle(_currentIndex, _onTabTapped),
    );
  }
}

Widget bottomBarStyle(int currentIndex, Function(int) changeTab) {
  return SizedBox(
    height: 80,
    width: double.infinity,
    child: BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: changeTab,
      enableFeedback: true,
      unselectedLabelStyle: AppTextStyles.captionStyle.copyWith(
        fontSize: 12,
      ),
      selectedLabelStyle: AppTextStyles.captionStyle.copyWith(
        fontSize: 12,
      ),
      backgroundColor: AppColors.secondaryColor,
      elevation: 0,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey,
      iconSize: 30,
      selectedFontSize: 12,
      items: const [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Icon(IconsaxPlusLinear.home_1),
          ), // Default (unselected) icon
          activeIcon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Icon(
              IconsaxPlusBold.home_1, // Selected icon
              color: AppColors.primaryColor,
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Icon(IconsaxPlusLinear.transaction_minus),
          ), // Default (unselected) icon
          activeIcon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Icon(
              IconsaxPlusBold.transaction_minus, // Selected icon
              color: AppColors.primaryColor,
            ),
          ),
          label: 'transactions',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Icon(IconsaxPlusLinear.profile_circle),
          ), // Default (unselected) icon
          activeIcon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Icon(
              IconsaxPlusBold.profile_circle, // Selected icon
              color: AppColors.primaryColor,
            ),
          ),
          label: 'Profile',
        ),
      ],
    ),
  );
}

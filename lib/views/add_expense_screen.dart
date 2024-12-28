import 'package:flutter/material.dart';
import 'package:split_application/utilis/colors/color_constant.dart';
import 'package:split_application/utilis/components/app_dimensions.dart';
import 'package:split_application/utilis/text/text_constant.dart';
import 'package:split_application/views/add_members_screen.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _header(),
          _amountTextField(),
          _nextButton(context: context),
        ],
      ),
    );
  }
}

Widget _header() {
  return Text(
    "Enter Amount...",
    style: AppTextStyles.headingStyle,
  );
}

Widget _amountTextField() {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: AppDimensions.widthPercentage(30),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "₹", // Adding rupee symbol
          style: TextStyle(
            fontSize: 24, // Adjust size to match desired appearance
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
            width:
                8), // Add spacing between the rupee symbol and the text field
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number, // Restrict to number input
            decoration: InputDecoration(
              hintText: "Enter amount", // Placeholder text
              border: InputBorder.none, // No border like Google Pay
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.blue, width: 2), // Blue underline on focus
              ),
              hintStyle: TextStyle(
                fontSize: 18, // Adjust size to match Google Pay UI
                color: Colors.grey,
              ),
            ),
            style: TextStyle(
              fontSize: 24, // Match font size of entered amount
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _nextButton({context}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddMembersScreen(),
          ));
    },
    child: Container(
      height: AppDimensions.heightPercentage(6),
      width: AppDimensions.widthPercentage(95),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.primaryColor,
      ),
      child: Center(
        child: Text(
          "Next",
          style: AppTextStyles.subHeadingStyle.copyWith(
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    ),
  );
}

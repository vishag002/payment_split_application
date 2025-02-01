import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_application/controller/equal_split_controller.dart';
import 'package:split_application/utilis/colors/color_constant.dart';
import 'package:split_application/utilis/components/app_dimensions.dart';
import 'package:split_application/utilis/text/text_constant.dart';
import 'package:split_application/views/add_members_screen.dart';

class AddExpenseScreen extends ConsumerWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController amountController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _header(),
          _amountTextField(amountController: amountController),
          //  _nextButton(context: context, amountController: amountController),
          _nextButton(
              context: context, ref: ref, amountController: amountController),
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

Widget _amountTextField({amountController}) {
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
            controller: amountController,
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

Widget _nextButton(
    {required BuildContext context, required WidgetRef ref, amountController}) {
  return InkWell(
    onTap: () {
      final amount = double.tryParse(amountController.text);
      if (amount != null) {
        // Use `ref` to interact with the provider
        ref.read(splitPaymentProvider.notifier).saveAmount(amount);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddMembersScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter a valid amount")),
        );
      }
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

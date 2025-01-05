import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_application/utilis/colors/color_constant.dart';
import 'package:split_application/utilis/components/app_dimensions.dart';
import 'package:split_application/utilis/text/text_constant.dart';
import 'package:split_application/views/expense_spliting_screen.dart';

class AddMembersScreen extends ConsumerWidget {
  const AddMembersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Members"),
      ),
      body: Column(
        children: [
          ContactsList(),
          //SelectedMembersList(),
          continueButton(context: context),
        ],
      ),
    );
  }
}

class ContactsList extends ConsumerWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
            ),
            title: Text("Contact Name"),
            trailing: IconButton(
                onPressed: () {
                  //
                },
                icon: Icon(Icons.check_box)),
          );
        },
      ),
    );
  }
}

//
class SelectedMembersList extends ConsumerWidget {
  const SelectedMembersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
        //
        );
  }
}

Widget continueButton({context}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExpenseSplitingScreen(),
        ),
      );
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

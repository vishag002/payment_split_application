import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_application/controller/select_member_controller.dart';
import 'package:split_application/controller/split_payment_controller.dart';
import 'package:split_application/utilis/colors/color_constant.dart';
import 'package:split_application/utilis/components/app_dimensions.dart';
import 'package:split_application/utilis/text/text_constant.dart';

class ExpenseSplitingScreen extends ConsumerWidget {
  const ExpenseSplitingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          groupName(),
          category_type(),
          splitWidgets(),
          continueButton(context: context),
        ],
      ),
    );
  }
}

Widget groupName() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Group Name",
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget category_type() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Category",
        border: OutlineInputBorder(),
      ),
    ),
  );
}

class splitWidgets extends ConsumerWidget {
  const splitWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.account_balance),
                  text: 'Split',
                ),
                Tab(
                  icon: Icon(Icons.settings),
                  text: 'Custom Split',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  EqualSplit(),
                  CustomSplit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget EqualSplit() {
  return Container(
    height: 150,
    width: 200,
    //color: Colors.amberAccent,
    child: splitEqualTile(),
  );
}

Widget CustomSplit() {
  return Container(
    height: 150,
    width: 200,
    //color: Colors.lightBlueAccent,
    child: splitCustomTile(),
  );
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

// Widget for displaying split amounts
Widget splitEqualTile() {
  return Consumer(
    builder: (context, ref, child) {
      final members = ref.watch(membersProvider);
      final totalAmount = ref.watch(splitPaymentProvider);
      final splitAmount = totalAmount != null
          ? (totalAmount / members.length).toStringAsFixed(2)
          : '0.00';

      return ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: members.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(members[index].name),
            trailing: SizedBox(
              width: 100,
              child: TextFormField(
                readOnly: true,
                initialValue: splitAmount,
                decoration: const InputDecoration(
                  border: null,
                  prefixText: '\$', // Add currency symbol if needed
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Widget splitCustomTile() {
  return Consumer(
    builder: (context, ref, child) {
      final members = ref.watch(membersProvider);

      return ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: members.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(members[index].name),
            trailing: SizedBox(
              width: 100,
              child: TextFormField(
                readOnly: false,
                decoration: const InputDecoration(
                  border: null,
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

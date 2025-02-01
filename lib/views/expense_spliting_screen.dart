import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_application/controller/select_member_controller.dart';
import 'package:split_application/controller/equal_split_controller.dart';
import 'package:split_application/utilis/colors/color_constant.dart';
import 'package:split_application/utilis/components/app_dimensions.dart';
import 'package:split_application/utilis/text/text_constant.dart';
import 'package:split_application/views/bottom_nav_bar_screen.dart';
import 'package:split_application/views/custom_split_screen.dart';

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

// Widget CustomSplit() {
//   List<Map<String, dynamic>> _users = [];
//   List<TextEditingController> _controllers = [];
//   Set<int> _editedUsers = {}; // Track manually edited users

//   void dispose() {
//     _totalAmountController.dispose();
//     _totalUsersController.dispose();
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   //update amount
//   void _updateAmounts(int index) {
//     double totalAmount = double.tryParse(_totalAmountController.text) ?? 0.0;
//     double usedAmount =
//         _users.take(index + 1).fold(0.0, (sum, user) => sum + user['amount']);
//     double remainingAmount = totalAmount - usedAmount;
//     int remainingUsers = _users.length - index - 1;

//     if (remainingUsers > 0) {
//       double splitAmount = remainingAmount / remainingUsers;

//       for (int i = index + 1; i < _users.length; i++) {
//         if (!_editedUsers.contains(i)) {
//           _users[i]['amount'] = splitAmount.clamp(1.0, remainingAmount);
//           _controllers[i].text = _users[i]['amount'].toStringAsFixed(2);
//         }
//       }
//     }
//   }

//   //
//   void _validateSplit() {
//     double totalAmount = double.tryParse(_totalAmountController.text) ?? 0;
//     double splitAmount =
//         _users.fold(0.0, (sum, user) => sum + (user['amount'] ?? 0));

//     if ((totalAmount - splitAmount).abs() < 0.01) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Split Success!')),
//       );
//       setState(() {
//         _totalAmountController.clear();
//         _totalUsersController.clear();
//         _users.clear();
//         _controllers.clear();
//         _editedUsers.clear();
//       });
//     } else {
//       String message = splitAmount < totalAmount
//           ? 'The split amount is less by ${(totalAmount - splitAmount).toStringAsFixed(2)}'
//           : 'The split amount is greater by ${(splitAmount - totalAmount).toStringAsFixed(2)}';
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(message)),
//       );
//     }
//   }

//   return Container(
//     height: 150,
//     width: 200,
//     //color: Colors.lightBlueAccent,
//     child: splitCustomTile(),
//   );
// }

Widget continueButton({context}) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const BottomNavBarScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Fade animation
            final fadeAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );
            // Slight scale animation
            final scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            );
            return FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => BottomNavBarScreen(),
      //   ),
      // );
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

/////////////////////
///
///
///
///
///
///

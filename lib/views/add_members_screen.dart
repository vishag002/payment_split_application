import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_application/controller/select_member_controller.dart';
import 'package:split_application/utilis/colors/color_constant.dart';
import 'package:split_application/utilis/components/app_dimensions.dart';
import 'package:split_application/utilis/text/text_constant.dart';
import 'package:split_application/views/expense_spliting_screen.dart';

class AddMembersScreen extends ConsumerWidget {
  const AddMembersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Members"),
      ),
      body: Column(
        children: [
          if (members.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("No members added yet. Click + to add members."),
              ),
            ),
          Expanded(
            child: SelectedMembersList(),
          ),
          continueButton(context: context),
        ],
      ),
      floatingActionButton: fabButton(context, ref),
    );
  }
}

// Update the SelectedMembersList
class SelectedMembersList extends ConsumerWidget {
  const SelectedMembersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersProvider);

    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return ListTile(
          leading: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                member.name[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          title: Text(member.name),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(membersProvider.notifier).removeMember(member.id);
            },
          ),
        );
      },
    );
  }
}

// Update the fabButton
Widget fabButton(BuildContext context, WidgetRef ref) {
  return FloatingActionButton(
    child: const Icon(Icons.add),
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final textController = TextEditingController();

          return AlertDialog(
            title: const Text("Add Member"),
            content: TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: "Member Name",
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    ref
                        .read(membersProvider.notifier)
                        .addMember(textController.text);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Add"),
              ),
            ],
          );
        },
      );
    },
  );
}

// Update the continueButton
Widget continueButton({required BuildContext context}) {
  return Consumer(
    builder: (context, ref, child) {
      final members = ref.watch(membersProvider);

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: members.isEmpty
              ? null
              : () {
                  ref.read(membersProvider.notifier).saveMember();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExpenseSplitingScreen(),
                    ),
                  );
                },
          child: Container(
            height: AppDimensions.heightPercentage(6),
            width: AppDimensions.widthPercentage(95),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: members.isEmpty ? Colors.grey : AppColors.primaryColor,
            ),
            child: Center(
              child: Text(
                "Continue",
                style: AppTextStyles.subHeadingStyle.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
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

// //
// class SelectedMembersList extends ConsumerWidget {
//   const SelectedMembersList({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//         //
//         );
//   }
// }

// Widget fabButton(BuildContext context) {
//   return FloatingActionButton(
//     child: Icon(Icons.add),
//     onPressed: () {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           TextEditingController textController = TextEditingController();

//           return AlertDialog(
//             title: Text("Enter Details"),
//             content: TextField(
//               controller: textController,
//               decoration: InputDecoration(
//                 labelText: "Your Input",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   // Close the dialog without doing anything
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("Cancel"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   String userInput = textController.text;
//                   // Perform actions with userInput here
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//                 child: Text("Confirm"),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }

// Widget continueButton({context}) {
//   return InkWell(
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ExpenseSplitingScreen(),
//         ),
//       );
//     },
//     child: Container(
//       height: AppDimensions.heightPercentage(6),
//       width: AppDimensions.widthPercentage(95),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30),
//         color: AppColors.primaryColor,
//       ),
//       child: Center(
//         child: Text(
//           "Continue",
//           style: AppTextStyles.subHeadingStyle.copyWith(
//             color: AppColors.secondaryColor,
//           ),
//         ),
//       ),
//     ),
//   );
// }

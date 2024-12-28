import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          SelectedMembersList(),
        ],
      ),
    );
  }
}

class ContactsList extends ConsumerWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
        );
      },
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

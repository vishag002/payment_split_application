import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_application/controller/select_member_controller.dart';
import 'package:split_application/controller/equal_split_controller.dart';

class CustomSplit extends StatefulWidget {
  @override
  _CustomSplitState createState() => _CustomSplitState();
}

class _CustomSplitState extends State<CustomSplit> {
  final List<TextEditingController> _controllers = [];
  final Set<int> _editedUsers = {}; // Track manually edited users
  late List<Map<String, dynamic>> _users;

  @override
  void initState() {
    super.initState();
    _users = [];
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateAmounts(int index, ref) {
    final totalAmount = ref.watch(splitPaymentProvider);
    double usedAmount =
        _users.take(index + 1).fold(0.0, (sum, user) => sum + user['amount']);
    double remainingAmount = totalAmount - usedAmount;
    int remainingUsers = _users.length - index - 1;

    if (remainingUsers > 0) {
      double splitAmount = remainingAmount / remainingUsers;
      for (int i = index + 1; i < _users.length; i++) {
        if (!_editedUsers.contains(i)) {
          setState(() {
            _users[i]['amount'] = splitAmount.clamp(1.0, remainingAmount);
            _controllers[i].text = _users[i]['amount'].toStringAsFixed(2);
          });
        }
      }
    }
  }

  void _validateSplit(ref) {
    final totalAmount = ref.watch(splitPaymentProvider);

    double splitAmount =
        _users.fold(0.0, (sum, user) => sum + (user['amount'] ?? 0.0));

    if ((totalAmount - splitAmount).abs() < 0.01) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Split Success!')),
      );
      setState(() {
        // _totalAmountController.clear();
        _users.clear();
        _controllers.clear();
        _editedUsers.clear();
      });
    } else {
      String message = splitAmount < totalAmount
          ? 'The split amount is less by ${(totalAmount - splitAmount).toStringAsFixed(2)}'
          : 'The split amount is greater by ${(splitAmount - totalAmount).toStringAsFixed(2)}';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final members = ref.watch(membersProvider);

        // Initialize users and controllers dynamically
        if (_users.isEmpty) {
          _users = members
              .map((member) => {'name': member.name, 'amount': 0.0})
              .toList();
          _controllers.addAll(
            List.generate(
              members.length,
              (index) => TextEditingController(),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(members[index].name),
                    trailing: SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: _controllers[index],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: null,
                          hintText: 'Amount',
                        ),
                        onChanged: (value) {
                          double? newAmount = double.tryParse(value);
                          if (newAmount != null) {
                            setState(() {
                              _users[index]['amount'] = newAmount;
                              _editedUsers.add(index);
                              _updateAmounts(index, ref);
                            });
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _validateSplit(ref);
              },
              child: const Text('Validate Split'),
            ),
          ],
        );
      },
    );
  }
}

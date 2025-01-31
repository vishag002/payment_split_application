import 'dart:math';
import 'package:flutter/material.dart';

class SplitAmountScreen extends StatefulWidget {
  @override
  _SplitAmountScreenState createState() => _SplitAmountScreenState();
}

class _SplitAmountScreenState extends State<SplitAmountScreen> {
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _totalUsersController = TextEditingController();
  List<Map<String, dynamic>> _users = [];
  List<TextEditingController> _controllers = [];
  Set<int> _editedUsers = {}; // Track manually edited users

  @override
  void dispose() {
    _totalAmountController.dispose();
    _totalUsersController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _generateUsers() {
    setState(() {
      _users.clear();
      _editedUsers.clear();
      _controllers.clear(); // Clear existing controllers to avoid mismatches

      int totalUsers = int.tryParse(_totalUsersController.text) ?? 0;
      for (int i = 0; i < totalUsers; i++) {
        _users.add({
          'id': _generateRandomId(),
          'amount': 0.0,
        });
        _controllers.add(TextEditingController(text: '0.00'));
      }
    });
  }

  String _generateRandomId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return List.generate(5, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  void _updateAmounts(int index) {
    double totalAmount = double.tryParse(_totalAmountController.text) ?? 0.0;
    double usedAmount =
        _users.take(index + 1).fold(0.0, (sum, user) => sum + user['amount']);
    double remainingAmount = totalAmount - usedAmount;
    int remainingUsers = _users.length - index - 1;

    if (remainingUsers > 0) {
      double splitAmount = remainingAmount / remainingUsers;

      for (int i = index + 1; i < _users.length; i++) {
        if (!_editedUsers.contains(i)) {
          _users[i]['amount'] = splitAmount.clamp(1.0, remainingAmount);
          _controllers[i].text = _users[i]['amount'].toStringAsFixed(2);
        }
      }
    }
  }

  double _calculateUsedAmount() {
    return _users.fold(0.0, (sum, user) => sum + user['amount']);
  }

  void _validateSplit() {
    double totalAmount = double.tryParse(_totalAmountController.text) ?? 0;
    double splitAmount =
        _users.fold(0.0, (sum, user) => sum + (user['amount'] ?? 0));

    if ((totalAmount - splitAmount).abs() < 0.01) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Split Success!')),
      );
      setState(() {
        _totalAmountController.clear();
        _totalUsersController.clear();
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
    double totalAmount = double.tryParse(_totalAmountController.text) ?? 0.0;
    double usedAmount = _calculateUsedAmount();
    double progress = totalAmount > 0 ? usedAmount / totalAmount : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Split Amount'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _totalAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Total Amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _generateUsers(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _totalUsersController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Total Users',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _generateUsers(),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('User ${index + 1} - ${_users[index]['id']}'),
                  trailing: Container(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        border: OutlineInputBorder(),
                      ),
                      controller: _controllers[index],
                      onChanged: (value) {
                        setState(() {
                          double enteredValue =
                              max(double.tryParse(value) ?? 0.0, 1.0);
                          _users[index]['amount'] = enteredValue;
                          _editedUsers.add(index);
                          _updateAmounts(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _validateSplit,
              child: Text('Validate Split'),
            ),
          ],
        ),
      ),
    );
  }
}

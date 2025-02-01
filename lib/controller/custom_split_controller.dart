import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:split_application/controller/equal_split_controller.dart';

// State class to hold split user data
class SplitUser {
  final String name;
  final double amount;
  final bool isEdited;

  SplitUser({
    required this.name,
    this.amount = 0.0,
    this.isEdited = false,
  });

  SplitUser copyWith({
    String? name,
    double? amount,
    bool? isEdited,
  }) {
    return SplitUser(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      isEdited: isEdited ?? this.isEdited,
    );
  }
}

// State notifier to manage the split users
class CustomSplitNotifier extends StateNotifier<List<SplitUser>> {
  CustomSplitNotifier() : super([]);

  void initializeUsers(List<dynamic> members) {
    state = members.map((member) => SplitUser(name: member.name)).toList();
  }

  void updateUserAmount(int index, double amount) {
    state = [
      ...state.asMap().entries.map((entry) {
        if (entry.key == index) {
          return entry.value.copyWith(amount: amount, isEdited: true);
        }
        return entry.value;
      })
    ];
    _redistributeRemaining(index, Ref);
  }

  void _redistributeRemaining(int changedIndex, ref) {
    final totalTarget = ref.read(splitPaymentProvider);
    double usedAmount = state
        .take(changedIndex + 1)
        .fold(0.0, (sum, user) => sum + user.amount);
    double remainingAmount = totalTarget - usedAmount;
    int remainingUsers = state.length - changedIndex - 1;

    if (remainingUsers > 0) {
      double splitAmount = remainingAmount / remainingUsers;
      state = [
        ...state.asMap().entries.map((entry) {
          if (entry.key > changedIndex && !entry.value.isEdited) {
            return entry.value.copyWith(
              amount: splitAmount.clamp(1.0, remainingAmount),
            );
          }
          return entry.value;
        })
      ];
    }
  }

  void reset() {
    state = [];
  }

  (bool, String) validateSplit(ref) {
    final totalTarget = ref.read(splitPaymentProvider);
    double splitAmount = state.fold(0.0, (sum, user) => sum + user.amount);

    if ((totalTarget - splitAmount).abs() < 0.01) {
      return (true, 'Split Success!');
    } else {
      String message = splitAmount < totalTarget
          ? 'The split amount is less by ${(totalTarget - splitAmount).toStringAsFixed(2)}'
          : 'The split amount is greater by ${(splitAmount - totalTarget).toStringAsFixed(2)}';
      return (false, message);
    }
  }
}

// Provider for the CustomSplitNotifier
final customSplitProvider =
    StateNotifierProvider<CustomSplitNotifier, List<SplitUser>>((ref) {
  return CustomSplitNotifier();
});

// Provider for text editing controllers
final textControllersProvider = Provider<List<TextEditingController>>((ref) {
  final users = ref.watch(customSplitProvider);
  return List.generate(
    users.length,
    (index) => TextEditingController(
      text:
          users[index].amount > 0 ? users[index].amount.toStringAsFixed(2) : '',
    ),
  );
});

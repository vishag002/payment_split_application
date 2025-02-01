import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplitPaymentController extends StateNotifier<double?> {
  SplitPaymentController() : super(null);

  // Save the total amount to Shared Preferences
  Future<void> saveAmount(double amount) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('total_amount', amount);
      state = amount; // Update the state for Riverpod consumers
    } catch (e) {
      print("Error saving amount to Shared Preferences: $e");
    }
  }

  // Retrieve the saved amount from Shared Preferences
  Future<void> loadAmount() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      state = prefs.getDouble('total_amount');
    } catch (e) {
      print("Error loading amount from Shared Preferences: $e");
    }
  }

  // Split equally among members
  double? getEqualSplit(int memberCount) {
    if (state == null || memberCount <= 0) return null;
    return state! / memberCount;
  }

  //split equally
}

final splitPaymentProvider =
    StateNotifierProvider<SplitPaymentController, double?>(
  (ref) => SplitPaymentController(),
);

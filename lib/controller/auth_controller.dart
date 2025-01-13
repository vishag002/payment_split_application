import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_application/utilis/constant/constants.dart';
import 'package:split_application/views/bottom_nav_bar_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Get the current user's ID
  String? getUserId() {
    final session = _supabaseClient.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }

  // SignIn with email and password
  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    return await _supabaseClient.auth.signInWithPassword(
      password: password,
      email: email,
    );
  }

  // SignUp with email and password
  Future<AuthResponse> signUpWithEmailAndPass(
      String email, String password) async {
    return await _supabaseClient.auth.signUp(
      password: password,
      email: email,
    );
  }

  // Sign out
  Future<void> signOut() async {
    return await _supabaseClient.auth.signOut();
  }

  // Get the current user's email
  String? getUserEmail() {
    final session = _supabaseClient.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}

// Riverpod StateNotifier for Authentication
class AuthController extends StateNotifier<AsyncValue<User?>> {
  AuthController(this._authService) : super(const AsyncValue.loading()) {
    //  _getCurrentUser();
  }

  final AuthService _authService;

  // Fetch current user
  // Future<void> _getCurrentUser() async {
  //   try {
  //     final userId = _authService.getUserId();
  //     if (userId != null) {
  //       state = AsyncValue.data(User(id: userId));
  //     } else {
  //       state = const AsyncValue.data(null);
  //     }
  //   } catch (e) {
  //     state = AsyncValue.error(e, StackTrace.current);
  //   }
  // }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      state = const AsyncValue.loading();

      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        state = AsyncValue.data(response.user);

        // Check if context is still valid
        if (context.mounted) {
          // Navigate to home screen and remove all previous routes
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BottomNavBarScreen(),
            ),
            (route) => false, // This removes all previous routes
          );
        }
      } else {
        throw Exception('Login failed - no user returned');
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);

      // Show error message if context is still valid
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // SignUp
  Future<void> signUp(
      String email, String password, BuildContext context) async {
    try {
      state = const AsyncValue.loading();

      final response =
          await _authService.signUpWithEmailAndPass(email, password);

      if (response.user != null) {
        state = AsyncValue.data(response.user);
        // Only navigate on successful signup
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
          );
        }
      } else {
        throw Exception('Signup failed');
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow; // Rethrow to handle in UI
    }
  }

  // SignOut
  Future<void> signOut() async {
    try {
      await _authService.signOut();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Provider for AuthService
final authServiceProvider = Provider((ref) => AuthService());

// Provider for AuthController
final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<User?>>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthController(authService);
});

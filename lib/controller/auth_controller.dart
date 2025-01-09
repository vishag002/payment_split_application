import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  // SignIn
  Future<void> signIn(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      final response =
          await _authService.signInWithEmailAndPassword(email, password);
      state = AsyncValue.data(response.user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // SignUp
  Future<void> signUp(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      final response =
          await _authService.signUpWithEmailAndPass(email, password);
      state = AsyncValue.data(response.user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
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

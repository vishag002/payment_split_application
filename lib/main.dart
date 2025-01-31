import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_application/utilis/components/app_dimensions.dart';
import 'package:split_application/utilis/constant/constants.dart';
import 'package:split_application/views/authentication/login_screen.dart';
import 'package:split_application/views/bottom_nav_bar_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          // Setup MediaQuery dimensions
          AppDimensions.setup(context);
          return BottomNavBarScreen();
          // LoginScreen();
        },
      ),
    );
  }
}

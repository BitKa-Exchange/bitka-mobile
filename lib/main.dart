import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'disclaimer_page.dart';
import 'app_shell.dart';

// Define the primary pink color from the screenshots
const Color primaryPink = Color(0xFFE91E63); // A guess, adjust as needed
const Color darkBg = Color(0xFF1A1A1A); // A guess for the dark background
const Color darkCard = Color(0xFF2C2C2C); // A guess for card backgrounds

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Crypto App',
      theme: ThemeData.dark().copyWith(
        primaryColor: primaryPink,
        scaffoldBackgroundColor: darkBg,
        cardColor: darkCard,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryPink,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkCard,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: darkCard,
          selectedItemColor: primaryPink,
          unselectedItemColor: Colors.grey[500],
          type: BottomNavigationBarType.fixed,
        ),
      ),
      debugShowCheckedModeBanner: false,
      // Define the routes for navigation
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/disclaimer': (context) => const DisclaimerPage(),
        '/app': (context) =>
            const AppShell(), // This will be the main app with bottom nav
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'core/theme/app_colors.dart'; 
import 'features/auth/login_screen.dart';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bitka',
      theme: ThemeData(
        fontFamily: 'Montserrat', 
        scaffoldBackgroundColor: AppColors.background, 
        useMaterial3: true,
      ),
      home: const LoginScreen(), 
    );
  }
}

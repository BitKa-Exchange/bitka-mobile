import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/theme/app_colors.dart'; 
import 'features/auth/login_screen.dart';


const String environment = String.fromEnvironment(
  'ENVIRONMENT', 
  // change defaultValue to .env.production' for production
  defaultValue: '.env.development'
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: environment);

  runApp(const BitkaApp());
}

class BitkaApp extends StatelessWidget {
  const BitkaApp({super.key}); 

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

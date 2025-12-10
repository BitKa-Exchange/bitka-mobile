import 'package:bitka/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_colors.dart'; 
import 'features/auth/login_screen.dart';


const String environment = String.fromEnvironment(
  'ENVIRONMENT', 
  defaultValue: '.env.development'
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: environment);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const BitkaApp(),
    ),
  );
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

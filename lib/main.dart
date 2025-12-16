import 'package:bitka/features/app_shell/app_shell_screen.dart';
import 'package:bitka/providers/auth_provider.dart';
import 'package:bitka/providers/ledger_provider.dart';
import 'package:bitka/providers/market_data_provider.dart';
import 'package:bitka/providers/orders_provider.dart';
import 'package:bitka/providers/user_provider.dart';
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
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LedgerProvider()),
        ChangeNotifierProvider(create: (_) => MarketDataProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
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
      home: const AuthChecker(), 
    );
  }
}

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.checkAuthStatus();
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => authProvider.isAuthenticated
            ? const AppShellScreen() 
            : const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [AppColors.backgroundGradient1, AppColors.backgroundGradient2],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
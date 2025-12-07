import 'package:bitka/features/account/account_screen.dart';
import 'package:bitka/features/account/account_setting_screen.dart';
import 'package:bitka/features/home/home_screen.dart';
import 'package:bitka/features/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../shared/widgets/page_selector/bottom_navbar.dart';

class AppShellScreen extends StatefulWidget {

  static final GlobalKey<AppShellScreenState> shellKey = 
    GlobalKey<AppShellScreenState>();

  const AppShellScreen({super.key});
  
  // 2. Public static function to change the index, using the context to find the state.
  static void navigateToIndex(BuildContext context, int index) {
    // This finds the closest ancestor State object of the public AppShellScreen type.
    final state = context.findAncestorStateOfType<AppShellScreenState>();
    
    if (state != null) {
      state._onItemTapped(index);
    } else {
      debugPrint('Error: AppShellScreen State not found. Cannot navigate.');
    }
  }

  @override
  State<AppShellScreen> createState() => AppShellScreenState();
}

class AppShellScreenState extends State<AppShellScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    WalletScreen(),
    Center(child: Text('Trade Screen', style: TextStyle(color: AppColors.textPrimary))),
    AccountScreen(), 
    AccountSettingScreen(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // The AppShellScreen handles the persistent structure (Scaffold, Nav Bar)
    return Scaffold(
      key: AppShellScreen.shellKey,
      // Set the background gradient here, applied to the entire screen
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.backgroundGradient1, AppColors.backgroundGradient2],
          ),
        ),
        // IndexedStack manages the screen shown based on the selected index
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      
      // The shared navigation bar component
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex.clamp(0, 3),
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
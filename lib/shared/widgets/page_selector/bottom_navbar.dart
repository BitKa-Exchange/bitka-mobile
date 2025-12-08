import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
// Import the reusable icon component
import '../icon_card.dart'; // <<< NEW REQUIRED IMPORT (Assuming path)

// --- Nav Bar Models ---
class NavItem {
  final String label;
  final IconData icon;
  final int index;

  NavItem({required this.label, required this.icon, required this.index});
}

// Sample data (can be moved to constants if needed)
final List<NavItem> navItems = [
  NavItem(label: 'Home', icon: Icons.home_filled, index: 0),
  NavItem(label: 'Wallet', icon: Icons.attach_money_rounded, index: 1),
  NavItem(label: 'Trade', icon: Icons.autorenew_rounded, index: 2),
  NavItem(label: 'Account', icon: Icons.person_outline_rounded, index: 3),
];

// ===================================================================
// CUSTOM BOTTOM NAVIGATION BAR WIDGET
// ===================================================================

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the safe area padding at the bottom 
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    
    return Container(
      height: 84 + bottomPadding,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 10, 16, bottomPadding),
      decoration: const ShapeDecoration(
        color: AppColors.surfaceSecondary, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: navItems.map((item) {
          final bool isSelected = item.index == selectedIndex;
          
          return Expanded(
            child: Padding(
              // The IconCard will use the padding/margin logic defined here to fit the Row
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: isSelected ? IconCard(
                  icon: item.icon,
                  label: item.label,
                  backgroundColor: AppColors.primaryPink,                  
                  onTap: () => onItemSelected(item.index),
                  // IconCard already handles the 69px height internally
                ) :
                  IconCard(
                  icon: item.icon,
                  label: item.label,
                  onTap: () => onItemSelected(item.index),
                // IconCard already handles the 69px height internally
                )
            ),
            // ---------------------------------------------
          );
        }).toList(),
      ),
    );
  }
  // The private method _buildNavItem is REMOVED
}
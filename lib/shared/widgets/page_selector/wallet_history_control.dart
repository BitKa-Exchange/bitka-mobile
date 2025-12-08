import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum SegmentedControlOption { wallet, history }

class WalletHistoryControl extends StatefulWidget {
  final ValueChanged<SegmentedControlOption> onSelectionChanged;

  const WalletHistoryControl({
    super.key,
    required this.onSelectionChanged,
  });

  @override
  State<WalletHistoryControl> createState() => WalletHistoryControlState();
}

class WalletHistoryControlState extends State<WalletHistoryControl> {
  SegmentedControlOption _selectedOption = SegmentedControlOption.history;

  Widget _buildSegment({
    required String label,
    required SegmentedControlOption option,
    required BorderRadius borderRadius,
  }) {
    final bool isSelected = _selectedOption == option;
    
    final Color selectedColor = AppColors.primaryPink;
    final Color unselectedColor = AppColors.backgroundCardDefault; 

    final Color selectedTextColor = AppColors.textOnBrand;
    final Color unselectedTextColor = AppColors.textTertiary;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedOption = option;
        });
        widget.onSelectionChanged(option);
      },
      borderRadius: borderRadius,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? selectedTextColor : unselectedTextColor,
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
            height: 1.40,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFF1E1E1E), 
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSegment(
            label: 'Wallet',
            option: SegmentedControlOption.wallet,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(4),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(4),
            ),
          ),
          const SizedBox(width: 4),

          _buildSegment(
            label: 'History',
            option: SegmentedControlOption.history,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
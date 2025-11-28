import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum SegmentedControlOption { transfer, history }

class TransferHistoryControl extends StatefulWidget {
  final ValueChanged<SegmentedControlOption> onSelectionChanged;

  const TransferHistoryControl({
    super.key,
    required this.onSelectionChanged,
  });

  @override
  State<TransferHistoryControl> createState() => _TransferHistoryControlState();
}

class _TransferHistoryControlState extends State<TransferHistoryControl> {
  SegmentedControlOption _selectedOption = SegmentedControlOption.history; // History is highlighted in the design

  // Helper method to build each button segment
  Widget _buildSegment({
    required String label,
    required SegmentedControlOption option,
    required BorderRadius borderRadius,
  }) {
    final bool isSelected = _selectedOption == option;
    
    // Color definitions based on the provided assets
    final Color selectedColor = AppColors.primaryPink; // F935A1
    // The unselected color (424242) is used here as a general dark grey
    final Color unselectedColor = AppColors.surfaceBorderPrimary; 

    final Color selectedTextColor = AppColors.textOnBrand; // F2F2F2
    final Color unselectedTextColor = AppColors.textTertiary; // B3B3B3

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
        // Assuming 1E1E1E (Background-Brand-Hover) is the outer container background color
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
          // Transfer Button
          _buildSegment(
            label: 'Transfer',
            option: SegmentedControlOption.transfer,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(4),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(4),
            ),
          ),
          const SizedBox(width: 4),

          // History Button
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
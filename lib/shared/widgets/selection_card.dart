import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class SelectionCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const SelectionCard({
    super.key,
    required this.title,
    required this.description,
    required this.items,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      // Background color is the Brand-Primary color (pink)
      decoration: ShapeDecoration(
        color: AppColors.primaryPink, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Dropdown/Title Area ---
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                // Ensure the value matches one of the items
                value: selectedValue, 
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textPrimary),
                style: const TextStyle(
                  color: AppColors.textPrimary, // Text-Neutral-On-Neutral
                  fontSize: 17,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  height: 1.29,
                ),
                dropdownColor: AppColors.primaryPink.withOpacity(0.9), // Match dropdown background
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: onChanged,
                hint: Text(
                  title, // Use title as a hint when nothing is selected
                  style: const TextStyle(
                    color: AppColors.textPrimary, 
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),

          // --- Description ---
          // Use description text if no value is selected, or always show it
          if (selectedValue == null)
            const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              color: AppColors.textPrimary, // Text-Neutral-On-Neutral
              fontSize: 12,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
              height: 1.83,
            ),
          ),
        ],
      ),
    );
  }
}
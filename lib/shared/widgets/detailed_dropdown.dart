import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class DetailedDropDown extends StatelessWidget {

  final String title;
  final String description;
  final double height;
  final double? width;
  const DetailedDropDown({super.key, this.height = 64, this.width, this.title = '', this.description = ''});

  static const primary = AppColors.primaryPink;
  static final primaryGlow = Color.alphaBlend(Color.from(alpha: 0.25, red: 1, green: 1, blue: 1), primary);
  static final textColor = AppColors.textPrimary;

  static const radius = BorderRadius.all(.circular(12.5));

  static final titleStyle = AppTextStyles.bodyLargeSemiBold.copyWith(
    fontFamily: 'Montserrat',
    color: textColor,
  );

  static final descriptionStyle = AppTextStyles.captionSmallBold.copyWith(
    fontFamily: 'Montserrat',
    color: textColor,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: radius,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color: primaryGlow
              ),
              BoxShadow(
                color: primary,
                blurRadius: 17.6,
                spreadRadius: -8
              )
            ]
          ),
          child: Stack(
            fit: .expand,
            children: [
              Positioned(top: 0, right: 0,child: Icon(Icons.keyboard_arrow_down, color: textColor,),),
              Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .center,
                children: [
                  Text(title, style: titleStyle),
                  Text(description, style: descriptionStyle),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:bitka/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const _titleStyle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 32,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w800,
    height: 1.40,
  );

  final String title;
  final bool showBackButton;
  const CustomAppBar({super.key, this.title = '', this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    final bool canPop = ModalRoute.of(context)?.canPop ?? false;
    final double horizontalPadding = canPop ? 0.0 : 15.0;

    return AppBar(
      automaticallyImplyLeading: showBackButton,
      title: Padding(
        padding: EdgeInsets.only(left: horizontalPadding),
        child: Text(title, style: _titleStyle),
      ),
      shadowColor: Colors.transparent,
      animateColor: false,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      centerTitle: false,
    );
  }

  // Required for implementing PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
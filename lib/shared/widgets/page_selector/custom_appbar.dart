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
  final List<Widget>? actions;
  final EdgeInsetsGeometry? actionsPadding;
  final EdgeInsetsGeometry titlePadding;
  const CustomAppBar({
    super.key,
    this.title = '',
    this.showBackButton = true,
    this.actions,
    this.actionsPadding,
    this.titlePadding = const EdgeInsets.fromLTRB(8, 0, 0, 0)
  });

  @override
  Widget build(BuildContext context) {
    final bool canPop = ModalRoute.of(context)?.canPop ?? false;

    return AppBar(
      automaticallyImplyLeading: showBackButton,
      title: Padding(
        padding: (canPop) ? .zero : titlePadding,
        child: Text(title, style: _titleStyle),
      ),
      shadowColor: Colors.transparent,
      animateColor: false,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      centerTitle: false,
      actions: actions,
      actionsPadding: actionsPadding,
    );
  }

  // Required for implementing PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

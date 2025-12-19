import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  static final _titleStyle = AppTextStyles.appBarTitle.copyWith(
    fontFamily: 'Montserrat',
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
      titleSpacing: (canPop) ? 0 : AppBarTheme.of(context).titleSpacing ?? NavigationToolbar.kMiddleSpacing,
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

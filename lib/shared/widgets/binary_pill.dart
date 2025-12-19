import 'package:bitka/core/theme/app_colors.dart';
import 'package:bitka/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class BinaryPill extends StatefulWidget {
  final double? height;
  final double? width;
  final void Function(bool leftSelected)? onPressed;
  final String leftText;
  final String rightText;
  const BinaryPill({
    super.key,
    this.height,
    this.width,
    this.onPressed,
    this.leftText = '',
    this.rightText = '',
  });

  @override
  State<BinaryPill> createState() => _BinaryPillState();
}

class _BinaryPillState extends State<BinaryPill>
    with SingleTickerProviderStateMixin {
  late final AnimationController anim;
  bool left = true;

  void switchRight() {
    setState(() {
      if (!left) return;
      left = false;
      widget.onPressed?.call(false);
      anim.forward();
    });
  }

  void switchLeft() {
    setState(() {
      if (left) return;
      left = true;
      widget.onPressed?.call(true);
      anim.reverse();
    });
  }

  @override
  void initState() {
    anim = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    anim.dispose();
    super.dispose();
  }

  static const textStyle = AppTextStyles.chipText;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const Radius radius = Radius.circular(1000);
        final outerHeight = widget.height ?? constraints.maxHeight;
        final outerWidth = widget.width ?? constraints.maxWidth;
        final innerHeight = outerHeight - 2;
        final innerWidth = outerWidth - 2;

        return SizedBox(
          height: outerHeight,
          width: outerWidth,
          child: Center(
            child: SizedBox(
              height: innerHeight,
              width: innerWidth,
              child: DecoratedBox(
                position: .foreground,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(radius),
                  border: Border.all(
                    color: AppColors.surfaceBorderPrimary,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(radius),
                  child: Stack(
                    children: [
                      Positioned.fill(child: ColoredBox(color: AppColors.surfacePrimary)),
                      AnimatedBuilder(
                        animation: anim,
                        builder: (BuildContext context, _) {
                          final transformed = Curves.easeInOutCirc.transform(
                            anim.value,
                          );
                          return Padding(
                            padding: .only(
                              left: ((innerWidth / 2) + 2) * transformed,
                            ),
                            child: SizedBox(
                              height: innerHeight,
                              width: innerWidth / 2 - 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryPink,
                                  border: .all(
                                    color: AppColors.surfaceBorderPrimary,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              behavior: .opaque,
                              onTap: switchLeft,
                              child: Center(
                                child: Text(widget.leftText, style: textStyle),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              behavior: .opaque,
                              onTap: switchRight,
                              child: Center(
                                child: Text(widget.rightText, style: textStyle),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

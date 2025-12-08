import 'package:bitka/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

class Button extends StatefulWidget {

  final double height;
  final double? width;
  final String? label;
  final GestureTapCallback? onPressed;
  final ButtonType type;

  const Button({
    super.key,
    this.label,
    this.onPressed,
    this.height = 57,
    this.width,
    this.type = ButtonType.primary,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  static const textColor = AppColors.textPrimary;
  static const primary = AppColors.primaryPink;
  static const secondary = AppColors.backgroundBrandHover;
  static const border = AppColors.backgroundCardDefault;

  static const borderWidth = 1.5;
  static const radius = 8.0;
  static const textStyle = TextStyle(
    color: textColor, // This applies the color defined in textStyle
    fontSize: 16,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w800,
    height: 1.40,
  );

  static final primaryGlow = Color.alphaBlend(
    Color.from(alpha: 0.25, red: 1, green: 1, blue: 1),
    primary,
  );
  static final secondaryGlow = Color.alphaBlend(
    Color.from(alpha: 0.04, red: 1, green: 1, blue: 1),
    secondary,
  );

  static final hoverPrimary = Color.alphaBlend(
    Color.from(alpha: 0.5, red: 0, green: 0, blue: 0),
    primary,
  );
  static final hoverSecondary = Color.alphaBlend(
    Color.from(alpha: 0.2, red: 0, green: 0, blue: 0),
    secondary,
  );
  static final hoverPrimaryGlow = Color.alphaBlend(
    Color.from(alpha: 0.25, red: 1, green: 1, blue: 1),
    hoverPrimary,
  );
  static final hoverSecondaryGlow = Color.alphaBlend(
    Color.from(alpha: 0.04, red: 1, green: 1, blue: 1),
    hoverSecondary,
  );

  static final primaryDeco = BoxDecoration(
    borderRadius: BorderRadius.all(.circular(radius)),
    border: Border.fromBorderSide(
      BorderSide(color: border, width: borderWidth),
    ),
    boxShadow: [
      BoxShadow(color: primaryGlow),
      BoxShadow(color: primary, spreadRadius: -8.0, blurRadius: 17.6),
    ],
  );

  static final hoverPrimaryDeco = BoxDecoration(
    borderRadius: BorderRadius.all(.circular(radius)),
    border: Border.fromBorderSide(
      BorderSide(color: border, width: borderWidth),
    ),
    boxShadow: [
      BoxShadow(color: hoverPrimaryGlow),
      BoxShadow(color: hoverPrimary, spreadRadius: 0.0, blurRadius: 9.4),
    ],
  );

  static final secondaryDeco = BoxDecoration(
    borderRadius: BorderRadius.all(.circular(radius)),
    border: Border.fromBorderSide(
      BorderSide(color: border, width: borderWidth),
    ),
    boxShadow: [
      BoxShadow(color: secondaryGlow),
      BoxShadow(color: secondary, spreadRadius: -1.0, blurRadius: 10.6),
    ],
  );

  static final hoverSecondaryDeco = BoxDecoration(
    borderRadius: BorderRadius.all(.circular(radius)),
    border: Border.fromBorderSide(
      BorderSide(color: border, width: borderWidth),
    ),
    boxShadow: [
      BoxShadow(color: hoverSecondaryGlow),
      BoxShadow(color: hoverSecondary, spreadRadius: -1.0, blurRadius: 10.6),
    ],
  );

  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final deco = hover
        ? (switch (widget.type) {
            ButtonType.primary => hoverPrimaryDeco,
            ButtonType.secondary => hoverSecondaryDeco,
          })
        : (switch (widget.type) {
            ButtonType.primary => primaryDeco,
            ButtonType.secondary => secondaryDeco,
          });

    return LayoutBuilder(
      key: widget.key,
      builder: (context, constraints) {
        return SizedBox(
          height: widget.height,
          width: widget.width ?? constraints.maxWidth - 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(.circular(10)),
            child: GestureDetector(
              onTapDown: (_) {
                setState(() {
                  hover = true;
                });
              },
              onTapUp: (_) {
                setState(() {
                  hover = false;
                });
              },
              onTap: widget.onPressed,
              child: AnimatedContainer(
                decoration: deco,
                duration: const Duration(milliseconds: 85),
                curve: Curves.ease,
                child: (widget.label == null)
                    ? null
                    : Center(child: Text(widget.label!, style: textStyle,)),
              ),
            ),
          ),
        );
      },
    );
  }
}
import 'package:bitka/shared/widgets/coin_card.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';


class CoinList extends StatefulWidget {
  final double height;
  final double? width;
  final List<CoinCard>? children;
  const CoinList({super.key, this.width, this.height = 198, this.children});

  @override
  State<CoinList> createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  static const scrollBarColor = Colors.white;
  static const railColor = Color.from(
    alpha: 0.33,
    red: 0.702,
    green: 0.702,
    blue: 0.702,
  );

  static const glow = Color.from(
    alpha: 0.33,
    red: 0.702,
    green: 0.702,
    blue: 0.702,
  );

  static const radius = BorderRadius.all(Radius.circular(15));
  static const scrollBarWidth = 5.0;
  static const right = 12.5;
  final _controller = ScrollController();
  double _top = 0.0;
  double _bottom = 0.5;

  void _updateScrollbar() {
    final pos = _controller.position;

    final max = pos.maxScrollExtent;
    final viewport = pos.viewportDimension;

    // total content height
    final contentExtent = max + viewport;

    // fraction of rail occupied by the thumb
    final thumbFraction = viewport / contentExtent;

    // protect against divide-by-zero
    final scrollFraction = max == 0 ? 0 : _controller.offset / max;

    // the portion of the rail where the thumb can move
    final freeSpace = 1.0 - thumbFraction;

    setState(() {
      // alpha positions for top and bottom (0–1)
      _top = freeSpace * scrollFraction;
      _bottom = freeSpace * (1.0 - scrollFraction);
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.children != null) {
      // Run INITIAL calculation after first layout
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (_controller.hasClients) {
          _updateScrollbar();
        } else {
          // Try again next frame
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_controller.hasClients) {
              _updateScrollbar();
            }
          });
        }
      });

      _controller.addListener(_updateScrollbar);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ... inside the build method
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ClipRRect(
        borderRadius: radius,
        child: LayoutBuilder(
          // 1. LayoutBuilder goes outside
          builder: (context, constraints) {
            final sz = 107.0 * constraints.maxHeight / 198.0;
            final h = (constraints.maxHeight - sz) / 2;
            final htop = _top * sz + h;
            final hbottom = _bottom * sz + h;
            return Stack(
              fit: StackFit.expand,
              children:
                  (widget.children == null
                      ? <Widget>[]
                      : <Widget>[
                          ListView(
                            padding: .zero,
                            controller: _controller,
                            physics: const ClampingScrollPhysics(),
                            children:
                                <Widget>[
                                  Container(
                                    height: 10,
                                    color: CoinCard.background,
                                  ),
                                ] +
                                widget.children!,
                          ),
                        ]) +
                  <Widget>[
                    IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: radius,
                          boxShadow: [
                            BoxShadow(
                              color: glow,
                              inset: true,
                              blurRadius: 7.8,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // 2. Positioned is now a direct child of Stack
                      right: right,
                      top: h,
                      bottom: h,
                      child: Container(
                        width: scrollBarWidth,
                        decoration: BoxDecoration(
                          color: railColor,
                          borderRadius: radius,
                        ),
                      ),
                    ),
                    Positioned(
                      // 2. Positioned is now a direct child of Stack
                      right: right,
                      top: htop,
                      bottom: hbottom,
                      child: Container(
                        width: scrollBarWidth,
                        decoration: BoxDecoration(
                          color: scrollBarColor,
                          borderRadius: radius,
                        ),
                      ),
                    ),
                  ],
            );
          },
        ),
      ),
    );
  }
}
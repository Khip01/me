import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/app/theme/style_util.dart';
import 'package:me/shared/component/components.dart';

class HighlightedWidgetOnHover extends ConsumerStatefulWidget {
  final double? widgetHeight;
  final double widgetWidth;
  final Widget child;
  final Function() onTapAction;
  final BorderRadius? customBorderRadius;

  const HighlightedWidgetOnHover({
    super.key,
    required this.widgetHeight,
    required this.widgetWidth,
    required this.child,
    required this.onTapAction,
    this.customBorderRadius,
  });

  @override
  ConsumerState<HighlightedWidgetOnHover> createState() => _HighlightedWidgetOnHoverState();
}

class _HighlightedWidgetOnHoverState extends ConsumerState<HighlightedWidgetOnHover> {
  bool widgetIshovered = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        InkWell(
          overlayColor: const WidgetStatePropertyAll(Colors.transparent), // remove default hover in InkWell
          onTap: widget.onTapAction,
          onHover: (val) => setState(() => widgetIshovered = val),
          child: SizedBox(
            height: widget.widgetHeight,
            width: widget.widgetWidth,
            child: Container(
              height: widget.widgetHeight,
              width: widget.widgetWidth,
              decoration: BoxDecoration(
                borderRadius: widget.customBorderRadius ?? BorderRadius.circular(getIsMobileSize(context) ? 0 : 8),
                color: widgetIshovered ? StyleUtil.c_170.withValues(alpha: .1) : Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

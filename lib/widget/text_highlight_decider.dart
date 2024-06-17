import 'package:flutter/material.dart';

class TextHighlightDecider extends StatefulWidget {
  final bool isCompactMode;
  Color colorStart;
  Color colorEnd;
  final Duration actionDelay;
  Duration? delayAfterAnimation;
  final Function? additionalOnTapAction;
  final Function(bool value)? additionalOnHoverAction;
  final Function(Color color) builder;

  TextHighlightDecider({
    super.key,
    required this.isCompactMode,
    required this.colorStart,
    required this.colorEnd,
    required this.actionDelay,
    this.delayAfterAnimation,
    this.additionalOnTapAction,
    this.additionalOnHoverAction,
    required this.builder,
  });

  @override
  State<TextHighlightDecider> createState() => _TextHighlightDeciderState();
}

class _TextHighlightDeciderState extends State<TextHighlightDecider> {
  bool isActive = false;
  Color? activeColor;

  @override
  void initState() {
    activeColor = widget.colorStart;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextHighlightDecider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.colorStart != oldWidget.colorStart || widget.colorEnd != oldWidget.colorEnd) {
      setState(() {
        activeColor = activeColor == oldWidget.colorEnd ? widget.colorEnd : widget.colorStart;
      });
    }
  }

  void doSwitchColor() => activeColor = activeColor == widget.colorEnd ? widget.colorStart : widget.colorEnd;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: ColorTween(begin: widget.colorStart, end: activeColor),
      duration: const Duration(milliseconds: 100),
      builder: (context, value, child){
        return InkWell(
          onHover: (isHover) {
            if (!widget.isCompactMode) {
              setState(() {
                doSwitchColor();
              });
              if(widget.additionalOnHoverAction != null){
                widget.additionalOnHoverAction!(isHover);
              }
            }
          },
          onTap: () async {
            // if mobile || tablet web mode
            if (widget.isCompactMode && !isActive) {
              setState((){
                doSwitchColor();
                isActive = true;
              });
              Future.delayed(widget.actionDelay,
                      () async {
                    if (widget.additionalOnTapAction != null) {
                      await widget.additionalOnTapAction!();
                    }
                  }
              ).then((_){
                Future.delayed(widget.delayAfterAnimation ?? const Duration(milliseconds: 5000)).then(
                      (_) {
                    if (mounted){
                      setState(() {
                        doSwitchColor();
                        isActive = false;
                      });
                    }
                  },
                );
              });
            }
            // if bigger than mobile || tablet web mode
            if (!widget.isCompactMode && widget.additionalOnTapAction != null) {
              await widget.additionalOnTapAction!();
            }
          },
          child: widget.builder(value!),
        );
      },
    );
  }
}

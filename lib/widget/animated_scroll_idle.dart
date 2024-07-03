import 'package:flutter/material.dart';

class AnimatedScrollIdle extends StatefulWidget {
  final Duration animDuration;
  final IconData mainIcon;
  final Color mainColor;
  final double? containerHeight; // default 70
  final double? iconHeight; // default 30

  const AnimatedScrollIdle({
    super.key,
    required this.animDuration,
    required this.mainIcon,
    required this.mainColor,
    this.containerHeight,
    this.iconHeight,
  });

  @override
  State<AnimatedScrollIdle> createState() => _AnimatedScrollIdleState();
}

class _AnimatedScrollIdleState extends State<AnimatedScrollIdle> with TickerProviderStateMixin{

  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animDuration,
    )..repeat(reverse: true);

    _animation = ColorTween(
      begin: widget.mainColor.withOpacity(0.1),
      end: widget.mainColor.withOpacity(0.5),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedScrollIdle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.mainColor != oldWidget.mainColor) {
      setState(() {
        _animation = ColorTween(
          begin: widget.mainColor.withOpacity(.1),
          end: widget.mainColor.withOpacity(.5),
        ).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: Align(
        alignment: Alignment.topCenter,
        child: AnimatedScrollIconIdle(
          animDuration: widget.animDuration,
          mainIcon: widget.mainIcon,
          mainColor: widget.mainColor,
          iconHeight: widget.iconHeight,
        ),
      ),
      builder: (context, child) {
        return Container(
            height: widget.containerHeight ?? 70,
            width: double.maxFinite,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0.4,
                  1.0,
                ],
                colors: [
                  Colors.transparent,
                  _animation.value,
                ],
              ),
            ),
            child: child
        );
      },
    );
  }
}


class AnimatedScrollIconIdle extends StatefulWidget {
  final Duration animDuration;
  final IconData mainIcon;
  final Color mainColor;
  final double? iconHeight; // default 30

  const AnimatedScrollIconIdle({
    super.key,
    required this.animDuration,
    required this.mainIcon,
    required this.mainColor,
    this.iconHeight,
  });

  @override
  State<AnimatedScrollIconIdle> createState() => _AnimatedScrollIconIdleState();
}

class _AnimatedScrollIconIdleState extends State<AnimatedScrollIconIdle> with TickerProviderStateMixin{

  late AnimationController _controller;
  late Animation _animation;
  late Animation _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animDuration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween(begin: 0.0, end: 1.0,).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic)
    );

    _colorAnimation = ColorTween(begin: Colors.transparent, end: widget.mainColor.withOpacity(.5)).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic)
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedScrollIconIdle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.mainColor != oldWidget.mainColor) {
      setState(() {
        _colorAnimation = ColorTween(
          begin: Colors.transparent,
          end: widget.mainColor.withOpacity(.5),
        ).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return Icon(
            widget.mainIcon,
            color: _colorAnimation.value,
          );
        },
      ),
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(0.0, _animation.value * (widget.iconHeight ?? 30), 0.0),
          child: child,
        );
      },
    );
  }
}
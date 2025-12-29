import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/component/components.dart';
import 'package:me/provider/theme_provider.dart';
import 'package:me/utility/style_util.dart';

/// A sticky back button that stays fixed at the top of the screen.
///
/// Features:
/// - Respects safe areas (notches, status bar)
/// - Adapts to dark/light mode
/// - Optional fade-in animation after cover animation completes
/// - Desktop hover effects and mobile touch feedback
/// - Accessibility support via Semantics
class StickyBackButton extends ConsumerStatefulWidget {
  /// Callback when back button is pressed
  final VoidCallback onPressed;

  /// Optional notifier to animate button appearance after cover animation
  final ValueNotifier<bool>? showAfterAnimation;

  /// Custom padding from edges (defaults to content padding)
  final EdgeInsetsGeometry? customPadding;

  const StickyBackButton({
    super.key,
    required this.onPressed,
    this.showAfterAnimation,
    this.customPadding,
  });

  @override
  ConsumerState<StickyBackButton> createState() => _StickyBackButtonState();
}

class _StickyBackButtonState extends ConsumerState<StickyBackButton> {
  bool _isHovered = false;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    // If animation notifier is provided, start hidden and wait for signal
    if (widget.showAfterAnimation != null) {
      _isVisible = widget.showAfterAnimation!.value;
      widget.showAfterAnimation!.addListener(_onAnimationComplete);
    }
  }

  @override
  void dispose() {
    widget.showAfterAnimation?.removeListener(_onAnimationComplete);
    super.dispose();
  }

  void _onAnimationComplete() {
    if (mounted && widget.showAfterAnimation!.value) {
      setState(() {
        _isVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = ref.watch(isDarkModeProvider).value;
    final bool isCompactDevice =
        getIsMobileSize(context) || getIsTabletSize(context);
    final EdgeInsetsGeometry padding =
        widget.customPadding ?? contentCardPadding(context);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: IgnorePointer(
            ignoring: !_isVisible,
            child: Padding(
              padding: padding,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Semantics(
                  button: true,
                  label: 'Go back',
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: widget.onPressed,
                      onHover: (value) {
                        if (!isCompactDevice) {
                          setState(() => _isHovered = value);
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      splashColor: isDarkMode
                          ? StyleUtil.c_255.withValues(alpha: 0.1)
                          : StyleUtil.c_33.withValues(alpha: 0.1),
                      highlightColor: Colors.transparent,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: _getBackgroundColor(isDarkMode),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: 28,
                            color: _getIconColor(isDarkMode),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(bool isDarkMode) {
    if (_isHovered) {
      return isDarkMode
          ? StyleUtil.c_255.withValues(alpha: 0.15)
          : StyleUtil.c_33.withValues(alpha: 0.1);
    }
    return isDarkMode
        ? StyleUtil.c_33.withValues(alpha: 0.6)
        : StyleUtil.c_255.withValues(alpha: 0.6);
  }

  Color _getIconColor(bool isDarkMode) {
    if (_isHovered) {
      return isDarkMode ? StyleUtil.c_255 : StyleUtil.c_24;
    }
    return isDarkMode ? StyleUtil.c_170 : StyleUtil.c_61;
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:me/app/theme/style_util.dart';

/// A reusable scroll progress indicator widget that supports:
/// - Responsive layout (horizontal for mobile, vertical for desktop/tablet)
/// - Drag-based scroll interaction with throttling
/// - Safe handling when ScrollController is null or has no clients
///
/// The widget does NOT create its own ScrollController or watch providers.
/// All dependencies must be provided by the parent page.
class ScrollProgressIndicator extends StatefulWidget {
  /// The scroll controller to track and control scroll position.
  /// Can be null for pages without scrollable content.
  final ScrollController? scrollController;

  /// A ValueListenable that provides the current scroll progress (0.0 to 1.0).
  /// If null, progress defaults to 0.01 and drag is disabled.
  final ValueListenable<double>? progressNotifier;

  /// Whether the current layout is mobile (horizontal bar at bottom).
  final bool isMobile;

  /// Whether dark mode is active (affects colors).
  final bool isDarkMode;

  const ScrollProgressIndicator({
    super.key,
    this.scrollController,
    this.progressNotifier,
    required this.isMobile,
    required this.isDarkMode,
  });

  @override
  State<ScrollProgressIndicator> createState() =>
      _ScrollProgressIndicatorState();
}

class _ScrollProgressIndicatorState extends State<ScrollProgressIndicator> {
  // Throttling for drag interaction (stores last applied scroll offset)
  double _lastDragScrollOffset = -1.0;

  /// Whether drag interaction is enabled.
  /// Disabled when scrollController is null or progressNotifier is null.
  bool get _isDragEnabled =>
      widget.scrollController != null && widget.progressNotifier != null;

  @override
  Widget build(BuildContext context) {
    if (widget.isMobile) {
      return _buildHorizontalIndicator(context);
    }
    return _buildVerticalIndicator(context);
  }

  // ------ Horizontal Indicator (Mobile) ------
  Widget _buildHorizontalIndicator(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: _isDragEnabled
            ? (DragStartDetails details) {
                _lastDragScrollOffset = -1.0;
                _handleHorizontalDrag(details.localPosition.dx);
              }
            : null,
        onPanUpdate: _isDragEnabled
            ? (DragUpdateDetails details) {
                _handleHorizontalDrag(details.localPosition.dx);
              }
            : null,
        onPanEnd: _isDragEnabled
            ? (DragEndDetails details) {
                _lastDragScrollOffset = -1.0;
              }
            : null,
        child: _buildHorizontalProgressBar(),
      ),
    );
  }

  Widget _buildHorizontalProgressBar() {
    // Use progressNotifier if available, otherwise use a static ValueNotifier
    final ValueListenable<double> notifier =
        widget.progressNotifier ?? ValueNotifier(0.01);

    return ValueListenableBuilder<double>(
      valueListenable: notifier,
      builder: (context, progress, child) {
        return Container(
          height: 12,
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.isDarkMode
                ? StyleUtil.c_61.withValues(alpha: 0.5)
                : StyleUtil.c_238.withValues(alpha: 0.5),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: widget.isDarkMode
                        ? [StyleUtil.c_170, StyleUtil.c_255]
                        : [StyleUtil.c_61, StyleUtil.c_170],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ------ Vertical Indicator (Desktop/Tablet) ------
  Widget _buildVerticalIndicator(BuildContext context) {
    final double barHeight = MediaQuery.sizeOf(context).height * 0.28;

    return Positioned(
      right: 12,
      top: 0,
      bottom: 0,
      child: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanStart: _isDragEnabled
              ? (DragStartDetails details) {
                  _lastDragScrollOffset = -1.0;
                  _handleVerticalDrag(details.localPosition.dy, barHeight);
                }
              : null,
          onPanUpdate: _isDragEnabled
              ? (DragUpdateDetails details) {
                  _handleVerticalDrag(details.localPosition.dy, barHeight);
                }
              : null,
          onPanEnd: _isDragEnabled
              ? (DragEndDetails details) {
                  _lastDragScrollOffset = -1.0;
                }
              : null,
          child: _buildVerticalProgressBar(barHeight),
        ),
      ),
    );
  }

  Widget _buildVerticalProgressBar(double barHeight) {
    // Use progressNotifier if available, otherwise use a static ValueNotifier
    final ValueListenable<double> notifier =
        widget.progressNotifier ?? ValueNotifier(0.01);

    return ValueListenableBuilder<double>(
      valueListenable: notifier,
      builder: (context, progress, child) {
        return Container(
          width: 8,
          height: barHeight,
          decoration: BoxDecoration(
            color: widget.isDarkMode
                ? StyleUtil.c_61.withValues(alpha: 0.5)
                : StyleUtil.c_238.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              heightFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: widget.isDarkMode
                        ? [StyleUtil.c_170, StyleUtil.c_255]
                        : [StyleUtil.c_61, StyleUtil.c_170],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ------ Drag Handlers ------

  /// Handles horizontal drag interaction for Mobile progress indicator.
  /// Includes throttling to avoid excessive jumpTo calls.
  void _handleHorizontalDrag(double localX) {
    final scrollController = widget.scrollController;
    if (scrollController == null || !scrollController.hasClients) return;

    final double barWidth = MediaQuery.sizeOf(context).width;
    final double percentage = (localX / barWidth).clamp(0.0, 1.0);
    final double targetOffset =
        percentage * scrollController.position.maxScrollExtent;

    // Throttle: only update if offset changed by more than 2 pixels
    if ((_lastDragScrollOffset - targetOffset).abs() > 2.0) {
      _lastDragScrollOffset = targetOffset;
      scrollController.jumpTo(targetOffset);
    }
  }

  /// Handles vertical drag interaction for Desktop/Tablet progress indicator.
  /// Includes throttling to avoid excessive jumpTo calls.
  void _handleVerticalDrag(double localY, double barHeight) {
    final scrollController = widget.scrollController;
    if (scrollController == null || !scrollController.hasClients) return;

    final double percentage = (localY / barHeight).clamp(0.0, 1.0);
    final double targetOffset =
        percentage * scrollController.position.maxScrollExtent;

    // Throttle: only update if offset changed by more than 2 pixels
    if ((_lastDragScrollOffset - targetOffset).abs() > 2.0) {
      _lastDragScrollOffset = targetOffset;
      scrollController.jumpTo(targetOffset);
    }
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/app/provider/chat_refresh_provider.dart';
import 'package:me/app/provider/page_transition_provider.dart';
import 'package:me/app/provider/sidebar_provider.dart';
import 'package:me/app/provider/theme_provider.dart';
import 'package:me/app/theme/style_util.dart';
import 'package:me/shared/component/components.dart';
import 'package:me/shared/utils/utils.dart';
import 'package:me/shared/widget/open_url_with_snackbar.dart';
import 'package:me/shared/widget/sidebar_chat_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResizableSidebarLayout extends ConsumerStatefulWidget {
  final Widget mainChild;
  final Widget sideChild;

  const ResizableSidebarLayout({
    super.key,
    required this.mainChild,
    required this.sideChild,
  });

  @override
  ConsumerState<ResizableSidebarLayout> createState() =>
      _ResizableSidebarLayoutState();
}

class _ResizableSidebarLayoutState
    extends ConsumerState<ResizableSidebarLayout> {
  double _sideChildWidth = 400.0; // default sidebar width (on wide screen only)
  final double _minWidth = 300.0;
  final double _maxWidth = 450.0;

  @override
  Widget build(BuildContext context) {
    final SidebarProvider sidebarState = ref.watch(sidebarProvider);
    final isTransitioning = ref.watch(pageTransitionProvider);

    final bool isCompactScreen = getIsDesktopSmAndBelowSize(context);
    final bool isWideScreen = !isCompactScreen;

    return LayoutBuilder(
      builder: (context, constraints) {
        double sidebarWidthOnWideScreen =
            sidebarState.isOpened && isWideScreen ? _sideChildWidth : 0;
        double dividerWidth = sidebarState.isOpened && isWideScreen ? 16 : 0;
        double availableWidthForMainChild =
            constraints.maxWidth - (sidebarWidthOnWideScreen + dividerWidth);

        return Scaffold(
          body: Stack(
            alignment: AlignmentGeometry.centerRight,
            children: [
              Row(
                children: [
                  Expanded(
                    child: RecalculateMainChildSize(
                      availableWidth: availableWidthForMainChild,
                      layoutConstraints: constraints,
                      mainChild: Stack(
                        children: [
                          widget.mainChild,
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOutCirc,
                            bottom: constraints.maxHeight /
                                (floatingSidebarThumbFromBottom(
                                      availableWidthForMainChild,
                                    ) ??
                                    constraints.maxHeight),
                            right: isTransitioning
                                ? -200
                                : floatingSidebarThumbFromRight(
                                    availableWidthForMainChild,
                                  ),
                            child: SidebarChatWidget.sidebarThumb(
                              isFloatingMode: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (sidebarState.isOpened && isWideScreen)
                    draggableDivider(dividerWidth),
                  if (isWideScreen)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: sidebarState.isOpened ? _sideChildWidth : 0,
                      curve: Curves.easeOutCirc,
                      child: Column(
                        children: [
                          Expanded(child: widget.sideChild),
                          sidebarWindowControl(),
                        ],
                      ),
                    ),
                ],
              ),
              if (isCompactScreen)
                AnimatedPositioned(
                  top: 0,
                  right: sidebarState.isOpened ? 0 : -constraints.maxWidth,
                  bottom: 0,
                  duration: Duration(milliseconds: 300),
                  width: constraints.maxWidth,
                  curve: Curves.easeOutCirc,
                  child: Column(
                    children: [
                      Expanded(child: widget.sideChild),
                      sidebarWindowControl(),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget draggableDivider(double width) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return GestureDetector(
      // onHorizontalDragUpdate: (details) {
      //   setState(() {
      //     _sideChildWidth =
      //         (_sideChildWidth - details.delta.dx).clamp(_minWidth, _maxWidth);
      //     // // calculate width
      //     // _rightWidth -= details.delta.dx;
      //     //
      //     // // limit width with clamp
      //     // _rightWidth = _rightWidth.clamp(_minWidth, _maxWidth);
      //   });
      // },
      child: Container(
        width: width,
        color: (isDarkMode) ? StyleUtil.c_61 : StyleUtil.c_238,
        child: const Center(
          // child: Icon(
          //   Icons.drag_indicator,
          //   size: 16,
          //   color: StyleUtil.c_170,
          // ),
        ),
      ),
    );
  }

  Widget sidebarWindowControl() {
    final bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Container(
      height: 60,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: (isDarkMode) ? StyleUtil.c_33 : StyleUtil.c_255,
      ),
      child: Row(
        children: [
          Opacity(
            opacity: getIsDesktopSmAndBelowSize(context) ? 1 : 0,
            child: SidebarChatWidget.sidebarThumb(isFloatingMode: false),
          ),
          Expanded(
            child: RichText(
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              text: TextSpan(
                text: "Powered by ",
                style: StyleUtil.text_small_Regular.copyWith(
                  color: StyleUtil.c_170,
                ),
                children: [
                  TextSpan(
                    text: "Talkest.",
                    style: StyleUtil.text_small_Bold.copyWith(
                      color: (isDarkMode) ? StyleUtil.c_238 : StyleUtil.c_61,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        OpenUrlWithSnackbar(context).openUrl(
                          url: LinkUtil.talkestAppLink,
                          snackbarMessage: "Thank You for visiting Talkest!",
                          isDarkMode: isDarkMode,
                        );
                      },
                  ),
                  TextSpan(text: "  🤍"),
                ],
              ),
            ),
          ),
          SidebarChatWidget.sidebarThumb(
            isInvisible: false,
            isFloatingMode: false,
            icon: Icons.refresh_rounded,
            label: "Refresh",
            onPressed: () {
              ref
                  .read(chatRefreshProvider.notifier)
                  .update((state) => state + 1);
            },
          ),
        ],
      ),
    );
  }
}

class RecalculateMainChildSize extends StatelessWidget {
  final Widget mainChild;
  final double availableWidth;
  final BoxConstraints layoutConstraints;

  const RecalculateMainChildSize({
    super.key,
    required this.mainChild,
    required this.availableWidth,
    required this.layoutConstraints,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      // override MediaQueryData and re-create ResposiveBreakpoints
      // to see 'availableWidth' as screen width.
      data: MediaQuery.of(context).copyWith(
        size: Size(availableWidth, layoutConstraints.maxHeight),
      ),
      child: ResponsiveBreakpoints(
        // Re-Wrap mainChild with breakpoints to re-assign new breakpoint after overriding MediaQuery
        breakpoints: const [
          Breakpoint(start: 0, end: 480, name: MOBILE),
          Breakpoint(start: 481, end: 600, name: TABLET),
          Breakpoint(start: 601, end: 800, name: 'DESKTOP-SM'),
          Breakpoint(start: 801, end: 1100, name: 'DESKTOP-MD'),
          Breakpoint(start: 1101, end: 1920, name: 'DESKTOP-LG'),
          Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: mainChild,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/app/provider/page_transition_provider.dart';
import 'package:me/app/provider/sidebar_provider.dart';
import 'package:me/app/provider/theme_provider.dart';
import 'package:me/app/theme/style_util.dart';
import 'package:me/shared/component/components.dart';

class SidebarChatWidget {
  static Widget sidebarChat() => const _SidebarChat();

  static Widget sidebarThumb({
    bool? isInvisible,
    required bool isFloatingMode,
  }) =>
      _SidebarThumb(isInvisible ?? false, isFloatingMode);
}

/// SidebarChat
class _SidebarChat extends StatelessWidget {
  const _SidebarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: double.maxFinite,
      width: double.maxFinite,
      color: Colors.red[900],
      child: Text("Coming Soon!"),
    );
  }
}

/// SidebarThumb
class _SidebarThumb extends StatelessWidget {
  final bool isInvisible;
  final bool isFloatingMode;

  const _SidebarThumb(this.isInvisible, this.isFloatingMode, {super.key});

  @override
  Widget build(BuildContext context) {
    return isFloatingMode
        ? __SidebarThumbFloatingMode()
        : _SidebarThumbWindowController(isInvisible);
  }
}

class _SidebarThumbWindowController extends ConsumerWidget {
  final bool isInvisible;

  const _SidebarThumbWindowController(this.isInvisible, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool showText = MediaQuery.sizeOf(context).width > 365;
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return IgnorePointer(
      ignoring: isInvisible,
      child: Opacity(
        opacity: isInvisible ? 0 : 1,
        child: SizedBox(
          height: double.maxFinite,
          child: FilledButton(
            style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 12),
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                )),
            onPressed: () => ref.read(sidebarProvider).toggle(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
                ),
                if (showText) ...[
                  const SizedBox(width: 8),
                  Text(
                    "Close",
                    style: StyleUtil.text_small_Bold.copyWith(
                      color: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class _SidebarThumbFloatingMode extends ConsumerWidget {
//   const _SidebarThumbFloatingMode({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isDarkMode = ref.watch(isDarkModeProvider).value;
//
//     return SizedBox(
//       height: 60,
//       child: FilledButton(
//         style: FilledButton.styleFrom(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//             backgroundColor: StyleUtil.c_238,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(8),
//                 bottomRight: Radius.circular(0),
//                 topLeft: Radius.circular(8),
//                 bottomLeft: Radius.circular(8),
//               ),
//             )),
//         onPressed: () => ref.read(sidebarProvider).toggle(),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.message_rounded,
//               size: 24,
//               color: (isDarkMode) ? StyleUtil.c_33 : StyleUtil.c_255,
//             ),
//             if (!getIsMobileSize(context)) const SizedBox(width: 8),
//             if (!getIsMobileSize(context))
//               Text(
//                 "Let's have a talk!",
//                 style: StyleUtil.text_small_Bold.copyWith(
//                   color: (isDarkMode) ? StyleUtil.c_33 : StyleUtil.c_255,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class __SidebarThumbFloatingMode extends ConsumerStatefulWidget {
  const __SidebarThumbFloatingMode({super.key});

  @override
  ConsumerState<__SidebarThumbFloatingMode> createState() =>
      _SidebarThumbFloatingModeState();
}

class _SidebarThumbFloatingModeState
    extends ConsumerState<__SidebarThumbFloatingMode> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider).value;
    final bool isSidebarOpened = ref.watch(sidebarProvider).isOpened;
    final isTransitioning = ref.watch(pageTransitionProvider);

    final bool isCompactMode =
        getIsTabletSize(context) || getIsMobileSize(context);

    String labelText = isSidebarOpened ? "Close Chat" : "Let's have a talk!";
    IconData displayIcon;

    if (isCompactMode && !isExpanded) {
      displayIcon = Icons.chevron_left_rounded;
    } else {
      displayIcon =
          isSidebarOpened ? Icons.close_rounded : Icons.message_rounded;
    }

    double targetWidth;
    if (!isCompactMode) {
      targetWidth = 180;
    } else {
      targetWidth = (isExpanded || isSidebarOpened) ? 180 : 50;
    }

    return IgnorePointer(
      ignoring: isTransitioning,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isTransitioning ? 0.0 : 1.0,
        child: TapRegion(
          onTapOutside: (event) {
            if (isExpanded) setState(() => isExpanded = false);
          },
          child: Material(
            color: Colors.transparent,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              height: 60,
              width: targetWidth,
              decoration: BoxDecoration(
                color: isSidebarOpened
                    ? (isDarkMode ? StyleUtil.c_255 : StyleUtil.c_33)
                    : (isDarkMode ? StyleUtil.c_238 : StyleUtil.c_61),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                boxShadow: [
                  if (isSidebarOpened)
                    BoxShadow(
                        color: Colors.black26, blurRadius: 10, spreadRadius: 1)
                ],
              ),
              child: InkWell(
                onTap: () {
                  if (isCompactMode) {
                    if (!isExpanded && !isSidebarOpened) {
                      setState(() => isExpanded = true);
                    } else {
                      ref.read(sidebarProvider).toggle();
                      setState(() => isExpanded = false);
                    }
                  } else {
                    ref.read(sidebarProvider).toggle();
                  }
                },
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    width: targetWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          (isExpanded || !isCompactMode || isSidebarOpened)
                              ? 16
                              : 12,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          displayIcon,
                          size: 24,
                          color:
                              (isDarkMode) ? StyleUtil.c_33 : StyleUtil.c_255,
                        ),
                        if (!isCompactMode ||
                            isExpanded ||
                            isSidebarOpened) ...[
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              labelText,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: StyleUtil.text_small_Bold.copyWith(
                                color: (isDarkMode)
                                    ? StyleUtil.c_33
                                    : StyleUtil.c_255,
                              ),
                            ),
                          ),
                        ],
                      ],
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
}

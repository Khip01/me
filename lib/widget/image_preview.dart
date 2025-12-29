import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/widget/text_highlight_decider.dart';

import '../utility/style_util.dart';
import '../component/spacing.dart';
import '../component/visible.dart';
import '../provider/theme_provider.dart';

class ImagePreview extends ConsumerStatefulWidget {
  final List<String> images;
  final List<String> imagesHash;
  final int? isPreviewMode;
  final Function(int? activeIndex) callbackPreviewMode;

  const ImagePreview({
    super.key,
    required this.images,
    required this.imagesHash,
    required this.isPreviewMode,
    required this.callbackPreviewMode,
  });

  @override
  ConsumerState<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends ConsumerState<ImagePreview> {
  bool _isCloseHovered = false;
  bool _isPrevHovered = false;
  bool _isNextHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;
    final bool isCompactDevice = getIsMobileSize(context) || getIsTabletSize(context);
    // int? selectedIndexImagePreview = ref.watch(isPreviewMode);

    return Visibility(
      // visible: ref.watch(isPreviewMode) != null,
      visible: widget.isPreviewMode != null,
      child: GestureDetector(
        onTap: () => setState(() {
          widget.callbackPreviewMode(null);
        }),
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          color: StyleUtil.c_61.withValues(alpha: .7),
          child: Stack(
            children: [
              InteractiveViewer(
                minScale: 0.5, // Minimum scale (zoom out)
                maxScale: 2.0, // Maximum scale (zoom in)
                child: Center(
                  child: GestureDetector(
                    onTap: () {}, // Prevent the outer GestureDetector from closing the preview,
                    // child: ref.watch(isPreviewMode) != null ?
                    child: widget.isPreviewMode != null ?
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: BlurHashImage(
                            widget.imagesHash[widget.isPreviewMode!],
                          ),
                        ),
                      ),
                      child: Image.asset(
                        widget.images[widget.isPreviewMode!],
                      ),
                    ) :
                    const SizedBox(),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: contentCardPadding(context)
                        .copyWith(top: 50 + (getIsDesktopLgAndBelowSize(context) ? 0 : 56)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      // child: TextHighlightDecider(
                      //   isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                      //   colorStart: (isDarkMode) ? StyleUtil.c_170 : StyleUtil.c_61,
                      //   colorEnd: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_24,
                      //   actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 500 : 100),
                      //   additionalOnTapAction: () => setState(() {
                      //     widget.callbackPreviewMode(null);
                      //   }),
                      //   builder: (color) {
                      //     return Icon(
                      //       Icons.close,
                      //       size: 33,
                      //       color: color,
                      //     );
                      //   },
                      // ),
                      child: Semantics(
                        button: true,
                        label: 'Close Image Preview',
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => setState(() {
                              widget.callbackPreviewMode(null);
                            }),
                            onHover: (value) {
                              if (!isCompactDevice) {
                                setState(() => _isCloseHovered = value);
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
                                color: _getCloseButtonBackgroundColor(isDarkMode, _isCloseHovered),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  size: 28,
                                  color: _getIconColor(isDarkMode, _isCloseHovered),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: contentCardPadding(context),
                    child: GestureDetector(
                      onTap: () {}, // Prevent the outer GestureDetector from closing the preview,
                      child: Visibility(
                        visible: widget.images.length > 1 ? true : false,
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: ((isDarkMode)
                                    ? StyleUtil.c_33
                                    : StyleUtil.c_255).withValues(alpha: .7),
                                boxShadow: [
                                  BoxShadow(
                                    color: (isDarkMode)
                                        ? const Color.fromARGB(255, 61, 61, 61)
                                        : const Color.fromARGB(255, 203, 203, 203),
                                    blurRadius: 80.0,
                                  ),
                                ],
                              ),
                              // width: 100,
                              height: 50,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IgnorePointer(
                                    ignoring: widget.isPreviewMode == 0 ? true : false,
                                    child: AnimatedOpacity(
                                      duration: const Duration(milliseconds: 100),
                                      opacity: widget.isPreviewMode == 0 ? 0 : 1,
                                      curve: Curves.easeInOut,
                                      child: Semantics(
                                        button: true,
                                        label: 'Prev Image Preview',
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              if(widget.isPreviewMode != null && widget.isPreviewMode! > 0){
                                                int currentIndex = widget.isPreviewMode!;
                                                setState(() {
                                                  widget.callbackPreviewMode(currentIndex - 1);
                                                });
                                              }
                                            },
                                            onHover: (value) {
                                              if (!isCompactDevice) {
                                                setState(() => _isPrevHovered = value);
                                              }
                                            },
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              bottomLeft: Radius.circular(12),
                                              bottomRight: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                            ),
                                            splashColor: isDarkMode
                                                ? StyleUtil.c_255.withValues(alpha: 0.1)
                                                : StyleUtil.c_33.withValues(alpha: 0.1),
                                            highlightColor: Colors.transparent,
                                            child: Container(
                                              width: 48,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  bottomLeft: Radius.circular(12),
                                                  bottomRight: Radius.circular(0),
                                                  topRight: Radius.circular(0),
                                                ),
                                                color: _getNavigationButtonBackgroundColor(isDarkMode, _isPrevHovered),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.keyboard_arrow_left_rounded,
                                                  size: 28,
                                                  color: _getIconColor(isDarkMode, _isPrevHovered),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IgnorePointer(
                                    ignoring:widget.isPreviewMode == widget.images.length-1 ? true : false,
                                    child: AnimatedOpacity(
                                      duration: const Duration(milliseconds: 100),
                                      opacity: widget.isPreviewMode == widget.images.length-1 ? 0 : 1,
                                      curve: Curves.easeInOut,
                                      child: Semantics(
                                        button: true,
                                        label: 'Next Image Preview',
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              if(widget.isPreviewMode != null && widget.isPreviewMode! < widget.images.length-1){
                                                int currentIndex = widget.isPreviewMode!;
                                                widget.callbackPreviewMode(currentIndex + 1);
                                              }
                                            },
                                            onHover: (value) {
                                              if (!isCompactDevice) {
                                                setState(() => _isNextHovered = value);
                                              }
                                            },
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                            ),
                                            splashColor: isDarkMode
                                                ? StyleUtil.c_255.withValues(alpha: 0.1)
                                                : StyleUtil.c_33.withValues(alpha: 0.1),
                                            highlightColor: Colors.transparent,
                                            child: Container(
                                              width: 48,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(0),
                                                  bottomLeft: Radius.circular(0),
                                                  bottomRight: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                                color: _getNavigationButtonBackgroundColor(isDarkMode, _isNextHovered),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.keyboard_arrow_right_rounded,
                                                  size: 28,
                                                  color: _getIconColor(isDarkMode, _isNextHovered),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCloseButtonBackgroundColor(bool isDarkMode, bool isHovered) {
    if (isHovered) {
      return isDarkMode
          ? StyleUtil.c_24.withValues(alpha: 0.8)
          : StyleUtil.c_255.withValues(alpha: 0.8);
    }
    return isDarkMode
        ? StyleUtil.c_33.withValues(alpha: 0.6)
        : StyleUtil.c_255.withValues(alpha: 0.6);
  }

  Color _getNavigationButtonBackgroundColor(bool isDarkMode, bool isHovered) {
    if (isHovered) {
      return isDarkMode
          ? StyleUtil.c_24.withValues(alpha: 0.4)
          : StyleUtil.c_255.withValues(alpha: 0.4);
    }
    return isDarkMode
        ? StyleUtil.c_33.withValues(alpha: 0)
        : StyleUtil.c_255.withValues(alpha: 0);
  }

  Color _getIconColor(bool isDarkMode, bool isHovered) {
    if (isHovered) {
      return isDarkMode ? StyleUtil.c_255 : StyleUtil.c_24;
    }
    return isDarkMode ? StyleUtil.c_170 : StyleUtil.c_61;
  }
}
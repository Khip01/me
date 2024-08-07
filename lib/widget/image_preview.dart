import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/widget/text_highlight_decider.dart';

import '../Utility/style_util.dart';
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
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;
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
          color: StyleUtil.c_61.withOpacity(.7),
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
                    padding: contentCardPadding(context),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 100,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextHighlightDecider(
                          isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                          colorStart: (isDarkMode) ? StyleUtil.c_170 : StyleUtil.c_61,
                          colorEnd: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_24,
                          actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 500 : 100),
                          additionalOnTapAction: () => setState(() {
                            widget.callbackPreviewMode(null);
                          }),
                          builder: (color) {
                            return Icon(
                              Icons.close,
                              size: 33,
                              color: color,
                            );
                          },
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
                                borderRadius: BorderRadius.circular(getIsMobileSize(context) ? 0 : 30),
                                color: ((isDarkMode)
                                    ? StyleUtil.c_33
                                    : StyleUtil.c_255).withOpacity(.7),
                                boxShadow: [
                                  BoxShadow(
                                    color: (isDarkMode)
                                        ? const Color.fromARGB(255, 61, 61, 61)
                                        : const Color.fromARGB(255, 203, 203, 203),
                                    blurRadius: 80.0,
                                  ),
                                ],
                              ),
                              width: 100,
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IgnorePointer(
                                    ignoring: widget.isPreviewMode == 0 ? true : false,
                                    child: AnimatedOpacity(
                                      duration: const Duration(milliseconds: 100),
                                      opacity: widget.isPreviewMode == 0 ? 0 : 1,
                                      curve: Curves.easeInOut,
                                      child: TextHighlightDecider(
                                        isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                                        colorStart: (isDarkMode) ? StyleUtil.c_170 : StyleUtil.c_61,
                                        colorEnd: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_24,
                                        actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 0 : 100),
                                        delayAfterAnimation: const Duration(milliseconds: 0),
                                        additionalOnTapAction: () {
                                          if(widget.isPreviewMode != null && widget.isPreviewMode! > 0){
                                            int currentIndex = widget.isPreviewMode!;
                                            setState(() {
                                              widget.callbackPreviewMode(currentIndex - 1);
                                            });
                                          }
                                        },
                                        builder: (color) {
                                          return Icon(
                                            Icons.keyboard_arrow_left_rounded,
                                            size: 33,
                                            color: color.withOpacity(.7),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  IgnorePointer(
                                    ignoring:widget.isPreviewMode == widget.images.length-1 ? true : false,
                                    child: AnimatedOpacity(
                                      duration: const Duration(milliseconds: 100),
                                      opacity: widget.isPreviewMode == widget.images.length-1 ? 0 : 1,
                                      curve: Curves.easeInOut,
                                      child: TextHighlightDecider(
                                        isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                                        colorStart: (isDarkMode) ? StyleUtil.c_170 : StyleUtil.c_61,
                                        colorEnd: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_24,
                                        actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 0 : 100),
                                        delayAfterAnimation: const Duration(milliseconds: 0),
                                        additionalOnTapAction: () {
                                          if(widget.isPreviewMode != null && widget.isPreviewMode! < widget.images.length-1){
                                            int currentIndex = widget.isPreviewMode!;
                                            widget.callbackPreviewMode(currentIndex + 1);
                                          }
                                        },
                                        builder: (color) {
                                          return Icon(
                                            Icons.keyboard_arrow_right_rounded,
                                            size: 33,
                                            color: color.withOpacity(.7),
                                          );
                                        },
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
}
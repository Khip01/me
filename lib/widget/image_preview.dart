import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/widget/text_highlight_decider.dart';

import '../Utility/style_util.dart';
import '../component/spacing.dart';
import '../component/visible.dart';
import '../provider/image_preview_provider.dart';
import '../provider/theme_provider.dart';

class ImagePreview extends ConsumerStatefulWidget {
  final List<String> images;
  final List<String> imagesHash;
  final int? isPreviewMode;

  const ImagePreview({
    super.key,
    required this.images,
    required this.imagesHash,
    required this.isPreviewMode,
  });

  @override
  ConsumerState<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends ConsumerState<ImagePreview> {
  // General
  final StyleUtil _styleUtil = StyleUtil();

  @override
  Widget build(BuildContext context) {
    // int? selectedIndexImagePreview = ref.watch(isPreviewMode);

    return Visibility(
      // visible: ref.watch(isPreviewMode) != null,
      visible: widget.isPreviewMode != null,
      child: GestureDetector(
        onTap: () => ref.read(isPreviewMode.notifier).state = null,
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          color: _styleUtil.c_61.withOpacity(.7),
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
                          colorStart: (ref.watch(isDarkMode)) ? _styleUtil.c_170 : _styleUtil.c_61,
                          colorEnd: (ref.watch(isDarkMode)) ? _styleUtil.c_255 : _styleUtil.c_24,
                          actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 500 : 100),
                          additionalOnTapAction: () => ref.read(isPreviewMode.notifier).state = null,
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
                                color: ((ref.watch(isDarkMode))
                                    ? _styleUtil.c_33
                                    : _styleUtil.c_255).withOpacity(.7),
                                boxShadow: [
                                  BoxShadow(
                                    color: (ref.watch(isDarkMode))
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
                                    ignoring: ref.read(isPreviewMode) == 0 ? true : false,
                                    child: AnimatedOpacity(
                                      duration: const Duration(milliseconds: 100),
                                      opacity: ref.read(isPreviewMode) == 0 ? 0 : 1,
                                      curve: Curves.easeInOut,
                                      child: TextHighlightDecider(
                                        isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                                        colorStart: (ref.watch(isDarkMode)) ? _styleUtil.c_170 : _styleUtil.c_61,
                                        colorEnd: (ref.watch(isDarkMode)) ? _styleUtil.c_255 : _styleUtil.c_24,
                                        actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 0 : 100),
                                        delayAfterAnimation: const Duration(milliseconds: 0),
                                        additionalOnTapAction: () {
                                          if(ref.read(isPreviewMode) != null && ref.read(isPreviewMode)! > 0){
                                            int currentIndex = ref.read(isPreviewMode)!;
                                            ref.read(isPreviewMode.notifier).state = (currentIndex - 1);
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
                                    ignoring: ref.read(isPreviewMode) == widget.images.length-1 ? true : false,
                                    child: AnimatedOpacity(
                                      duration: const Duration(milliseconds: 100),
                                      opacity: ref.read(isPreviewMode) == widget.images.length-1 ? 0 : 1,
                                      curve: Curves.easeInOut,
                                      child: TextHighlightDecider(
                                        isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                                        colorStart: (ref.watch(isDarkMode)) ? _styleUtil.c_170 : _styleUtil.c_61,
                                        colorEnd: (ref.watch(isDarkMode)) ? _styleUtil.c_255 : _styleUtil.c_24,
                                        actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 0 : 100),
                                        delayAfterAnimation: const Duration(milliseconds: 0),
                                        additionalOnTapAction: () {
                                          if(ref.read(isPreviewMode) != null && ref.read(isPreviewMode)! < widget.images.length-1){
                                            int currentIndex = ref.read(isPreviewMode)!;
                                            ref.read(isPreviewMode.notifier).state = (currentIndex + 1);
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
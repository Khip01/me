import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/widget/scroll_behavior.dart';

import '../Utility/style_util.dart';
import '../component/visible.dart';
import '../provider/theme_provider.dart';
import 'highlighted_widget_on_hover.dart';


class ListImageSection extends ConsumerStatefulWidget {
  final List<String> images;
  final List<String> imagesHash;
  final BoxFit? imagePlaceholderFit;
  final double listViewHeight;
  final double imageWidth;
  final double? imageHeight;
  final double? customBorderCircularValue;
  final Function<Widget>(String image, String hashImage) childImageBuilder;
  final Color? customBackgroundImageColor;
  final EdgeInsets? listViewCustomPadding;
  final Function()? customOnTapItem;
  final Function(int? activeIndex) callbackPreviewMode;

  const ListImageSection({
    super.key,
    required this.images,
    required this.imagesHash,
    required this.imagePlaceholderFit,
    required this.listViewHeight,
    required this.imageWidth,
    this.imageHeight,
    this.customBorderCircularValue,
    required this.childImageBuilder,
    this.customBackgroundImageColor,
    this.listViewCustomPadding,
    this.customOnTapItem,
    required this.callbackPreviewMode,
  });

  @override
  ConsumerState<ListImageSection> createState() => _ListImageSectionState();
}

class _ListImageSectionState extends ConsumerState<ListImageSection> {
  final ScrollController _scrollController = ScrollController();
  final double _spacingItemWidthListView = 12;

  int _selectedIndex = 0;
  List<bool>? cardIsHovered;

  @override
  void initState() {
    _scrollController.addListener(_onScrollActiveIndex);
    cardIsHovered = List.generate(widget.images.length, (_) => false);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollActiveIndex);
    _scrollController.dispose();
    super.dispose();
  }

  void _doSwapFocusedIndex(bool isToLeft){
    if (isToLeft) {
      if(_selectedIndex <= 0) return;
      _selectedIndex--;
    } else {
      if(_selectedIndex >= widget.images.length - 1) return;
      _selectedIndex++;
    }
    _scrollController.animateTo(
      widget.imageWidth * _selectedIndex + (isToLeft ? 0 : _spacingItemWidthListView),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutQuad,
    );
  }

  void _onScrollActiveIndex() {
    int newIndex = (_scrollController.offset / widget.imageWidth).round();
    // Ensure the last item is selected when the scroll reaches the end
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels > 0) {
        newIndex = widget.images.length - 1;
      }
    }
    if (newIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: widget.listViewHeight,
          child: ScrollConfiguration(
            behavior: ScrollWithDragBehavior(),
            child: ListView.separated(
              controller: _scrollController,
              padding: widget.listViewCustomPadding,
              addAutomaticKeepAlives: false,
              cacheExtent: 100,
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return _buildCardImage(index);
              },
              separatorBuilder: (context, index) => SizedBox(width: _spacingItemWidthListView),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: widget.listViewHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _listViewButtonController(
                _selectedIndex != 0,
                true,
                getIsMobileSize(context) ? 40 : 80,
                getIsMobileSize(context) ? 16 : 24,
                    () => setState(() => _doSwapFocusedIndex(true)),
              ),
              _listViewButtonController(
                _selectedIndex != widget.images.length - 1,
                false,
                getIsMobileSize(context) ? 40 : 80,
                getIsMobileSize(context) ? 16 : 24,
                    () => setState(() => _doSwapFocusedIndex(false)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listViewButtonController(bool buttonCondition, bool isButtonLeft, double buttonWidth, double iconSize, Function() onTapAction){
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    const Duration animationDuration = Duration(milliseconds: 150);
    final Alignment beginGradientAlign = isButtonLeft ? Alignment.centerLeft : Alignment.centerRight;
    final Alignment endGradientAlign = isButtonLeft ? Alignment.centerRight : Alignment.centerLeft;
    final Color baseButtonColor = (isDarkMode ? StyleUtil.c_33 : StyleUtil.c_255);
    final Color baseIconColor = (isDarkMode ? StyleUtil.c_238 : StyleUtil.c_61).withOpacity(.9);
    final IconData mainIcon = isButtonLeft ? Icons.arrow_back_ios_new_rounded : Icons.arrow_forward_ios_rounded;

    return AnimatedOpacity(
      duration: animationDuration,
      opacity: buttonCondition ? 1.0 : 0.0,
      child: AnimatedContainer(
        duration: animationDuration,
        width: buttonCondition ? buttonWidth : 0,
        child: InkWell(
          onTap: onTapAction,
          // splashColor: StyleUtil.c_170, // <-- Splash color
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          child: Container(
            height: double.maxFinite,
            width: buttonWidth,
            decoration: BoxDecoration(
              border: Border(
                left: isButtonLeft ? BorderSide(
                  color: baseButtonColor,
                ) : BorderSide.none,
                right: !isButtonLeft ? BorderSide(
                  color: baseButtonColor,
                ) : BorderSide.none,
              ),
              gradient: LinearGradient(
                begin: beginGradientAlign,
                end: endGradientAlign,
                colors: [
                  baseButtonColor.withOpacity(1.0), // <-- Button color
                  baseButtonColor.withOpacity(0.0),
                ],
              ),
            ),
            child: Center(
              child: Icon(
                mainIcon,
                color: baseIconColor,
                size: iconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardImage(int index){
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return HighlightedWidgetOnHover(
      widgetHeight: widget.imageHeight,
      widgetWidth: widget.imageWidth,
      onTapAction: () {
        if (widget.customOnTapItem != null) widget.customOnTapItem!();
        // ref.read(isPreviewMode.notifier).state = index;
        widget.callbackPreviewMode(index);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: widget.imagePlaceholderFit,
            image: BlurHashImage(
              widget.imagesHash[index],
            ),
          ),
          borderRadius: BorderRadius.circular(getIsMobileSize(context) ? 0 : widget.customBorderCircularValue ??  8),
          color:  (widget.customBackgroundImageColor != null) ? widget.customBackgroundImageColor! :
          (isDarkMode)
              ? StyleUtil.c_33
              : StyleUtil.c_255,
          boxShadow: [
            BoxShadow(
              color: (widget.customBackgroundImageColor != null) ? widget.customBackgroundImageColor! :
                (isDarkMode)
                  ? const Color.fromARGB(255, 200, 200, 200)
                  : const Color.fromARGB(255, 233, 233, 233),
              blurRadius: 7.0,
            ),
          ],
        ),
        height: widget.imageHeight,
        width: widget.imageWidth,
        child: widget.childImageBuilder(widget.images[index], widget.imagesHash[index]),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:me/component/components.dart';
import 'package:me/provider/image_preview_provider.dart';
import 'package:me/provider/theme_provider.dart';
import 'package:me/Utility/style_util.dart';
import 'package:me/utility/icon_util.dart';
import 'package:me/values/values.dart';
import 'package:me/widget/cover_image_sliding_creation.dart';
import 'package:me/widget/scroll_behavior.dart';

import '../widget/text_highlight_decider.dart';

class CreationDetailPage extends ConsumerStatefulWidget {
  final ProjectItemData selectedProject;

  const CreationDetailPage({
    super.key,
    required this.selectedProject,
  });

  @override
  ConsumerState<CreationDetailPage> createState() => _CreationDetailPageState();
}

class _CreationDetailPageState extends ConsumerState<CreationDetailPage> {
  // General
  final StyleUtil _styleUtil = StyleUtil();
  final IconUtil _iconUtil = IconUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
      body: Stack(
        children: [
            SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                _coverSectionSelectedCreation(),
                _contentBodySelectedCreation(),
              ],
            ),
          ),
          ImagePreview(
            images: widget.selectedProject.projectImagePathList,
          ),
        ],
      ),
    );
  }

  Widget _coverSectionSelectedCreation(){
    return CoverImageSlidingCreation(
      isCompactDevice: getIsMobileSize(context) || getIsTabletSize(context),
      selectedProject: widget.selectedProject,
      imageCountToBeShown: widget.selectedProject.projectImagePathList.length,
    );
  }

  Widget _contentBodySelectedCreation() {
    return Container(
      padding: contentCardPaddingAround(context),
      width: MediaQuery.sizeOf(context).width,
      color: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 93 +  (getIsMobileSize(context) ? 71 : 0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      ListImageSection(
                        images: widget.selectedProject.projectImagePathList,
                        listViewHeight: 360 - (getIsMobileSize(context) ? 101 : getIsTabletSize(context) ? 51: 0) - 16,
                        imageHeight: 310 - (getIsMobileSize(context) ? 101 : getIsTabletSize(context) ? 51: 0) - 16,
                        imageWidth: contentHighlightWidth(context) - 32,
                      ),
                      DetailCreationAdditionalInfo(
                        timestampDetailDateCreated: widget.selectedProject.timestampDateCreated,
                        detailTags: widget.selectedProject.projectCategories,
                      ),
                      _otherCreationHorizontal(),
                    ],
                  ),
                ),
                _otherCreationVertical(),
              ],
            ),
          ),
          _footerTechnology(),
        ],
      ),
    );
  }

  Widget _otherCreationVertical(){
    return Visibility(
      visible: !getIsDesktopMdAndBelowSize(context),
      child: Container(
        margin: const EdgeInsets.only(left: 28),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 500,
        width: 300,
        child: const Center(child: Text("Related Project, this section is coming soon")),
      ),
    );
  }

  Widget _otherCreationHorizontal(){
    return Visibility(
      visible: getIsDesktopMdAndBelowSize(context),
      child: Padding(
        padding: const EdgeInsets.only(top: 45),
        child: Container(
          margin: contentCardPadding(context) / 2,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 300,
          width: double.maxFinite,
          child: const Center(child: Text("Related Project, this section is coming soon")),
        ),
      ),
    );
  }

  Widget _footerTechnology(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 39),
      child: Center(
        child: SizedBox(
          width: 125,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Built with  ", style: TextStyle(fontFamily: 'Lato', fontSize: 12, color: _styleUtil.c_170),),
              Tooltip(message: "Flutter Framework", child: Image.asset(_iconUtil.flutterLogo)),
              Text("  and  ", style: TextStyle(fontFamily: 'Lato', fontSize: 12, color: _styleUtil.c_170),),
              Tooltip(message: "Firebase RTDB", child: Image.asset(_iconUtil.firebaseLogoNew)),
            ],
          ),
        ),
      ),
    );
  }
}

class ListImageSection extends ConsumerStatefulWidget {
  final List<String> images;
  final double listViewHeight;
  final double imageHeight;
  final double imageWidth;

  const ListImageSection({
    super.key,
    required this.images,
    required this.listViewHeight,
    required this.imageHeight,
    required this.imageWidth,
  });

  @override
  ConsumerState<ListImageSection> createState() => _ListImageSectionState();
}

class _ListImageSectionState extends ConsumerState<ListImageSection> {
  final StyleUtil _styleUtil = StyleUtil();
  final ScrollController _scrollController = ScrollController();

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
      widget.imageWidth * _selectedIndex,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SizedBox(
            height:  widget.listViewHeight,
            child: ScrollConfiguration(
              behavior: ScrollWithDragBehavior(),
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                addAutomaticKeepAlives: false,
                cacheExtent: 100,
                scrollDirection: Axis.horizontal,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return _buildCardImage(index);
                },
                separatorBuilder: (context, index) => const SizedBox(width: 12,),
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          height: widget.listViewHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: _selectedIndex != 0,
                child: ElevatedButton(
                  onPressed: () => setState(() => _doSwapFocusedIndex(true)),
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: _styleUtil.c_255, // <-- Button color
                    foregroundColor: _styleUtil.c_170, // <-- Splash color
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: _styleUtil.c_61,
                    size: 20,
                  ),
                ),
              ),
              Visibility(
                visible: _selectedIndex != widget.images.length - 1,
                child: ElevatedButton(
                  onPressed: () => setState(() => _doSwapFocusedIndex(false)),
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: _styleUtil.c_255, // <-- Button color
                    foregroundColor: _styleUtil.c_170, // <-- Splash color
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: _styleUtil.c_61,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardImage(int index){
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getIsMobileSize(context) ? 0 : 8),
            color: (ref.watch(isDarkMode))
                ? _styleUtil.c_33
                : _styleUtil.c_255,
            boxShadow: [
              BoxShadow(
                color: (ref.watch(isDarkMode))
                    ? const Color.fromARGB(255, 200, 200, 200)
                    : const Color.fromARGB(255, 233, 233, 233),
                blurRadius: 7.0,
              ),
            ],
          ),
          height: widget.imageHeight,
          width: widget.imageWidth,
          child: Image.asset(widget.images[index], fit: BoxFit.cover),
        ),
        InkWell(
          onTap: () => ref.read(isPreviewMode.notifier).state = index,
          onHover: (val) => setState(() => cardIsHovered![index] = val),
          child: SizedBox(
            height: widget.imageHeight,
            width: widget.imageWidth,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getIsMobileSize(context) ? 0 : 8),
                color: cardIsHovered![index] ? _styleUtil.c_170.withOpacity(.1) : Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DetailCreationAdditionalInfo extends ConsumerWidget {
  final int timestampDetailDateCreated;
  final List<String> detailTags;

  DetailCreationAdditionalInfo({
    super.key,
    required this.timestampDetailDateCreated,
    required this.detailTags,
  });

  final StyleUtil _styleUtil = StyleUtil();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime itemDate = DateTime.fromMillisecondsSinceEpoch(timestampDetailDateCreated);
    DateFormat dateFormatter = DateFormat("MMM dd, yyyy");
    
    return Padding(
      padding: contentCardPadding(context) / 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: _createdOnSection(dateFormatter.format(itemDate), ref),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: _creationTagSection(ref),
          ),
        ],
      ),
    );
  }

  Widget _createdOnSection(String formatedDate, WidgetRef ref){
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Created on", style: TextStyle(fontFamily: 'Lato', fontSize: 16, fontWeight: FontWeight.w700, color: (ref.watch(isDarkMode)) ? _styleUtil.c_238 : _styleUtil.c_61),),
          Text(formatedDate, style: TextStyle(fontFamily: 'Lato', fontSize: 16, color: (ref.watch(isDarkMode)) ? _styleUtil.c_170 : _styleUtil.c_61),),
        ],
      ),
    );
  }

  Widget _creationTagSection(WidgetRef ref){
    return SizedBox(
      width: double.maxFinite,
      child: Wrap(
        spacing: 7, // spacing horizontally
        runSpacing: 7, // spacing vertically
        children: List.generate(detailTags.length, (index){
          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _styleUtil.c_170,
                width: 1,
              ),
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 7),
              child: Text(detailTags[index], style: TextStyle(fontFamily: 'Lato', fontSize: 16, color: (ref.watch(isDarkMode)) ? _styleUtil.c_238 : _styleUtil.c_61),),
            ),
          );
        }, growable: true),
      ),
    );
  }
}

class ImagePreview extends ConsumerStatefulWidget {
  final List<String> images;

  const ImagePreview({
    super.key,
    required this.images,
  });

  @override
  ConsumerState<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends ConsumerState<ImagePreview> {
  // General
  final StyleUtil _styleUtil = StyleUtil();

  @override
  Widget build(BuildContext context) {
    int? selectedIndexImagePreview = ref.watch(isPreviewMode);

    return Visibility(
      visible: ref.watch(isPreviewMode) != null,
      child: GestureDetector(
        onTap: () => ref.read(isPreviewMode.notifier).state = null,
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          color: _styleUtil.c_61.withOpacity(.5),
          child: Stack(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {}, // Prevent the outer GestureDetector from closing the preview,
                  child: ref.watch(isPreviewMode) != null ?
                    Image.asset(widget.images[selectedIndexImagePreview!]) :
                    const SizedBox(),
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
                                color: (ref.watch(isDarkMode))
                                    ? _styleUtil.c_33
                                    : _styleUtil.c_255,
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
                                        actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 500 : 100),
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
                                            color: color,
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
                                        actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 500 : 100),
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
                                            color: color,
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




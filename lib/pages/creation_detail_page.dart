import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/component/components.dart';
import 'package:me/provider/theme_provider.dart';
import 'package:me/Utility/style_util.dart';
import 'package:me/values/values.dart';
import 'package:me/widget/cover_image_sliding_creation.dart';
import 'package:me/widget/scroll_behavior.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';


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
  StyleUtil _styleUtil = StyleUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _coverSectionSelectedCreation(),
            _contentBodySelectedCreation(),
          ],
        ),
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
                _detailCreationTag(),
                _otherCreationHorizontal(),
              ],
            ),
          ),
          _otherCreationVertical(),
        ],
      ),
    );
  }

  Widget _detailCreationTag(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        height: 100,
        color: Colors.yellow,
        child: const Center(child: Text("Tag, etc")),
      ),
    );
  }

  Widget _otherCreationVertical(){
    return Visibility(
      visible: !getIsDesktopMdAndBelowSize(context),
      child: Container(
        margin: const EdgeInsets.only(left: 28),
        height: 500,
        width: 300,
        color: Colors.blue,
        child: const Center(child: Text("Related Project, more")),
      ),
    );
  }

  Widget _otherCreationHorizontal(){
    return Visibility(
      visible: getIsDesktopMdAndBelowSize(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        height: 300,
        width: double.maxFinite,
        color: Colors.blue,
        child: const Center(child: Text("Related Project, more")),
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

  @override
  void initState() {
    _scrollController.addListener(_onScrollActiveIndex);
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
    // if ()
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SizedBox(
            height:  widget.listViewHeight,
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
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getIsMobileSize(context) ? 0 : 8),
        color: (ref.watch(isDarkMode))
            ? _styleUtil.c_33
            : _styleUtil.c_255,
        boxShadow: [
          BoxShadow(
            color: (ref.watch(isDarkMode))
                ? const Color.fromARGB(255, 61, 61, 61)
                : const Color.fromARGB(255, 233, 233, 233),
            blurRadius: 7.0,
          ),
        ],
      ),
      height: widget.imageHeight,
      width: widget.imageWidth,
      child: Image.asset(widget.images[index], fit: BoxFit.cover),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:me/Utility/style_util.dart';
import 'package:me/component/components.dart';
import 'package:me/provider/theme_provider.dart';
import 'package:me/values/values.dart';
import 'package:me/widget/text_highlight_decider.dart';

class CoverImageSlidingCreation extends ConsumerStatefulWidget {
  // Required atribute
  final bool isCompactDevice; // Only have 2 option, between compact device and desktop device
  final ProjectItemData selectedProject;
  final int imageCountToBeShown; // should be length of the listImage, or u can custom it :)

  const CoverImageSlidingCreation({
    super.key,
    required this.isCompactDevice,
    required this.selectedProject,
    required this.imageCountToBeShown,
  });

  @override
  ConsumerState<CoverImageSlidingCreation> createState() => _CoverImageSlidingCreationState();
}

class _CoverImageSlidingCreationState extends ConsumerState<CoverImageSlidingCreation> {
  // General
  StyleUtil _styleUtil = StyleUtil();

  // Class atribute
  bool _isZoomOut = false;
  late List<bool> _imageIsVisible;

  @override
  void initState() {
    _imageIsVisible = List.generate(widget.imageCountToBeShown, (index) => false, growable: false);
    startCoverAnimation();
    super.initState();
  }

  // TODO: FUNCTION
  void startCoverAnimation() {
    for (int index = 0; index < widget.imageCountToBeShown; index++) {
      Future.delayed(Duration(milliseconds: 400 * (index + 1)), () {
        if (mounted) {
          setState(() {
            _imageIsVisible[index] = true;
          });
          // TODO ZOOM OUT
          if (index == widget.imageCountToBeShown - 1) {
            Future.delayed(const Duration(milliseconds: 700), () {
              if (mounted) {
                setState(() {
                  _isZoomOut = true;
                });
              }
            });
          }
        }
      });
    }
  }

  // void resetButtonPosition() {
  //   setState(() {
  //     _imageIsVisible = List.generate(widget.imageCount, (index) => false, growable: false);
  //     _isZoomOut = false;
  //   });
  // } // Idk maybe i didnt need this, but lets save it for a while

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Stack(
        children: [
          _backImageCoverSide(),
          _frontTitleCoverSide(),
        ],
      ),
    );
  }

  Widget _backImageCoverSide(){
    return AnimatedScale(
      scale: _isZoomOut ? 1.0 : 1.7,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if(!widget.isCompactDevice){
            // TODO DESKTOP MODE
            return Stack(
              children: [
                for (int index = 0; index < widget.imageCountToBeShown; index++)
                  AnimatedPositioned(
                    key: ValueKey(index),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: constraints.maxWidth * index / widget.imageCountToBeShown,
                    top: index % 2 == 0
                        ? (_imageIsVisible[index] ? 0 : -MediaQuery.sizeOf(context).height)
                        : null,
                    bottom: index % 2 == 1
                        ? (_imageIsVisible[index] ? 0 : -MediaQuery.sizeOf(context).height)
                        : null,
                    child: SizedBox(
                      width: constraints.maxWidth / widget.imageCountToBeShown,
                      height: MediaQuery.sizeOf(context).height,
                      child: Image.asset(widget.selectedProject.projectImagePathList[index], fit: BoxFit.fitHeight,),
                    ),
                  ),
              ],
            );
          } else {
            // TODO MOBILE MODE
            return Stack(
              children: [
                for (int index = 0; index < widget.imageCountToBeShown; index++)
                  AnimatedPositioned(
                    key: ValueKey(index),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    top: constraints.maxHeight * index / widget.imageCountToBeShown,
                    left: index % 2 == 0
                        ? (_imageIsVisible[index] ? 0 : -MediaQuery.sizeOf(context).width)
                        : null,
                    right: index % 2 == 1
                        ? (_imageIsVisible[index] ? 0 : -MediaQuery.sizeOf(context).width)
                        : null,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: constraints.maxHeight / widget.imageCountToBeShown,
                      child: Image.asset(widget.selectedProject.projectImagePathList[index], fit: BoxFit.fitWidth,),
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _frontTitleCoverSide() {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            color:
            ref.watch(isDarkMode) ?
            _styleUtil.c_33.withOpacity(_isZoomOut ? 0.7 : 0) :
            _styleUtil.c_255.withOpacity(_isZoomOut ? 0.7 : 0), // TODO DARK MODE SETTING
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 1.0],
              colors: [
                Colors.transparent,
                _isZoomOut ?
                  ref.watch(isDarkMode) ?
                  _styleUtil.c_33 :
                  _styleUtil.c_255 :
                Colors.transparent, // TODO DARK MODE SETTING
              ],
            ),
          ),
          child: AnimatedOpacity(
            opacity: _isZoomOut ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: _subFrontTitleCoverSide(),
          ),
        ),
      ],
    );
  }

  Widget _subFrontTitleCoverSide(){
    return Column(
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
                additionalOnTapAction: () => context.goNamed("creation"),
                builder: (color) {
                  return Icon(
                    Icons.arrow_back,
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
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height - 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  width: double.maxFinite,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.selectedProject.projectName,
                      style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color:
                        (ref.watch(isDarkMode)) ? _styleUtil.c_255 : _styleUtil.c_33,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  width: 694,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.selectedProject.projectDescription,
                      style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color:
                        (ref.watch(isDarkMode)) ? _styleUtil.c_238 : _styleUtil.c_61,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

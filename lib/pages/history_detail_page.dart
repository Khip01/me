import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:me/Utility/style_util.dart';
import 'package:me/component/components.dart';
import 'package:me/provider/theme_provider.dart';
import 'package:me/values/values.dart';
import 'package:me/widget/highlighted_widget_on_hover.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../widget/text_highlight_decider.dart';

class HistoryDetailPage extends ConsumerStatefulWidget {
  final int index;
  final HistoryItemData historyData;

  const HistoryDetailPage({
    super.key,
    required this.index,
    required this.historyData,
  });

  @override
  ConsumerState<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends ConsumerState<HistoryDetailPage> {
  // General
  final StyleUtil _styleUtil = StyleUtil();

  final historyItemController = ItemScrollController();

  final double appBarHeight = 80;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      historyItemController.jumpTo(index: widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            appBarSection(),
            Flexible(
              fit: FlexFit.tight,
              child: historySection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBarSection() {
    return Container(
      height: appBarHeight,
      width: double.maxFinite,
      padding: contentCardPadding(context),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: getIsMobileSize(context) ? 8 : 16),
            child: SizedBox(
              height: 80,
              width: 33,
              child: Center(
                child: TextHighlightDecider(
                  isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                  colorStart: (ref.watch(isDarkMode)) ? _styleUtil.c_170 : _styleUtil.c_61,
                  colorEnd: (ref.watch(isDarkMode)) ? _styleUtil.c_255 : _styleUtil.c_24,
                  actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 500 : 100),
                  additionalOnTapAction: () => context.goNamed("history"),
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
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Documentation",
                  style: TextStyle(fontFamily: 'Lato', fontSize: 14, color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61),
                ),
                Text(
                  widget.historyData.historyTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: 'Lato', fontSize: 20, color: ref.watch(isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_61),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget historySection() {
    return SizedBox(
      height: double.maxFinite,
      child: ScrollablePositionedList.builder(
        itemCount: widget.historyData.historyDocumentations!.length,
        itemScrollController: historyItemController,
        itemBuilder: (context, index) {
          return ContentItemHistorySection(
            index: index,
            appBarHeight: appBarHeight,
            historyItemData: widget.historyData,
          );
        },
      ),
    );
  }
}

class ContentItemHistorySection extends ConsumerStatefulWidget {
  final int index;
  final double appBarHeight;
  final HistoryItemData historyItemData;

  const ContentItemHistorySection({
    super.key,
    required this.index,
    required this.appBarHeight,
    required this.historyItemData,
  });

  @override
  ConsumerState<ContentItemHistorySection> createState() => _ContentItemHistorySectionState();
}

class _ContentItemHistorySectionState extends ConsumerState<ContentItemHistorySection> {
  // General
  final StyleUtil _styleUtil = StyleUtil();

  late double contentItemHeightBase;

  @override
  Widget build(BuildContext context) {
    contentItemHeightBase = MediaQuery.sizeOf(context).height - widget.appBarHeight;

    return Column( // IDK why this widget exist :)
      children: [
        Padding(
          padding: contentQuotePadding(context),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 1100,
            ),
            margin: EdgeInsets.symmetric(horizontal: getIsMobileSize(context) ? 0 : 28),
            height: contentItemHeightBase,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return historyModeDecider(constraints);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget historyModeDecider(BoxConstraints constraints){
    if(getIsMobileSize(context) || getIsTabletSize(context) || getIsDesktopSmSize(context)){
      return historyModeVertical();
    } else {
      return historyModeHorizontal(constraints);
    }
  }

  // TODO: EVIL AREA OF THE FLUTTER DEV DO NOT OPEN >:C
  // TODO: DON'T USE PRETTIER ALSO!! IT WILL ONLY MAKE YOU SUFFER
  Widget historyModeHorizontal(BoxConstraints constraints){
    final HistoryItemDocumentation historyItemDocumentation = widget.historyItemData.historyDocumentations![widget.index];
    final DateFormat dateFormatter = DateFormat("MMM dd, yyyy");

    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40, top: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: LEFT SIDE
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                padding: const EdgeInsets.only(right: 20),
                clipBehavior: Clip.antiAlias,
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    blurredImage(
                      historyItemDocumentation.docImageList[0],
                      BoxFit.cover,
                    ),
                    Image.asset(
                      historyItemDocumentation.docImageList[0],
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            // TODO: RIGHT SIDE
            SizedBox(
              width: constraints.maxWidth / 2,
              height: double.maxFinite,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight / 2,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    historyItemDocumentation.docType,
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 14,
                                      color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    historyItemDocumentation.docTitle,
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 20,
                                      color: ref.watch(isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_61,
                                    ),
                                  ),
                                ),
                                Text(
                                  historyItemDocumentation.docDesc,
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (historyItemDocumentation.docRelatedProjects != null)
                        Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // TODO: Tab Related Creations
                                  SizedBox(
                                    height: 40,
                                    width: 160,
                                    child: Wrap(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 6),
                                          child: Text(
                                            "Related Creations",
                                            style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontSize: 16,
                                              color: ref.watch(isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_24,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.maxFinite,
                                          height: 4,
                                          child: DecoratedBox(decoration: BoxDecoration(
                                            color: _styleUtil.c_170,
                                            borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: (ref.watch(isDarkMode))
                                                    ? _styleUtil.c_170
                                                    : _styleUtil.c_170,
                                                blurRadius: 5.0,
                                              ),
                                            ],
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                  // TODO: List Related Project
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for(int index = 0; index < historyItemDocumentation.docRelatedProjects!.length; index++)
                                        HighlightedWidgetOnHover(
                                          onTapAction: () => context.goNamed(
                                            "details_creation",
                                            queryParameters: {
                                              "id": historyItemDocumentation.docRelatedProjects![index].projectId,
                                            },
                                            extra: "/history/details?index=${widget.index}&id=${widget.historyItemData.historyItemDataId}",
                                          ),
                                          widgetHeight: 125,
                                          widgetWidth: double.maxFinite,
                                          customBorderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          child: SizedBox(
                                            width: double.maxFinite,
                                            height: 125,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 20),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 10),
                                                    child: SizedBox(
                                                      height: double.maxFinite,
                                                      width: 134,
                                                      child: Image.asset(
                                                        historyItemDocumentation.docRelatedProjects![index].projectImagePathList[0],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    child: SizedBox(
                                                      height: double.maxFinite,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            historyItemDocumentation.docRelatedProjects![index].projectName,
                                                            style: TextStyle(
                                                              fontFamily: 'Lato',
                                                              fontSize: 16,
                                                              color: ref.watch(isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_24,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: double.maxFinite,
                                                            height: 16,
                                                            child: ListView.separated(
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              scrollDirection: Axis.horizontal,
                                                              itemCount: historyItemDocumentation.docRelatedProjects![index].projectCategories.length,
                                                              itemBuilder: (BuildContext context, int indexCategories){
                                                                return Text(
                                                                  historyItemDocumentation.docRelatedProjects![index].projectCategories[indexCategories],
                                                                  style: TextStyle(
                                                                    fontFamily: 'Lato',
                                                                    fontSize: 12,
                                                                    color: ref.watch(isDarkMode) ?
                                                                    _styleUtil.c_238 :
                                                                    _styleUtil.c_61,
                                                                  ),
                                                                );
                                                              },
                                                              separatorBuilder: (BuildContext context, int index) {
                                                                return Text("  ·  ", style: TextStyle(fontFamily: 'Lato', fontSize: 12, color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61),);
                                                              },
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            dateFormatter.format(
                                                              DateTime.fromMillisecondsSinceEpoch(historyItemDocumentation.docRelatedProjects![index].timestampDateCreated)
                                                            ),
                                                            style: TextStyle(
                                                              fontFamily: 'Lato', fontSize: 12, color: _styleUtil.c_170,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget historyModeVertical(){
    final HistoryItemDocumentation historyItemDocumentation = widget.historyItemData.historyDocumentations![widget.index];
    final DateFormat dateFormatter = DateFormat("MMM dd, yyyy");

    return Padding(
      padding: EdgeInsets.only(bottom: getIsMobileSize(context) ? 60 : 0),
      child: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: getIsMobileSize(context) ? 0 : 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // TODO: TOP SIDE
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 20), //
                  clipBehavior: Clip.antiAlias,
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(getIsMobileSize(context) ? 0 : 20), //
                        topRight: Radius.circular(getIsMobileSize(context) ? 0 : 20), //
                      )
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      blurredImage(
                        historyItemDocumentation.docImageList[0],
                        BoxFit.cover,
                      ),
                      Image.asset(
                        historyItemDocumentation.docImageList[0],
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              // TODO: BOTTOM SIDE
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getIsMobileSize(context) ? 0 : 0),
                child: Column( // removed sizedbox and layout builder
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox( // container -> sizedbox
                      width: double.maxFinite, // constraints
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10), //
                        child: Column( // removed alignment bottom center
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                historyItemDocumentation.docType,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                historyItemDocumentation.docTitle,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 20,
                                  color: ref.watch(isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_61,
                                ),
                              ),
                            ),
                            Text(
                              historyItemDocumentation.docDesc,
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (historyItemDocumentation.docRelatedProjects != null)
                      Padding( // removed flexible
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // TODO: Tab Related Creations
                                SizedBox(
                                  height: 40,
                                  width: 160,
                                  child: Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6),
                                        child: Text(
                                          "Related Creations",
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            color: ref.watch(isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_24,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.maxFinite,
                                        height: 4,
                                        child: DecoratedBox(decoration: BoxDecoration(
                                          color: _styleUtil.c_170,
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: (ref.watch(isDarkMode))
                                                  ? _styleUtil.c_170
                                                  : _styleUtil.c_170,
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                                // TODO: List Related Project
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for(int index = 0; index < historyItemDocumentation.docRelatedProjects!.length; index++)
                                      HighlightedWidgetOnHover(
                                        onTapAction: () => context.goNamed(
                                          "details_creation",
                                          queryParameters: {
                                            "id": historyItemDocumentation.docRelatedProjects![index].projectId,
                                          },
                                          extra: "/history/details?index=${widget.index}&id=${widget.historyItemData.historyItemDataId}",
                                        ),
                                        widgetHeight: 125,
                                        widgetWidth: double.maxFinite,
                                        customBorderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(0),
                                          topRight: const Radius.circular(0),
                                          bottomLeft: Radius.circular(getIsMobileSize(context) ? 0 : 20),
                                          bottomRight: Radius.circular(getIsMobileSize(context) ? 0 : 20),
                                        ),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          height: 125,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 10),
                                                  child: SizedBox(
                                                    height: double.maxFinite,
                                                    width: 134,
                                                    child: Image.asset(
                                                      historyItemDocumentation.docRelatedProjects![index].projectImagePathList[0],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  fit: FlexFit.tight,
                                                  child: SizedBox(
                                                    height: double.maxFinite,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          historyItemDocumentation.docRelatedProjects![index].projectName,
                                                          style: TextStyle(
                                                            fontFamily: 'Lato',
                                                            fontSize: 16,
                                                            color: ref.watch(isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_24,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: double.maxFinite,
                                                          height: 16,
                                                          child: ListView.separated(
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            scrollDirection: Axis.horizontal,
                                                            itemCount: historyItemDocumentation.docRelatedProjects![index].projectCategories.length,
                                                            itemBuilder: (BuildContext context, int indexCategories){
                                                              return Text(
                                                                historyItemDocumentation.docRelatedProjects![index].projectCategories[indexCategories],
                                                                style: TextStyle(
                                                                  fontFamily: 'Lato',
                                                                  fontSize: 12,
                                                                  color: ref.watch(isDarkMode) ?
                                                                  _styleUtil.c_238 :
                                                                  _styleUtil.c_61,
                                                                ),
                                                              );
                                                            },
                                                            separatorBuilder: (BuildContext context, int index) {
                                                              return Text("  ·  ", style: TextStyle(fontFamily: 'Lato', fontSize: 12, color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61),);
                                                            },
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          dateFormatter.format(
                                                              DateTime.fromMillisecondsSinceEpoch(historyItemDocumentation.docRelatedProjects![index].timestampDateCreated)
                                                          ),
                                                          style: TextStyle(
                                                            fontFamily: 'Lato', fontSize: 12, color: _styleUtil.c_170,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          )
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // TODO: THE END OF THE EVIL AREA OF THE FLUTTER DEV :) THANKS..

  Widget blurredImage(String asset, BoxFit fit){
    return Container(
      clipBehavior: Clip.antiAlias,
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage(asset),
          fit: fit,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: const DecoratedBox(decoration: BoxDecoration(color: Colors.transparent)),
      ),
    );
  }
}



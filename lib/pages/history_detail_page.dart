import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:me/Utility/style_util.dart';
import 'package:me/component/components.dart';
import 'package:me/helper/get_size_from_widget.dart';
import 'package:me/provider/image_preview_provider.dart';
import 'package:me/provider/theme_provider.dart';
import 'package:me/values/values.dart';
import 'package:me/widget/blurred_image.dart';
import 'package:me/widget/highlighted_widget_on_hover.dart';
import 'package:me/widget/image_preview.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../widget/list_image_section.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      historyItemController.jumpTo(index: widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
        body: Stack(
          children: [
            SizedBox(
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
            ImagePreview(
              images: widget.historyData.historyDocumentations![ref.watch(indexDocumentation) ?? widget.index].docImageList,
              imagesHash: widget.historyData.historyDocumentations![ref.watch(indexDocumentation) ?? widget.index].docImageListHash,
              isPreviewMode: ref.watch(isPreviewMode),
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
      width: double.maxFinite,
      child: ScrollablePositionedList.builder(
        itemCount: widget.historyData.historyDocumentations!.length,
        itemScrollController: historyItemController,
        itemBuilder: (context, index) {
          return ItemHistorySection(
            index: index,
            appBarHeight: appBarHeight,
            historyItemData: widget.historyData,
          );
        },
      ),
    );
  }
}

class ItemHistorySection extends StatefulWidget {
  final int index;
  final double appBarHeight;
  final HistoryItemData historyItemData;

  const ItemHistorySection({
    super.key,
    required this.index,
    required this.appBarHeight,
    required this.historyItemData,
  });

  @override
  State<ItemHistorySection> createState() => _ItemHistorySectionState();
}

class _ItemHistorySectionState extends State<ItemHistorySection> {
  late final HistoryItemDocumentation historyItemDocumentation;
  final DateFormat dateFormatter = DateFormat("MMM dd, yyyy");

  @override
  void initState() {
    super.initState();
    historyItemDocumentation = widget.historyItemData.historyDocumentations![widget.index];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: contentQuotePadding(context),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 1100,
          minHeight: MediaQuery.sizeOf(context).height - widget.appBarHeight,
        ),
        margin: EdgeInsets.symmetric(horizontal: getIsMobileSize(context) ? 15 : 28),
        width: double.maxFinite,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return historyModeDecider(constraints);
          },
        ),
      ),
    );
  }

  Widget historyModeDecider(BoxConstraints constraints){
    if(getIsMobileSize(context) || getIsTabletSize(context) || getIsDesktopSmSize(context)){
      return ContentItemHistoryVertical(
        itemIndex: widget.index,
        constraints: constraints,
        historyItemData: widget.historyItemData,
        historyItemDocumentation: historyItemDocumentation,
        dateFormatter: dateFormatter,
      );
    } else {
      return ContentItemHistoryHorizontal(
        itemIndex: widget.index,
        constraints: constraints,
        historyItemData: widget.historyItemData,
        historyItemDocumentation: historyItemDocumentation,
        dateFormatter: dateFormatter,
      );
    }
  }
}

class ContentItemHistoryVertical extends ConsumerWidget {
  final int itemIndex;
  final BoxConstraints constraints;
  final HistoryItemData historyItemData;
  final HistoryItemDocumentation historyItemDocumentation;
  final DateFormat dateFormatter;

  ContentItemHistoryVertical({
    super.key,
    required this.itemIndex,
    required this.constraints,
    required this.historyItemData,
    required this.historyItemDocumentation,
    required this.dateFormatter,
  });

  final StyleUtil _styleUtil = StyleUtil();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: itemIndex == historyItemData.historyDocumentations!.length-1 ? 0 : (getIsMobileSize(context) ? 64 : 40)),
      child: Container(
        width: double.maxFinite,
        constraints: BoxConstraints(
          minHeight: constraints.minHeight,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO: TOP SIDE
            Container(
              padding: const EdgeInsets.only(bottom: 20), //
              clipBehavior: Clip.antiAlias,
              height: constraints.minHeight / 2,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(getIsMobileSize(context) ? 0 : 20), //
                    topRight: Radius.circular(getIsMobileSize(context) ? 0 : 20), //
                  )
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // BlurredImage(
                  //   imageAsset: historyItemDocumentation.docImageList[0],
                  //   imageAssetHash: historyItemDocumentation.docImageListHash[0],
                  //   fit: BoxFit.cover,
                  // ),
                  ListImageSection(
                    images: historyItemDocumentation.docImageList,
                    imagesHash: historyItemDocumentation.docImageListHash,
                    imagePlaceholderFit: BoxFit.cover,
                    listViewHeight: constraints.maxHeight,
                    imageWidth: constraints.maxWidth,
                    customBackgroundImageColor: Colors.transparent,
                    childImageBuilder: <Widget>(image, hash) {
                      return Center(
                        child: Image.asset(
                          image,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                    customOnTapItem: () {
                      ref.read(indexDocumentation.notifier).state = itemIndex;
                    },
                  ),
                ],
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
                    relatedProjectSection(context, ref),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget relatedProjectSection(BuildContext context, WidgetRef ref){
    return Padding( // removed flexible
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // TODO: Tab Related Project
              SizedBox(
                height: 40,
                width: 160,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        "Related Project",
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
                    itemRelatedProject(context, ref, index),
                ],
              )
            ],
          ),
        )
    );
  }

  Widget itemRelatedProject(BuildContext context, WidgetRef ref, int index){
    return HighlightedWidgetOnHover(
      onTapAction: () => context.goNamed(
        "details_creation",
        queryParameters: {
          "id": historyItemDocumentation.docRelatedProjects![index].projectId,
        },
        extra: "/history/details?index=$itemIndex&id=${historyItemData.historyItemDataId}",
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
                child: Container(
                  height: double.maxFinite,
                  width: 134,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: BlurHashImage(
                        historyItemDocumentation.docRelatedProjects![index].projectImagePathListHash[0],
                      ),
                    ),
                  ),
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
    );
  }
}

class ContentItemHistoryHorizontal extends ConsumerWidget {
  final int itemIndex;
  final BoxConstraints constraints;
  final HistoryItemData historyItemData;
  final HistoryItemDocumentation historyItemDocumentation;
  final DateFormat dateFormatter;

  ContentItemHistoryHorizontal({
    super.key,
    required this.itemIndex,
    required this.constraints,
    required this.historyItemData,
    required this.historyItemDocumentation,
    required this.dateFormatter,
  });

  final StyleUtil _styleUtil = StyleUtil();

  final GlobalKey widgetRightSideKey = GlobalKey();

  Size? widgetRightSideSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.maxFinite,
      constraints: BoxConstraints(
        minHeight: constraints.minHeight - 80,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40, top: 40),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              constraints: BoxConstraints(
                  minHeight: constraints.minHeight
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: LEFT SIDE
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    clipBehavior: Clip.antiAlias,
                    width: constraints.maxWidth / 2,
                    height: getWidgetSize(widgetRightSideKey.currentContext)?.height ?? constraints.minHeight,
                    decoration: const BoxDecoration(
                      border: Border.fromBorderSide(BorderSide.none),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            // Positioned.fill(
                            //   child: BlurredImage(
                            //     imageAsset: historyItemDocumentation.docImageList[0],
                            //     imageAssetHash: historyItemDocumentation.docImageListHash[0],
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            ListImageSection(
                              images: historyItemDocumentation.docImageList,
                              imagesHash: historyItemDocumentation.docImageListHash,
                              imagePlaceholderFit: BoxFit.cover,
                              listViewHeight: constraints.maxHeight,
                              imageWidth: constraints.maxWidth,
                              customBackgroundImageColor: Colors.transparent,
                              customBorderCircularValue: 0,
                              childImageBuilder: <Widget>(image, hash) {
                                return Center(
                                  child: Image.asset(
                                    image,
                                    fit: BoxFit.contain,
                                  ),
                                );
                              },
                              customOnTapItem: () {
                                ref.read(indexDocumentation.notifier).state = itemIndex;
                              },
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                  // TODO: RIGHT SIDE
                  Container(
                    key: widgetRightSideKey,
                    width: constraints.maxWidth / 2,
                    constraints: BoxConstraints(
                      minHeight: constraints.minHeight,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            minHeight: constraints.minHeight / 2,
                          ),
                          width: double.maxFinite,
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
                          relatedProjectSection(context, ref),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Widget relatedProjectSection(BuildContext context, WidgetRef ref){
    return Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
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
                  itemRelatedProject(context, ref, index),
              ],
            )
          ],
        )
    );
  }

  Widget itemRelatedProject(BuildContext context, WidgetRef ref, int index) {
    return HighlightedWidgetOnHover(
      onTapAction: () => context.goNamed(
        "details_creation",
        queryParameters: {
          "id": historyItemDocumentation.docRelatedProjects![index].projectId,
        },
        extra: "/history/details?index=$itemIndex&id=${historyItemData.historyItemDataId}",
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
                child: Container(
                  height: double.maxFinite,
                  width: 134,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: BlurHashImage(
                        historyItemDocumentation.docRelatedProjects![index].projectImagePathListHash[0],
                      ),
                    ),
                  ),
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
    );
  }
}


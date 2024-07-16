import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:me/Utility/style_util.dart';
import 'package:me/component/components.dart';
import 'package:me/provider/theme_provider.dart';
import 'package:me/values/values.dart';
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
                  style: TextStyle(fontFamily: 'Lato', fontSize: 20, color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61),
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

  // Color getRandomColor() {
  //   Random random = Random();
  //   return Color.fromARGB(
  //     255,
  //     random.nextInt(256),
  //     random.nextInt(256),
  //     random.nextInt(256),
  //   );
  // }

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

  Widget historyModeHorizontal(BoxConstraints constraints){
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
                      widget.historyItemData.historyDocumentations![widget.index].docImageList[0],
                      BoxFit.cover,
                    ),
                    Image.asset(
                      widget.historyItemData.historyDocumentations![widget.index].docImageList[0],
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
                          padding: const EdgeInsets.only(left: 20, top: 40, bottom: 40),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    widget.historyItemData.historyDocumentations![widget.index].docType,
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
                                    widget.historyItemData.historyDocumentations![widget.index].docTitle,
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 20,
                                      color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.historyItemData.historyDocumentations![widget.index].docDesc,
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
                      if (widget.historyItemData.historyDocumentations![widget.index].docRelatedProjects != null)
                        const Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: Center(
                              child: Text("Related Project Available!"),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget historyModeVertical(){
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: const Column(
        children: [
          Expanded(child: Text("hello world")),
          Text("hello world"),
          Text("hello world"),
        ],
      ),
    );
  }

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



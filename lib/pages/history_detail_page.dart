import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:me/values/values.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../component/spacing.dart';

class HistoryDetailPage extends StatefulWidget {
  final int index;
  final HistoryItemData historyData;

  const HistoryDetailPage({
    super.key,
    required this.index,
    required this.historyData,
  });

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  final historyItemController = ItemScrollController();

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

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
      height: 80,
      width: double.maxFinite,
      padding: contentCardPadding(context),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Center(
              child: InkWell(
                onTap: () => context.goNamed("history"),
                child: const Icon(
                  Icons.arrow_back,
                  size: 33,
                ),
              ),
            ),
          ),
          const Flexible(
            fit: FlexFit.tight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Documentation",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "This should be a very long title",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
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
          return Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            color: getRandomColor(),
            child: Center(
              child: Text("History Item Documentation ${index+1}"),
            ),
          );
        },
      ),
    );
  }
}



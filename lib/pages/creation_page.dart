import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:me/component/components.dart';
import 'package:me/controller/controller.dart';
import 'package:me/provider/theme_provider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../Utility/style_util.dart';

class CreationPage extends ConsumerStatefulWidget {
  const CreationPage({super.key});

  @override
  ConsumerState<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends ConsumerState<CreationPage> with SingleTickerProviderStateMixin {
  // TODO: ------ Declaration ------
  // --- General ---
  final StyleUtil _styleUtil = StyleUtil();
  final CreationController _creationController = CreationController();

  // --- Content Top Section ---
  // Dark/Light Theme Switch
  // Switch, animation
  bool isFromLeft = true, transitionIsActive = false;

  // --- Nav Section ---
  // Nav List Hover
  final List<bool> _navHover =
      List.generate(4, (index) => index == 1 ? true : false);
  // Controller for Sliver Nav
  static final ScrollController _navScrollController = ScrollController(initialScrollOffset: 1);
  // Sticky Nav Header Condition
  bool _navIsSticky = false;
  // Value Notifier Sticky Nav Header
  late ValueNotifier<bool> _navIsStickyNotifier = ValueNotifier(false);

  //  Other Hover
  bool themeSwitch = false;

  // --- Transition Nav ---
  // Rect Global Key
  static final GlobalKey<RectGetterState> _rectKeyWelcomePage =
      RectGetter.createGlobalKey();
  static final GlobalKey<RectGetterState> _rectKeyHistoryPage =
      RectGetter.createGlobalKey();
  static final GlobalKey<RectGetterState> _rectKeyFurtherPage =
      RectGetter.createGlobalKey();

  // Rect
  Rect? _rectWelcome;
  Rect? _rectHistory;
  Rect? _rectFurther;

  // --- Transition Nav Sticky ---
  // Rect Global Key
  static final GlobalKey<RectGetterState> _rectKeyWelcomePageSticky =
  RectGetter.createGlobalKey();
  static final GlobalKey<RectGetterState> _rectKeyHistoryPageSticky =
  RectGetter.createGlobalKey();
  static final GlobalKey<RectGetterState> _rectKeyFurtherPageSticky =
  RectGetter.createGlobalKey();

  // Rect
  Rect? _rectWelcomeSticky;
  Rect? _rectHistorySticky;
  Rect? _rectFurtherSticky;

  // Duration
  Duration animationDuration = const Duration(milliseconds: 300),
      afterAnimationDelay = const Duration(milliseconds: 300);

  // Creation Section Highlight Scroll Snap List
  final GlobalKey<ScrollSnapListState> _creationHighlightKey = GlobalKey();
  int _focusedIndexHighlight = 0;
  Timer? _timerContentHighlight;
  // Creations Map Data
  late Map<String, dynamic> _creationsData;
  // Declare keyString from Map Data
  late List<String> _keyCreationList;
  // Creations Stream
  late Stream _creationStream;
  // Show Creation when there is data available
  bool _creationIsShowed = false;

  // TODO: INIT STATE
  @override
  void initState() {
    // _navScrollController listener
    _navScrollController.addListener(() {
      final isVisible = _navScrollController.offset > MediaQuery.of(context).size.height;
      if (_navIsStickyNotifier.value != isVisible) {
        _navIsStickyNotifier.value = isVisible;
      }
    });

    // Creation Content Animation
    _timerContentHighlight = Timer.periodic(const Duration(seconds: 5), (_) {
      // setState(() {
        _creationHighlightKey.currentState!.focusToItem(++_focusedIndexHighlight);
      // });
    });
    super.initState();
  }

  // TODO: DISPOSE
  @override
  void dispose() {
    _timerContentHighlight?.cancel();
    super.dispose();
  }

  // TODO: ------ Function ------
  // --- Content Top Section
  // Switch Mode
  void switchWithTransition() async {
    isFromLeft = !isFromLeft;
    setState(() => transitionIsActive = !transitionIsActive);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
          animationDuration,
          () => setState(() {
                ref.read(isDarkMode.notifier).state =
                    !ref.read(isDarkMode); // SET DARK MODE HERE
              }));
      Future.delayed(
          animationDuration + afterAnimationDelay,
          () => setState(() {
                transitionIsActive = !transitionIsActive;
              }));
    });
  }

  // --- Transition Nav ---
  // Push Page With Transition (Normal Nav)
  void _pushNamedWithRectWelcome() async {
    setState(
        () => _rectWelcome = RectGetter.getRectFromKey(_rectKeyWelcomePage));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectWelcome =
          _rectWelcome!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay,
          () => context.goNamed("welcome"));
    });
  }

  void _pushNamedWithRectHistory() async {
    setState(
        () => _rectHistory = RectGetter.getRectFromKey(_rectKeyHistoryPage));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectHistory =
          _rectHistory!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay,
          () => context.goNamed("history"));
    });
  }

  void _pushNamedWithRectFurther() async {
    setState(
        () => _rectFurther = RectGetter.getRectFromKey(_rectKeyFurtherPage));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectFurther =
          _rectFurther!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay,
          () => context.goNamed("further"));
    });
  }

  // Push Page With Transition (Sticky Nav)
  void _pushNamedWithRectWelcomeSticky() async {
    setState(
            () => _rectWelcomeSticky = RectGetter.getRectFromKey(_rectKeyWelcomePageSticky));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectWelcomeSticky =
          _rectWelcomeSticky!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay,
              () => context.goNamed("welcome"));
    });
  }

  void _pushNamedWithRectHistorySticky() async {
    setState(
            () => _rectHistorySticky = RectGetter.getRectFromKey(_rectKeyHistoryPageSticky));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectHistorySticky =
          _rectHistorySticky!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay,
              () => context.goNamed("history"));
    });
  }

  void _pushNamedWithRectFurtherSticky() async {
    setState(
            () => _rectFurtherSticky = RectGetter.getRectFromKey(_rectKeyFurtherPageSticky));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectFurtherSticky =
          _rectFurtherSticky!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay,
              () => context.goNamed("further"));
    });
  }

  @override
  Widget build(BuildContext context) {
    final scrHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
          body: CustomScrollView(
            controller: _navScrollController,
            slivers: [
              SliverToBoxAdapter(
                child: _coverPageSection(scrHeight),
              ),
              MultiSliver(
                  pushPinnedChildren: true,
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: _navIsStickyNotifier,
                      builder: (context, isVisible, child) {
                        return SliverPinnedHeader(
                          child: _navTopSticky(isVisible),
                        );
                      }
                    ),
                    _creationPageSection(),
                  ]
              ),
            ],
          ),
        ),
        // Normal Nav
        _transitionToWelcomePage(_rectWelcome),
        _transitionToHistoryPage(_rectHistory),
        _transitionToFurtherPage(_rectFurther),
        // Sticky Nav
        _transitionToWelcomePage(_rectWelcomeSticky),
        _transitionToHistoryPage(_rectHistorySticky),
        _transitionToFurtherPage(_rectFurtherSticky),
        // Dark/Light mode
        _switchTapedWithTransition(),
      ],
    );
  }

  // TODO: ------ Page Section ------
  // ------ Cover ------
  Widget _coverPageSection(double screenHeight){
    return Container(
      color: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
      height: screenHeight,
      padding: mainCardPaddingWithBottomQuote(context),
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 1100,
              ),
              padding: contentCardPadding(context),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 55,
                    right: -5,
                    child: dashHorizontal(context, ref.watch(isDarkMode)),
                  ),
                  Positioned(
                    top: 50,
                    right: 0,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: dashVertical(context, ref.watch(isDarkMode)),
                    ),
                  ),
                  Column(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Container(
                          // color: Colors.red,
                          child: _topContent(),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          // color: Colors.green,
                          child: _content(),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Container(
                          // color: Colors.blue,
                          child: _navSection(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _quoteContentSection(),
        ],
      ),
    );
  }
  // ------ Nav Top Sticky ------
  Widget _navTopSticky(bool isVisible) {
    return Visibility(
      visible: true,
      maintainAnimation: true,
      maintainState: true,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        opacity: isVisible ? 1 : 0,
        child: Container(
          padding: contentCardPadding(context),
          decoration: BoxDecoration(
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
          width: MediaQuery.sizeOf(context).width,
          height: 80,
          child: _navSectionSticky(),
        ),
      ),
    );
  }
  // ------ Creation ------
  Widget _creationPageSection() {
    return Column(
      children: [
        _creationSection(),
      ],
    );
  }

  // TODO: ------ Other ------
  // ------ Content Body -----
  Widget _topContent() {
    return Stack(
      children: [
        AnimatedPositioned(
          // alignment: (themeSwitch) ? Alignment.bottomCenter : Alignment.center,
          top: (themeSwitch) ? 80 : 55,
          left: 0,
          right: 0,
          duration: const Duration(milliseconds: 150),
          child: AnimatedDefaultTextStyle(
            style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 12,
                color: (themeSwitch)
                    ? (ref.watch(isDarkMode))
                        ? _styleUtil.c_255
                        : _styleUtil.c_24
                    : Colors.transparent),
            duration: const Duration(milliseconds: 100),
            child: const Text(
              "change mode",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Align(
          // alignment: Alignment.center,
          child: InkWell(
            onHover: (value) {
              setState(() {
                themeSwitch = value;
              });
            },
            onTap: () {
              // Dark/Light Mode switch
              switchWithTransition();
            },
            child: Icon(
              (ref.watch(isDarkMode)) ? Icons.dark_mode : Icons.sunny,
              size: 32,
              color: (themeSwitch)
                  ? (ref.watch(isDarkMode))
                      ? _styleUtil.c_255
                      : _styleUtil.c_24
                  : _styleUtil.c_170,
            ),
          ),
        ),
      ],
    );
  }

  Widget _content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // height: 96,
          // color: Colors.blue,
          margin: const EdgeInsets.only(bottom: 15),
          width: double.maxFinite,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "MY CREATIONS",
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
          // height: 48,
          // color: Colors.amberAccent,
          margin: const EdgeInsets.only(bottom: 30),
          width: 694,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "As a student, I also made several small projects while adding my experience in making software. The following is software that I have made myself, both from my first program to my last program.",
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
    );
  }

  Widget _navSection() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: alignmentRowNav(context),
        children: [
          bottomHelper(context),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: RectGetter(
                  key: _rectKeyWelcomePage,
                  child: InkWell(
                    onHover: (value) => setState(() {
                      _navHover[0] = value;
                    }),
                    onTap: () {
                      _pushNamedWithRectWelcome();
                    },
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: (_navHover[0])
                            ? (ref.watch(isDarkMode))
                                ? _styleUtil.c_255
                                : _styleUtil.c_33
                            : _styleUtil.c_170,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  "Creation",
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 14,
                      color: (ref.watch(isDarkMode))
                          ? _styleUtil.c_255
                          : _styleUtil.c_33),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: RectGetter(
                  key: _rectKeyHistoryPage,
                  child: InkWell(
                    onHover: (value) => setState(() {
                      _navHover[2] = value;
                    }),
                    onTap: () {
                      _pushNamedWithRectHistory();
                    },
                    child: Text(
                      "History",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: (_navHover[2])
                            ? (ref.watch(isDarkMode))
                                ? _styleUtil.c_255
                                : _styleUtil.c_33
                            : _styleUtil.c_170,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: RectGetter(
                  key: _rectKeyFurtherPage,
                  child: InkWell(
                    onHover: (value) => setState(() {
                      _navHover[3] = value;
                    }),
                    onTap: () {
                      _pushNamedWithRectFurther();
                    },
                    child: Text(
                      "Further",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: (_navHover[3])
                            ? (ref.watch(isDarkMode))
                                ? _styleUtil.c_255
                                : _styleUtil.c_33
                            : _styleUtil.c_170,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navSectionSticky() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: alignmentRowNav(context),
        children: [
          bottomHelper(context),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: RectGetter(
                  key: _rectKeyWelcomePageSticky,
                  child: InkWell(
                    onHover: (value) => setState(() {
                      _navHover[0] = value;
                    }),
                    onTap: () {
                      _pushNamedWithRectWelcomeSticky();
                    },
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: (_navHover[0])
                            ? (ref.watch(isDarkMode))
                            ? _styleUtil.c_255
                            : _styleUtil.c_33
                            : _styleUtil.c_170,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  "Creation",
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 14,
                      color: (ref.watch(isDarkMode))
                          ? _styleUtil.c_255
                          : _styleUtil.c_33),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: RectGetter(
                  key: _rectKeyHistoryPageSticky,
                  child: InkWell(
                    onHover: (value) => setState(() {
                      _navHover[2] = value;
                    }),
                    onTap: () {
                      _pushNamedWithRectHistorySticky();
                    },
                    child: Text(
                      "History",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: (_navHover[2])
                            ? (ref.watch(isDarkMode))
                            ? _styleUtil.c_255
                            : _styleUtil.c_33
                            : _styleUtil.c_170,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: RectGetter(
                  key: _rectKeyFurtherPageSticky,
                  child: InkWell(
                    onHover: (value) => setState(() {
                      _navHover[3] = value;
                    }),
                    onTap: () {
                      _pushNamedWithRectFurtherSticky();
                    },
                    child: Text(
                      "Further",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: (_navHover[3])
                            ? (ref.watch(isDarkMode))
                            ? _styleUtil.c_255
                            : _styleUtil.c_33
                            : _styleUtil.c_170,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quoteContentSection() {
    return Container(
      padding: contentQuotePadding(context),
      height: contentQuoteHeight(context),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(visible: contentQuoteIconVisible(context), child: const SizedBox(width: 32, height: 36, child: Text(""))),
          Text("\"There is no such thing as 'garbage' for the small program you have created.\"", style: TextStyle(fontFamily: 'Lato', fontSize: 12, fontStyle: FontStyle.italic, color: _styleUtil.c_170),),
          Visibility(
            visible: contentQuoteIconVisible(context),
            child: SizedBox(
              width: 32,
              height: 36,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_downward_rounded, size: 18, color: _styleUtil.c_170,),
                  Text("scroll", style: TextStyle(fontFamily: 'Lato', fontSize: 12, color: _styleUtil.c_170),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _creationSection(){
    return Padding(
      padding:  mainCardPaddingWithBottomQuote(context),
      child: Container(
        constraints: const BoxConstraints(
            maxWidth: 1100
        ),
        margin: const EdgeInsets.symmetric(horizontal: 28),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 36),
              constraints: const BoxConstraints(
                maxWidth: 471,
              ),
              color: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
              child: Column(
                children: [
                  Container(padding: const EdgeInsets.only(bottom: 10), width: double.maxFinite, child: Text("M Y   P R O J E C T   P L A Y G R O U N D", style: TextStyle(fontFamily: 'Lato', fontSize: 20, color: (ref.watch(isDarkMode)) ? _styleUtil.c_255 : _styleUtil.c_61),)),
                  Text("A collection of small projects from my past that reflect my learning journey in the realm of coding.", style: TextStyle(fontFamily: 'Lato', fontSize: 16, color: (ref.watch(isDarkMode)) ? _styleUtil.c_170 : _styleUtil.c_61),),
                ],
              ),
            ),
            _creationsContentHighlight(),
            // _creationsContentRelatedProject(),
            // _creationsContentSteppingStone(),
            // _creationsContentTopProject(),
            Container(
              color: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
              height: 1200,
              child: const Center(child: Text("Oops, you caught me! \nI'm still working on this creation section")),
            ),
          ],
        ),
      ),
    );
  }

  Widget _creationsContentHighlight() {
    return FutureBuilder(
      future: _creationController.getCreationsMap(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          // Data berhasil diambil
          if (snapshot.hasData) {
            final creationsMap = snapshot.data!;
            return Container(
              color: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
              height: contentHighlightHeight(context),
              child: ScrollSnapList(
                key: _creationHighlightKey,
                duration: 600,
                curve: Easing.legacyDecelerate,
                margin: const EdgeInsets.symmetric(vertical: 10),
                onItemFocus: (int index) {
                  // setState(() {
                  _focusedIndexHighlight = index;
                  // });
                },
                onReachEnd: () {
                  // setState(() {
                  _focusedIndexHighlight = -1;
                  // });
                },
                itemSize: contentHighlightWidthListView(context),
                itemBuilder: (context, index) {
                  // Build item berdasarkan data creationsMap
                  return _buildListItem(context, index, _creationController.sortCreationsHighlight(creationsMap));
                },
                itemCount: 3,
                selectedItemAnchor: SelectedItemAnchor.MIDDLE,
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildListItem(BuildContext context, int index, Map<String, dynamic> creationsMap) {
    // Menggunakan data dari creationsMap untuk membangun item list
    final itemData = creationsMap.values.elementAt(index); // Ambil data pada indeks tertentu
    return Container(
      margin: contentHighlightListSpace(context),
      width: contentHighlightWidth(context),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 214, 216, 218),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.memory(fit: BoxFit.cover, base64.decode(itemData["project_image"])),
      ),
    );
  }

  // ------ Transition Page -----
  Widget _transitionToWelcomePage(Rect? rectWelcome) {
    if (rectWelcome == null) {
      return const SizedBox();
    }

    return AnimatedPositioned(
      duration: animationDuration,
      top: rectWelcome.top,
      right: MediaQuery.sizeOf(context).width - rectWelcome.right,
      bottom: MediaQuery.sizeOf(context).height - rectWelcome.bottom,
      left: rectWelcome.left,
      child: Container(
        decoration: BoxDecoration(
          color: (ref.watch(isDarkMode)) ? _styleUtil.c_61 : _styleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _transitionToHistoryPage(Rect? rectHistory) {
    if (rectHistory == null) {
      return const SizedBox();
    }

    return AnimatedPositioned(
      duration: animationDuration,
      top: rectHistory.top,
      right: MediaQuery.sizeOf(context).width - rectHistory.right,
      bottom: MediaQuery.sizeOf(context).height - rectHistory.bottom,
      left: rectHistory.left,
      child: Container(
        decoration: BoxDecoration(
          color: (ref.watch(isDarkMode)) ? _styleUtil.c_61 : _styleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _transitionToFurtherPage(Rect? rectFurther) {
    if (rectFurther == null) {
      return const SizedBox();
    }

    return AnimatedPositioned(
      duration: animationDuration,
      top: rectFurther.top,
      right: MediaQuery.sizeOf(context).width - rectFurther.right,
      bottom: MediaQuery.sizeOf(context).height - rectFurther.bottom,
      left: rectFurther.left,
      child: Container(
        decoration: BoxDecoration(
          color: (ref.watch(isDarkMode)) ? _styleUtil.c_61 : _styleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _switchTapedWithTransition() {
    return AnimatedPositioned(
      duration: animationDuration,
      top: 0,
      right: isFromLeft
          ? (!transitionIsActive)
              ? 1.3 * MediaQuery.sizeOf(context).width
              : 0
          : 0,
      bottom: 0,
      left: isFromLeft
          ? 0
          : (!transitionIsActive)
              ? 1.3 * MediaQuery.sizeOf(context).width
              : 0,
      child: AnimatedContainer(
        duration: animationDuration,
        decoration: BoxDecoration(
            color: (ref.watch(isDarkMode)) ? _styleUtil.c_61 : _styleUtil.c_170,
            shape: BoxShape.rectangle),
      ),
    );
  }
}

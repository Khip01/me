import 'dart:async';

import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:me/component/components.dart';
import 'package:me/helper/helper.dart';
import 'package:me/helper/init_app_theme.dart';
import 'package:me/provider/theme_provider.dart';
import 'package:me/utility/icon_util.dart';
import 'package:me/widget/animated_scroll_idle.dart';
import 'package:me/widget/highlighted_widget_on_hover.dart';
import 'package:me/widget/scroll_behavior.dart';
import 'package:me/widget/text_highlight_decider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../Utility/style_util.dart';
import '../values/values.dart';

class CreationPage extends ConsumerStatefulWidget {
  const CreationPage({super.key});

  @override
  ConsumerState<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends ConsumerState<CreationPage> with SingleTickerProviderStateMixin {
  // TODO: ------ Declaration ------
  // --- General ---
  final StyleUtil _styleUtil = StyleUtil();
  final IconUtil _iconUtil = IconUtil();

  late double scrHeight;

  // --- Content Top Section ---
  // Dark/Light Theme Switch
  // Switch, animation
  bool isFromLeft = true, transitionIsActive = false, ignoreTapping = false;

  // --- Nav Section ---
  // Controller for Sliver Nav
  static final ScrollController _navScrollController = ScrollController(initialScrollOffset: 1);
  // Value Notifier Sticky Nav Header
  late final ValueNotifier<bool> _navIsStickyNotifier = ValueNotifier(false);
  // Value Notifier Idle Scroll animation
  late final ValueNotifier<bool> _scrollIdleNotifier = ValueNotifier(true);

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
  // // Creations Map Data
  // Map<String, dynamic> _creationsData = <String, dynamic>{};
  // // Declare keyString from Map Data
  // late List<String> _keyCreationList;
  // // Creations Stream
  // late Stream _creationStream;
  // // Show Creation when there is data available
  // bool _creationIsShowed = false;


  // TODO: INIT STATE
  @override
  void initState() {
    // _navScrollController listener
    _navScrollController.addListener(() {
      // Sticky Nav Top
      final isVisible = _navScrollController.offset > scrHeight;
      if (_navIsStickyNotifier.value != isVisible) {
        _navIsStickyNotifier.value = isVisible;
      }
      // Animated Scroll Idle
      final isScrollIdleVisible = _navScrollController.offset <= 1;
      if(_scrollIdleNotifier.value != isScrollIdleVisible){
        _scrollIdleNotifier.value = isScrollIdleVisible;
      }
    });

    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   getDataCreationsJson();
    // });
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
    ignoreTapping = true; // IGNORE FOR ON TAPPING
    isFromLeft = !isFromLeft;
    setState(() => transitionIsActive = !transitionIsActive);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        animationDuration,
        // () => setState(() {
        //       ref.read(isDarkMode.notifier).state =
        //           !ref.read(isDarkMode); // SET DARK MODE HERE
        //     }),
      () {
        ref.read(isDarkModeProvider.notifier).value = !ref.read(isDarkModeProvider.notifier).value; // SET DARK MODE HERE
        changeCookieValue("${ref.read(isDarkModeProvider.notifier).value}"); // SET COOKIE VALUE HERE
      });
      Future.delayed(
          animationDuration + afterAnimationDelay,
          () => setState(() {
                transitionIsActive = !transitionIsActive;
              })).then((_) => setState(() {
                ignoreTapping = false;
              }));
    });
  }

  // --- Transition Nav ---
  // Push Page With Transition (Normal Nav)
  void _pushNamedWithRectWelcome() async {
    setState(() => _rectWelcome = RectGetter.getRectFromKey(_rectKeyWelcomePage));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectWelcome = _rectWelcome!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay, () => context.goNamed("welcome"));
    });
  }

  void _pushNamedWithRectHistory() async {
    setState(() => _rectHistory = RectGetter.getRectFromKey(_rectKeyHistoryPage));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectHistory = _rectHistory!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay, () => context.goNamed("history"));
    });
  }

  void _pushNamedWithRectFurther() async {
    setState(() => _rectFurther = RectGetter.getRectFromKey(_rectKeyFurtherPage));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectFurther = _rectFurther!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay, () => context.goNamed("further"));
    });
  }

  // Push Page With Transition (Sticky Nav)
  void _pushNamedWithRectWelcomeSticky() async {
    setState(() => _rectWelcomeSticky = RectGetter.getRectFromKey(_rectKeyWelcomePageSticky));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectWelcomeSticky = _rectWelcomeSticky!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay, () => context.goNamed("welcome"));
    });
  }

  void _pushNamedWithRectHistorySticky() async {
    setState(() => _rectHistorySticky = RectGetter.getRectFromKey(_rectKeyHistoryPageSticky));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectHistorySticky = _rectHistorySticky!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay, () => context.goNamed("history"));
    });
  }

  void _pushNamedWithRectFurtherSticky() async {
    setState(() => _rectFurtherSticky = RectGetter.getRectFromKey(_rectKeyFurtherPageSticky));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectFurtherSticky = _rectFurtherSticky!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay, () => context.goNamed("further"));
    });
  }

  // Creation Section Focus Animation When Highlight Section Already Show
  void doFocusScrollSnapListOnFocusHighlight() {
    // Mengecek apakah memang timernya sudah aktif
    if (_timerContentHighlight?.isActive ?? false) {
      return;
    }
    // Creation Content Animation
    _timerContentHighlight = Timer.periodic(const Duration(seconds: 5), (_) {
      // setState(() {
      _creationHighlightKey.currentState?.focusToItem(++_focusedIndexHighlight);
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    scrHeight = MediaQuery.sizeOf(context).height;
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Stack(
      children: [
        SelectionArea(
          child: Scaffold(
            backgroundColor: (isDarkMode) ? _styleUtil.c_33 : _styleUtil.c_255,
            body: CustomScrollView(
              controller: _navScrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      _coverPageSection(scrHeight),
                      // Scroll Idle Animation
                      ValueListenableBuilder<bool>(
                        valueListenable: _scrollIdleNotifier,
                        builder: (context, isVisible, child) {
                          return _scrollIldeSticky(isVisible);
                        },
                      ),
                    ],
                  ),
                ),
                MultiSliver(
                    pushPinnedChildren: true,
                    children: [
                      // Sticky Navbar
                      ValueListenableBuilder<bool>(
                        valueListenable: _navIsStickyNotifier,
                        builder: (context, isVisible, child) {
                          return SliverPinnedHeader(
                            child: _navTopSticky(isVisible),
                          );
                        }
                      ),
                      _creationPageSection(),
                      _footerTechnology(),
                    ]
                ),
              ],
            ),
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
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Container(
      color: (isDarkMode) ? _styleUtil.c_33 : _styleUtil.c_255,
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
                borderRadius: BorderRadius.circular(getIsMobileSize(context) ? 0 : 20),
                color: (isDarkMode)
                    ? _styleUtil.c_33
                    : _styleUtil.c_255,
                boxShadow: [
                  BoxShadow(
                    color: (isDarkMode)
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
                    child: dashHorizontal(context, isDarkMode),
                  ),
                  Positioned(
                    top: 50,
                    right: 0,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: dashVertical(context, isDarkMode),
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
  // ------ Scroll idle animation ------
  Widget _scrollIldeSticky(bool isVisible){
    bool isDarkMode = ref.watch(isDarkModeProvider).value;
    bool compactDeviceMode = getIsMobileSize(context) || getIsTabletSize(context) || getIsDesktopSmSize(context);

    return Visibility(
      visible: isVisible && compactDeviceMode,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height + 1,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedScrollIdle(
            animDuration: const Duration(milliseconds: 1000),
            mainIcon: Icons.keyboard_double_arrow_down_rounded,
            mainColor: isDarkMode ? _styleUtil.c_255 : _styleUtil.c_33,
            containerHeight: getIsMobileSize(context) ? 60 : null,
            iconHeight: getIsMobileSize(context) ? 25 : null,
          ),
        ),
      ),
    );
  }
  // ------ Nav Top Sticky ------
  Widget _navTopSticky(bool isVisible) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

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
            color: (isDarkMode)
                ? _styleUtil.c_33
                : _styleUtil.c_255,
            boxShadow: [
              BoxShadow(
                color: (isDarkMode)
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
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return StatefulBuilder(
      builder: (BuildContext context, setState){
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
                        ? (isDarkMode)
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
              child: IgnorePointer(
                ignoring: ignoreTapping,
                child: TextHighlightDecider(
                  isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                  colorStart: _styleUtil.c_170,
                  colorEnd: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_24,
                  actionDelay: const Duration(milliseconds: 100),
                  delayAfterAnimation: const Duration(milliseconds: 300),
                  additionalOnTapAction: () => switchWithTransition(),
                  additionalOnHoverAction: (value) => setState(() => themeSwitch = value),
                  builder: (Color color){
                    return Icon(
                      (isDarkMode) ? Icons.dark_mode : Icons.sunny,
                      size: 32,
                      color: color,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _content() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

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
                    (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_33,
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
                    (isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _navSection() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return SizedBox(
      width: double.maxFinite,
      child: FittingMobileSizeDecider(
        sizeIsMobile: getIsMobileSize(context),
        child: Row(
          mainAxisAlignment: alignmentRowNav(context),
          children: [
            bottomHelper(context),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: StatefulBuilder(
                    builder: (BuildContext context, setState){
                      return RectGetter(
                        key: _rectKeyWelcomePage,
                        child: TextHighlightDecider(
                          isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                          colorStart: _styleUtil.c_170,
                          colorEnd: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_33,
                          actionDelay: const Duration(milliseconds: 100),
                          additionalOnTapAction: () => _pushNamedWithRectWelcome(),
                          builder: (Color color){
                            return Text(
                              "Welcome",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                color: color,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    "Creation",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: (isDarkMode)
                            ? _styleUtil.c_255
                            : _styleUtil.c_33),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: StatefulBuilder(
                      builder: (BuildContext context, setState) {
                        return RectGetter(
                          key: _rectKeyHistoryPage,
                          child: TextHighlightDecider(
                            isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                            colorStart: _styleUtil.c_170,
                            colorEnd: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_33,
                            actionDelay: const Duration(milliseconds: 100),
                            additionalOnTapAction: () => _pushNamedWithRectHistory(),
                            builder: (Color color){
                              return Text(
                                "History",
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  color: color,
                                ),
                              );
                            },
                          ),
                        );
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: StatefulBuilder(
                    builder: (BuildContext context, setState){
                      return RectGetter(
                        key: _rectKeyFurtherPage,
                        child: TextHighlightDecider(
                          isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                          colorStart: _styleUtil.c_170,
                          colorEnd: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_33,
                          actionDelay: const Duration(milliseconds: 100),
                          additionalOnTapAction: () => _pushNamedWithRectFurther(),
                          builder: (Color color){
                            return Text(
                              "Further",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                color: color,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ), 
      ),
    );
  }

  Widget _navSectionSticky() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return SizedBox(
      width: double.maxFinite,
      child: FittingMobileSizeDecider(
        sizeIsMobile: getIsMobileSize(context),
        child: Row(
          mainAxisAlignment: alignmentRowNav(context),
          children: [
            bottomHelper(context),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: StatefulBuilder(
                    builder: (BuildContext context, setState){
                      return RectGetter(
                        key: _rectKeyWelcomePageSticky,
                        child: TextHighlightDecider(
                          isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                          colorStart: _styleUtil.c_170,
                          colorEnd: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_33,
                          actionDelay: const Duration(milliseconds: 100),
                          additionalOnTapAction: () => _pushNamedWithRectWelcomeSticky(),
                          builder: (Color color){
                            return Text(
                              "Welcome",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                color: color,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    "Creation",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: (isDarkMode)
                            ? _styleUtil.c_255
                            : _styleUtil.c_33),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: StatefulBuilder(
                    builder: (BuildContext context, setState){
                      return RectGetter(
                        key: _rectKeyHistoryPageSticky,
                        child: TextHighlightDecider(
                          isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                          colorStart: _styleUtil.c_170,
                          colorEnd: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_33,
                          actionDelay: const Duration(milliseconds: 100),
                          additionalOnTapAction: () => _pushNamedWithRectHistorySticky(),
                          builder: (Color color){
                            return Text(
                              "History",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                color: color,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: StatefulBuilder(
                    builder: (BuildContext context, setState){
                      return RectGetter(
                        key: _rectKeyFurtherPageSticky,
                        child: TextHighlightDecider(
                          isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                          colorStart: _styleUtil.c_170,
                          colorEnd: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_33,
                          actionDelay: const Duration(milliseconds: 100),
                          additionalOnTapAction: () => _pushNamedWithRectFurtherSticky(),
                          builder: (Color color){
                            return Text(
                              "Further",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                color: color,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ), 
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
            maxWidth: 1100,
        ),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CreationsHeaderTitle(
              titleText: "M Y   P R O J E C T   P L A Y G R O U N D",
              subTitleText: "A collection of small projects from my past that reflect my learning journey in the realm of coding.",
            ),
            // _creationCachedDecision(),
            // FutureBuilder(
            //   future: readJson(),
            //   builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
            //     if(snapshot.hasData){
            //       // if (snapshot.data!.isEmpty){
            //       //   return FutureBuilder(
            //       //     future: _creationController.getCreationsMap(),
            //       //     builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            //             // if(snapshot.hasData){
            //             //   Map<String, dynamic> resultMap = snapshot.data!;
            //               // setCreationMap(resultMap);
            //               // return _creationContent(resultMap);
            //             // } else if (snapshot.hasError) {
            //               // _timerContentHighlight?.cancel();
            //               // return Center(child: Text('Error: ${snapshot.error.toString()}'));
            //             // } else {
            //             //   return _creationContentShimmer();
            //             // }
            //           // }
            //         // );
            //       // } else {
            //         Map<String, dynamic> cachedMap = snapshot.data!;
            //         return _creationContent(cachedMap['creations']);
            //       // }
            //     } else if (snapshot.hasError) {
            //       _timerContentHighlight?.cancel();
            //       return Center(child: Text('Error: ${snapshot.error.toString()}'));
            //     } else {
            //       return _creationContentShimmer();
            //     }
            //   },
            // ),
            FutureBuilder(
                future: Future.delayed(const Duration(seconds: 3)).then((_) => _creationContent()),
                builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){
                  if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                    return  snapshot.data!;
                  }
                  return _creationContentShimmer();
                }
            ),
          ],
        ),
      ),
    );
  }

  Widget _creationContent() { // Parent
    return Column(
      children: [
        _creationsContentHighlight(),
        _creationsContentRelatedProject(),
        _creationsContentSteppingStone(),
      ],
    );
  }

  Widget _creationContentShimmer(){ // Parent
    return Column(
      children: [
        _creationContentHighlightShimmer(),
        _creationsContentRelatedProjectShimmer(),
        _creationsContentSteppingStoneShimmer(),
      ],
    );
  }


  // TODO: CREATIONS CONTENT HIGHLIGHT
  Widget _creationsContentHighlight() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    doFocusScrollSnapListOnFocusHighlight();
    return Container(
        color: (isDarkMode) ? _styleUtil.c_33 : _styleUtil.c_255,
        margin: EdgeInsets.only(bottom: (getIsMobileSize(context) ? 71 : 0)),
        height: contentHighlightHeight(context),
        child: ScrollConfiguration(
          behavior: ScrollWithDragBehavior(), // My Custom Behavior for Drag ListView
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
              return _buildListItemHighlight(context, index, Data.highlightedCreations);
            },
            itemCount: Data.highlightedCreations.length,
            selectedItemAnchor: SelectedItemAnchor.MIDDLE,
          ),
        ),
    );
  }

  Widget _buildListItemHighlight(BuildContext context, int index, List<ProjectItemData> highlightedCreationsData) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    // Menggunakan data dari creationsMap untuk membangun item list
    final itemData = highlightedCreationsData[index]; // Ambil data pada indeks tertentu
    final Image itemImage = Image.asset(
      itemData.projectImagePathCover,
      fit: BoxFit.cover,
    );
    final BlurHashImage itemImageHash = BlurHashImage(
      itemData.projectImagePathCoverHash,
    );
    final List<Image> itemImageProfile = List<Image>.generate(
      itemData.creatorPhotoProfilePath.length,
      (index) {
        return Image.asset(
          itemData.creatorPhotoProfilePath[index],
        );
      },
    );
    final List<BlurHashImage> itemImageProfileHash = List<BlurHashImage>.generate(
      itemData.creatorPhotoProfilePathHash.length,
      (index){
        return BlurHashImage(itemData.creatorPhotoProfilePathHash[index]);
      },
    );
    final Color colorShadeItemImage = isDarkMode ? const Color.fromARGB(0, 0, 0, 0) : const Color.fromARGB(0, 255, 255, 255);
    final DateTime itemDate = DateTime.fromMillisecondsSinceEpoch(itemData.timestampDateCreated);
    final DateFormat dateFormatter = DateFormat("MMM dd, yyyy");
    final String creatorsName = "${itemData.creatorName.first} ${(itemData.creatorName.length > 1) ? "and ${itemData.creatorName.length - 1} other" : ""}";

    return HighlightedWidgetOnHover(
      widgetHeight: contentHighlightHeight(context),
      widgetWidth: contentHighlightWidth(context),
      onTapAction: () => context.goNamed("details_creation", queryParameters: {
        "id": itemData.projectId,
      }),
      customBorderRadius: BorderRadius.circular(getIsMobileSize(context) ? 10 : 20),
      child: Container(
        margin: contentHighlightListSpace(context),
        width: contentHighlightWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 310 - (getIsMobileSize(context) ? 101 : getIsTabletSize(context) ? 51: 0),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: itemImageHash,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(getIsMobileSize(context) ? 10 : 20),
                  ),
                  child: itemImage,
                ),
                FutureBuilder<ColorScheme>(
                    future: getColorFromImage(Image.asset(itemData.projectImagePathCover).image, isDarkMode),
                    builder: (BuildContext context, AsyncSnapshot<ColorScheme> snapshot) {
                      if(snapshot.hasData){
                        return SizedBox(
                          height: 310 - (getIsMobileSize(context) ? 101 : getIsTabletSize(context) ? 51: 0),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 159,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(getIsMobileSize(context) ? 9 : 19),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [colorShadeItemImage, snapshot.data!.primaryContainer.withOpacity(.8), snapshot.data!.primaryContainer],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                                decoration: BoxDecoration(
                                  color: snapshot.data!.primaryContainer.withOpacity(.9),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(getIsMobileSize(context) ? 9 : 19),
                                    bottomRight: Radius.circular(getIsMobileSize(context) ? 9 : 19),
                                  ),
                                ),
                                child: Text(itemData.projectHighlightTopic ?? "", style: TextStyle(fontFamily: 'Lato', fontSize: 12, color: isDarkMode ? _styleUtil.c_255 : _styleUtil.c_33),),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: getIsMobileSize(context) ? 14 : 22),
                                  width: double.maxFinite,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(itemData.projectHighlightHeader ?? "", style: TextStyle(fontFamily: 'Lato', fontSize: 20 - (getIsMobileSize(context) ? 4 : 0), color: isDarkMode ? _styleUtil.c_255 : _styleUtil.c_24), textAlign: TextAlign.left,),
                                      Text(itemData.projectHighlightDescription ?? "", style: TextStyle(fontFamily: 'Lato', fontSize: 12, color: isDarkMode ? _styleUtil.c_255 : _styleUtil.c_24), textAlign: TextAlign.left,),
                                    ],
                                  ),
                                ),
                              ),
                            ]
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const SizedBox();
                      } else {
                        return Container(
                          height: 310 - (getIsMobileSize(context) ? 101 : getIsTabletSize(context) ? 51: 0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: itemImageHash,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(getIsMobileSize(context) ? 10 : 20),
                          ),
                          child: itemImage,
                        );
                      }
                    }
                ),
              ]
            ),
            Container(
              height: 28,
              margin: const EdgeInsets.only(top: 14),
              child: Text(itemData.projectName, style: TextStyle(fontFamily: 'Lato', fontSize: 16, color: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_61),),
            ),
            Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.only(top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(itemImageProfile.length, (index) {
                              return Align(
                                widthFactor: 0.5,
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    // color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: itemImageProfileHash[index],
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: const BorderRadius.all( Radius.circular(50.0)),
                                    border: Border.all(
                                      color: isDarkMode ? _styleUtil.c_24 : _styleUtil.c_255,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all( Radius.circular(50.0)),
                                    child: itemImageProfile[index],
                                  ),
                                ),
                              );
                            }, growable: true),
                          )
                        ),
                        Text(
                           creatorsName,
                          style: TextStyle(
                            fontFamily: 'Lato', fontSize: 12, color: (isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    dateFormatter.format(itemDate),
                    style: TextStyle(
                      fontFamily: 'Lato', fontSize: 12, color: _styleUtil.c_170,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _creationContentHighlightShimmer(){
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    _timerContentHighlight?.cancel();
    return Container(
      color: (isDarkMode) ? _styleUtil.c_33 : _styleUtil.c_255,
      height: contentHighlightHeight(context),
      margin: EdgeInsets.only(bottom: (getIsMobileSize(context) ? 71 : 0)),
      child: Shimmer.fromColors(
        baseColor: isDarkMode ? _styleUtil.c_61 : _styleUtil.c_170,
        highlightColor: isDarkMode ? _styleUtil.c_33 : _styleUtil.c_238,
        child: ScrollSnapList(
          key: _creationHighlightKey,
          margin: const EdgeInsets.symmetric(vertical: 10),
          itemSize: contentHighlightWidthListView(context),
          itemBuilder: (context, index) {
            return Container(
              margin: contentHighlightListSpace(context),
              width: contentHighlightWidth(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 310 - (getIsMobileSize(context) ? 101 :  getIsTabletSize(context) ? 51: 0),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 214, 216, 218),
                      borderRadius: BorderRadius.circular(getIsMobileSize(context) ? 10 : 20),
                    ),
                  ),
                  Container(
                    height: 24,
                    color: const Color.fromARGB(255, 214, 216, 218),
                    margin: const EdgeInsets.only(top: 14),
                  ),
                  Container(
                    height: 24,
                    margin: const EdgeInsets.only(top: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: const Color.fromARGB(255, 214, 216, 218),
                          width: 125,
                          height: 14,
                        ),
                        Container(
                          color: const Color.fromARGB(255, 214, 216, 218),
                          width: 125,
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: 3,
          selectedItemAnchor: SelectedItemAnchor.MIDDLE, onItemFocus: (_) {  },
        ),
      ),
    );
  }
  // TODO: END

  // TODO: CREATIONS CONTENT RELATED PROJECT
  Widget _creationsContentRelatedProject(){
    return Container(
      margin: EdgeInsets.only(top: 76 - (getIsMobileSize(context) ? 71 : 0), bottom: (getIsMobileSize(context) ? 71 : 0)),
      height: 338 - (getIsMobileSize(context) ? 71 : 0) + 79,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getIsMobileSize(context) ? 28 : 0,),
            child: CreationSubHeaderTitle(
              titleText: "Related Projects",
              subTitleText: "Find related portfolios featuring projects related to my area of expertise.",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 26),
            height: 286 - (getIsMobileSize(context) ? 71 : 0),
            child: ScrollConfiguration(
              behavior: ScrollWithDragBehavior(), // My Custom Behavior for Drag ListView
              child: ListView.builder(
                padding: EdgeInsets.only(left: getIsMobileSize(context) ? 28 : 0),
                scrollDirection: Axis.horizontal,
                itemCount: Data.relatedCreations.length,
                itemBuilder: (BuildContext context, int index){
                  return _buildListItemRelatedProject(context, index, Data.relatedCreations);
                }
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItemRelatedProject(BuildContext context, int index, List<ProjectItemData> relatedCreationsData) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    final ProjectItemData itemData = relatedCreationsData[index]; // Ambil data pada indeks tertentu
    final Image itemImage = Image.asset(
      itemData.projectImagePathCover,
      fit: BoxFit.cover,
    );
    final BlurHashImage itemImageHash = BlurHashImage(
      itemData.projectImagePathCoverHash,
    );
    final DateTime itemDate = DateTime.fromMillisecondsSinceEpoch(itemData.timestampDateCreated);
    final DateFormat dateFormatter = DateFormat("MMM dd, yyyy");

    return HighlightedWidgetOnHover(
      widgetHeight: 286 - (getIsMobileSize(context) ? 71 : 0),
      widgetWidth: 359 - (getIsMobileSize(context) ? 28 * 4 : 0),
      onTapAction: () => context.goNamed(
        "details_creation",
        queryParameters: {
          "id": itemData.projectId,
        },
      ),
      customBorderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(right: 28),
        // height: 286 - (getIsMobileSize(context) ? 71 : 0), check the Listview
        // builder to edit the height
        width: 359 - (getIsMobileSize(context) ? 28 * 4 : 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 227 - (getIsMobileSize(context) ? 71 : 0),
              width: double.maxFinite,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 214, 216, 218),
                image: DecorationImage(
                  image: itemImageHash,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: itemImage,
            ),
            SizedBox(
              height: 26,
              child: Text(itemData.projectName, style: TextStyle(fontFamily: 'Lato', fontSize: 16, color: isDarkMode ? _styleUtil.c_255 : _styleUtil.c_24),),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 16,
                  constraints: BoxConstraints(
                    maxWidth: 257 - (getIsMobileSize(context) ? 28 * 4 : 0),
                  ),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: itemData.projectCategories.length,
                    itemBuilder: (BuildContext context, int indexCategories){
                      return Text(
                        itemData.projectCategories[indexCategories],
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 12,
                            color: isDarkMode ?
                            _styleUtil.c_238 :
                            _styleUtil.c_61,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Text("  ·  ", style: TextStyle(fontFamily: 'Lato', fontSize: 12, color: isDarkMode ? _styleUtil.c_238 : _styleUtil.c_61),);
                    },
                  ),
                ),
                Text(
                  dateFormatter.format(itemDate),
                  style: TextStyle(
                    fontFamily: 'Lato', fontSize: 12, color: _styleUtil.c_170,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _creationsContentRelatedProjectShimmer(){
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Container(
      margin: EdgeInsets.only(top: 76 - (getIsMobileSize(context) ? 71 : 0), bottom: (getIsMobileSize(context) ? 71 : 0)),
      height: 338 - (getIsMobileSize(context) ? 71 : 0) + 79,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getIsMobileSize(context) ? 28 : 0,),
            child: CreationSubHeaderTitle(
              titleText: "Related Projects",
              subTitleText: "Find related portfolios featuring projects related to my area of expertise.",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 26),
            height: 286 - (getIsMobileSize(context) ? 71 : 0),
            child: Shimmer.fromColors(
              baseColor: isDarkMode ? _styleUtil.c_61 : _styleUtil.c_170,
              highlightColor: isDarkMode ? _styleUtil.c_33 : _styleUtil.c_238,
              child: ListView.builder(
                  padding: EdgeInsets.only(left: getIsMobileSize(context) ? 28 : 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      margin: const EdgeInsets.only(right: 28),
                      width: 359 - (getIsMobileSize(context) ? 28 * 4 : 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 227 - (getIsMobileSize(context) ? 71 : 0),
                            width: double.maxFinite,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 214, 216, 218),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            color: const Color.fromARGB(255, 214, 216, 218),
                            width: 150,
                            height: 22,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 16,
                                constraints: BoxConstraints(
                                  maxWidth: 257 - (getIsMobileSize(context) ? 28 * 4 : 0),
                                ),
                                child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (BuildContext context, int indexCategories){
                                      if(indexCategories < 3 - 1){
                                        return Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.symmetric(vertical: 4),
                                              color: const Color.fromARGB(255, 214, 216, 218),
                                              height: 12,
                                              width: 40,
                                            ),
                                            const Text("   "),
                                          ],
                                        );
                                      } else {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(vertical: 4),
                                          color: const Color.fromARGB(255, 214, 216, 218),
                                          height: 12,
                                          width: 40,
                                        );
                                      }
                                    }
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                color: const Color.fromARGB(255, 214, 216, 218),
                                width: 100 - (getIsMobileSize(context) ? 28 : 0),
                                height: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
  // TODO: END

  // TODO: CREATION CONTENT STEPPING STONE
  Widget _creationsContentSteppingStone(){
    return Container(
      margin: EdgeInsets.only(top: 76 - (getIsMobileSize(context) ? 71 : 0), bottom: 93 +  (getIsMobileSize(context) ? 71 : 0)),
      // height: 338 - (getIsMobileSize(context) ? 71 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getIsMobileSize(context) ? 28 : 0,),
            child: CreationSubHeaderTitle(
              titleText: "Another Project",
              subTitleText: "Check out the projects that showcase the diversity of my skills that I've explored.",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 26),
            height: 286 - (getIsMobileSize(context) ? 71 : 0),
            child: ScrollConfiguration(
              behavior: ScrollWithDragBehavior(),  // My Custom Behavior for Drag ListView
              child: ListView.builder(
                  padding: EdgeInsets.only(left: getIsMobileSize(context) ? 28 : 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: Data.anotherCreations.length,
                  itemBuilder: (BuildContext context, int index){
                    return _buildListItemSteppingStone(context, index, Data.anotherCreations);
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItemSteppingStone(BuildContext context, int index, List<ProjectItemData> anotherCreationsData) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    final ProjectItemData itemData = anotherCreationsData[index]; // Ambil data pada indeks tertentu
    final Image itemImage = Image.asset(
      itemData.projectImagePathCover,
      fit: BoxFit.cover,
    );
    final BlurHashImage itemImageHash = BlurHashImage(
      itemData.projectImagePathCoverHash,
    );
    final DateTime itemDate = DateTime.fromMillisecondsSinceEpoch(itemData.timestampDateCreated);
    final DateFormat dateFormatter = DateFormat("MMM dd, yyyy");

    return HighlightedWidgetOnHover(
      widgetHeight: 286 - (getIsMobileSize(context) ? 71 : 0),
      widgetWidth: 359 - (getIsMobileSize(context) ? 28 * 4 : 0),
      onTapAction: () => context.goNamed("details_creation", queryParameters: {
        "id": itemData.projectId,
      }),
      customBorderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(right: 28),
        // height: 286 - (getIsMobileSize(context) ? 71 : 0), check the Listview
        // builder to edit the height
        width: 359 - (getIsMobileSize(context) ? 28 * 4 : 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 227 - (getIsMobileSize(context) ? 71 : 0),
              width: double.maxFinite,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 214, 216, 218),
                image: DecorationImage(
                  image: itemImageHash,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: itemImage,
            ),
            SizedBox(
              height: 26,
              child: Text(itemData.projectName, style: TextStyle(fontFamily: 'Lato', fontSize: 16, color: isDarkMode ? _styleUtil.c_255 : _styleUtil.c_24),),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 16,
                  constraints: BoxConstraints(
                    maxWidth: 257 - (getIsMobileSize(context) ? 28 * 4 : 0),
                  ),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: itemData.projectCategories.length,
                    itemBuilder: (BuildContext context, int indexCategories){
                        return Text(itemData.projectCategories[indexCategories], style: TextStyle(fontFamily: 'Lato', fontSize: 12, color: isDarkMode ? _styleUtil.c_238 : _styleUtil.c_61),);
                    },
                    separatorBuilder: (context, index) {
                      return Text("  ·  ", style: TextStyle(fontFamily: 'Lato', fontSize: 12, color: isDarkMode ? _styleUtil.c_238 : _styleUtil.c_61),);
                    },
                  ),
                ),
                Text(
                  dateFormatter.format(itemDate),
                  style: TextStyle(
                    fontFamily: 'Lato', fontSize: 12, color: _styleUtil.c_170,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _creationsContentSteppingStoneShimmer(){
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Container(
      margin: EdgeInsets.only(top: 76 - (getIsMobileSize(context) ? 71 : 0), bottom: 93 + (getIsMobileSize(context) ? 71 : 0)),
      // height: 338 - (getIsMobileSize(context) ? 71 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getIsMobileSize(context) ? 28 : 0,),
            child: CreationSubHeaderTitle(
              titleText: "Another Project",
              subTitleText: "Check out the projects that showcase the diversity of my skills that I've explored.",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 26),
            height: 286 - (getIsMobileSize(context) ? 71 : 0),
            child: Shimmer.fromColors(
              baseColor: isDarkMode ? _styleUtil.c_61 : _styleUtil.c_170,
              highlightColor: isDarkMode ? _styleUtil.c_33 : _styleUtil.c_238,
              child: ListView.builder(
                  padding: EdgeInsets.only(left: getIsMobileSize(context) ? 28 : 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      margin: const EdgeInsets.only(right: 28),
                      width: 359 - (getIsMobileSize(context) ? 28 * 4 : 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 227 - (getIsMobileSize(context) ? 71 : 0),
                            width: double.maxFinite,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 214, 216, 218),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            color: const Color.fromARGB(255, 214, 216, 218),
                            width: 150,
                            height: 22,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 16,
                                constraints: BoxConstraints(
                                  maxWidth: 257 - (getIsMobileSize(context) ? 28 * 4 : 0),
                                ),
                                child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (BuildContext context, int indexCategories){
                                      if(indexCategories < 3 - 1){
                                        return Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.symmetric(vertical: 4),
                                              color: const Color.fromARGB(255, 214, 216, 218),
                                              height: 12,
                                              width: 40,
                                            ),
                                            const Text("   "),
                                          ],
                                        );
                                      } else {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(vertical: 4),
                                          color: const Color.fromARGB(255, 214, 216, 218),
                                          height: 12,
                                          width: 40,
                                        );
                                      }
                                    }
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                color: const Color.fromARGB(255, 214, 216, 218),
                                width: 100 - (getIsMobileSize(context) ? 28 : 0),
                                height: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
  // TODO: END

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

  // ------ Transition Page -----
  Widget _transitionToWelcomePage(Rect? rectWelcome) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

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
          color: (isDarkMode) ? _styleUtil.c_61 : _styleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _transitionToHistoryPage(Rect? rectHistory) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

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
          color: (isDarkMode) ? _styleUtil.c_61 : _styleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _transitionToFurtherPage(Rect? rectFurther) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

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
          color: (isDarkMode) ? _styleUtil.c_61 : _styleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _switchTapedWithTransition() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

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
            color: (isDarkMode) ? _styleUtil.c_61 : _styleUtil.c_170,
            shape: BoxShape.rectangle),
      ),
    );
  }
}

class CreationsHeaderTitle extends ConsumerWidget {
  final String titleText;
  final String subTitleText;

  CreationsHeaderTitle({
    super.key,
    required this.titleText,
    required this.subTitleText,
  });

  // general
  final StyleUtil _styleUtil = StyleUtil();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Container(
      padding: const EdgeInsets.only(bottom: 36),
      margin: EdgeInsets.symmetric(horizontal: getIsMobileSize(context) ? 28 : 0,),
      constraints: const BoxConstraints(
        maxWidth: 471,
      ),
      color: (isDarkMode) ? _styleUtil.c_33 : _styleUtil.c_255,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            width: 359,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                titleText,
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 20,
                    color: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_61
                ),
              ),
            ),
          ),
          Text(subTitleText, style: TextStyle(fontFamily: 'Lato', fontSize: 16, color: (isDarkMode) ? _styleUtil.c_170 : _styleUtil.c_61),),
        ],
      ),
    );
  }
}

class CreationSubHeaderTitle extends ConsumerWidget {
  final String titleText;
  final String subTitleText;

  CreationSubHeaderTitle({
    super.key,
    required this.titleText,
    required this.subTitleText,
  });

  final StyleUtil _styleUtil = StyleUtil();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 471
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              height: 26,
              child: Text(titleText, style: TextStyle(fontFamily: 'Lato', fontSize: 20, color: isDarkMode ? _styleUtil.c_238 : _styleUtil.c_24),),
            ),
          ),
          Text(subTitleText, style: TextStyle(fontFamily: 'Lato', fontSize: 16, color: (isDarkMode) ? _styleUtil.c_170 : _styleUtil.c_61),),
        ],
      ),
    );
  }
}



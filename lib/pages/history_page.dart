import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:me/component/components.dart';
import 'package:me/provider/theme_provider.dart';
import 'package:me/utility/icon_util.dart';
import 'package:me/values/values.dart';
import 'package:me/widget/highlighted_widget_on_hover.dart';
import 'package:me/widget/scroll_progress_indicator.dart';
import 'package:me/widget/text_highlight_decider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../utility/style_util.dart';
import '../helper/init_app_theme.dart';
import '../widget/animated_scroll_idle.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  // TODO: ------ Declaration ------
  late double scrHeight;

  // --- Content Top Section ---
  // Dark/Light Theme Switch
  // Switch, animation
  bool _isFromLeft = true, _transitionIsActive = false, ignoreTapping = false;

  // --- Nav Section ---
  // Controller for Sliver Nav
  static final ScrollController _navScrollController =
      ScrollController(initialScrollOffset: 1);

  // Value Notifier Sticky Nav Header
  final ValueNotifier<bool> _navIsStickyNotifier = ValueNotifier(false);

  // Value Notifier Idle Scroll animation
  final ValueNotifier<bool> _scrollIdleNotifier = ValueNotifier(true);

  // Value Notifier Scroll Progress Indicator
  final ValueNotifier<double> _scrollProgressNotifier = ValueNotifier(0.01);

  //  Other Hover
  bool themeSwitch = false;

  // --- Transition Nav ---
  // Rect Global Key
  static final GlobalKey<RectGetterState> _rectKeyWelcomePage =
      RectGetter.createGlobalKey();
  static final GlobalKey<RectGetterState> _rectKeyCreationPage =
      RectGetter.createGlobalKey();
  static final GlobalKey<RectGetterState> _rectKeyFurtherPage =
      RectGetter.createGlobalKey();

  // Rect
  Rect? _rectWelcome;
  Rect? _rectCreation;
  Rect? _rectFurther;

  // --- Transition Nav Sticky ---
  // Rect Global Key
  static final GlobalKey<RectGetterState> _rectKeyWelcomePageSticky =
      RectGetter.createGlobalKey();
  static final GlobalKey<RectGetterState> _rectKeyCreationPageSticky =
      RectGetter.createGlobalKey();
  static final GlobalKey<RectGetterState> _rectKeyFurtherPageSticky =
      RectGetter.createGlobalKey();

  // Rect
  Rect? _rectWelcomeSticky;
  Rect? _rectCreationSticky;
  Rect? _rectFurtherSticky;

  // Duration constants for page transitions
  static const Duration _animationDuration = Duration(milliseconds: 300);
  static const Duration _afterAnimationDelay = Duration(milliseconds: 300);

  // TODO: INIT STATE
  @override
  void initState() {
    _navScrollController.addListener(() {
      // Sticky Nav Top
      final isVisible = _navScrollController.offset > scrHeight;
      if (_navIsStickyNotifier.value != isVisible) {
        _navIsStickyNotifier.value = isVisible;
      }
      // Animated Scroll Idle
      final isScrollIdleVisible = _navScrollController.offset <= 1;
      if (_scrollIdleNotifier.value != isScrollIdleVisible) {
        _scrollIdleNotifier.value = isScrollIdleVisible;
      }
      // Scroll Progress Indicator
      if (_navScrollController.hasClients &&
          _navScrollController.position.maxScrollExtent > 0) {
        final progress = (_navScrollController.offset /
                _navScrollController.position.maxScrollExtent)
            .clamp(0.01, 1.0);
        if (_scrollProgressNotifier.value != progress) {
          _scrollProgressNotifier.value = progress;
        }
      }
    });

    super.initState();
  }

  // TODO: ------ Function ------
  // --- Content Top Section
  // Switch Mode
  void switchWithTransition() async {
    ignoreTapping = true; // IGNORE FOR ON TAPPING
    _isFromLeft = !_isFromLeft;
    setState(() => _transitionIsActive = !_transitionIsActive);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(_animationDuration, () {
        ref.read(isDarkModeProvider.notifier).value =
            !ref.read(isDarkModeProvider).value; // SET DARK MODE HERE
        changeCookieValue(
            "${ref.read(isDarkModeProvider.notifier).value}"); // SET COOKIE VALUE HERE
      });
      Future.delayed(
          _animationDuration + _afterAnimationDelay,
          () => setState(() {
                _transitionIsActive = !_transitionIsActive;
              })).then((_) => setState(
            () {
              ignoreTapping = false;
            },
          ));
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
      Future.delayed(_animationDuration + _afterAnimationDelay,
          () => context.goNamed("welcome"));
    });
  }

  void _pushNamedWithRectCreation() async {
    setState(
        () => _rectCreation = RectGetter.getRectFromKey(_rectKeyCreationPage));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectCreation =
          _rectCreation!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(_animationDuration + _afterAnimationDelay,
          () => context.goNamed("creation"));
    });
  }

  void _pushNamedWithRectFurther() async {
    setState(
        () => _rectFurther = RectGetter.getRectFromKey(_rectKeyFurtherPage));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectFurther =
          _rectFurther!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(_animationDuration + _afterAnimationDelay,
          () => context.goNamed("further"));
    });
  }

  // Push Page With Transition (Sticky Nav)
  void _pushNamedWithRectWelcomeSticky() async {
    setState(() => _rectWelcomeSticky =
        RectGetter.getRectFromKey(_rectKeyWelcomePageSticky));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectWelcomeSticky = _rectWelcomeSticky!
          .inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(_animationDuration + _afterAnimationDelay,
          () => context.goNamed("welcome"));
    });
  }

  void _pushNamedWithRectCreationSticky() async {
    setState(() => _rectCreationSticky =
        RectGetter.getRectFromKey(_rectKeyCreationPageSticky));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectCreationSticky = _rectCreationSticky!
          .inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(_animationDuration + _afterAnimationDelay,
          () => context.goNamed("creation"));
    });
  }

  void _pushNamedWithRectFurtherSticky() async {
    setState(() => _rectFurtherSticky =
        RectGetter.getRectFromKey(_rectKeyFurtherPageSticky));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectFurtherSticky = _rectFurtherSticky!
          .inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(_animationDuration + _afterAnimationDelay,
          () => context.goNamed("further"));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;
    scrHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        SelectionArea(
          child: Scaffold(
            backgroundColor: (isDarkMode) ? StyleUtil.c_33 : StyleUtil.c_255,
            body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: CustomScrollView(
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
                  MultiSliver(pushPinnedChildren: true, children: [
                    // Sticky Navbar
                    ValueListenableBuilder<bool>(
                      valueListenable: _navIsStickyNotifier,
                      builder: (context, isVisible, child) {
                        return SliverPinnedHeader(
                          child: _navTopSticky(isVisible),
                        );
                      },
                    ),
                    _historyPageSection(),
                    _footerTechnology(),
                  ]),
                ],
              ),
            ),
          ),
        ),
        // Scroll Progress Indicator
        ScrollProgressIndicator(
          scrollController: _navScrollController,
          progressNotifier: _scrollProgressNotifier,
          isMobile: getIsMobileSize(context),
          isDarkMode: isDarkMode,
        ),
        // Normal Nav
        _transitionToWelcomePage(_rectWelcome),
        _transitionToCreationPage(_rectCreation),
        _transitionToFurtherPage(_rectFurther),
        // Sticky Nav
        _transitionToWelcomePage(_rectWelcomeSticky),
        _transitionToCreationPage(_rectCreationSticky),
        _transitionToFurtherPage(_rectFurtherSticky),
        // Dark/Light mode
        _switchTapedWithTransition(),
      ],
    );
  }

  // TODO: ------ Page Section ------
  // ------ Cover ------
  Widget _coverPageSection(double screenHeight) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Container(
      color: (isDarkMode) ? StyleUtil.c_33 : StyleUtil.c_255,
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
              padding: getIsMobileSize(context)
                  ? contentCardPadding(context)
                  : EdgeInsets.zero,
              // clipBehavior: Clip.antiAlias,
              // decoration: BoxDecoration(
              //   borderRadius:
              //       BorderRadius.circular(getIsMobileSize(context) ? 0 : 20),
              //   color: (isDarkMode) ? StyleUtil.c_33 : StyleUtil.c_255,
              //   boxShadow: [
              //     BoxShadow(
              //       color: (isDarkMode)
              //           ? const Color.fromARGB(255, 61, 61, 61)
              //           : const Color.fromARGB(255, 203, 203, 203),
              //       blurRadius: 80.0,
              //     ),
              //   ],
              // ),
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
  Widget _scrollIldeSticky(bool isVisible) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;
    bool compactDeviceMode = getIsMobileSize(context) ||
        getIsTabletSize(context) ||
        getIsDesktopSmSize(context);

    return Visibility(
      visible: isVisible && compactDeviceMode,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height + 1,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedScrollIdle(
            animDuration: const Duration(milliseconds: 1000),
            mainIcon: Icons.keyboard_double_arrow_down_rounded,
            mainColor: isDarkMode ? StyleUtil.c_255 : StyleUtil.c_33,
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

    return AbsorbPointer(
      absorbing: !isVisible,
      child: Visibility(
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
              color: (isDarkMode) ? StyleUtil.c_33 : StyleUtil.c_255,
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
      ),
    );
  }

  // ------ Creation ------
  Widget _historyPageSection() {
    return Column(
      children: [
        _historySection(),
      ],
    );
  }

  // TODO: ------ Other ------
  // ------ Content Body -----
  Widget _topContent() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Stack(
      children: [
        Positioned.fill(
          child: LayoutBuilder(builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: constraints.maxHeight / 2 - 40,
                top: constraints.maxHeight / 2,
              ),
              child: AnimatedAlign(
                alignment:
                    (themeSwitch) ? Alignment.bottomCenter : Alignment.center,
                curve: Curves.easeOutCirc,
                duration: const Duration(milliseconds: 150),
                child: AnimatedDefaultTextStyle(
                  style: StyleUtil.text_xs_Regular.copyWith(
                    color: (themeSwitch)
                        ? (isDarkMode)
                            ? StyleUtil.c_255
                            : StyleUtil.c_24
                        : Colors.transparent,
                  ),
                  duration: const Duration(milliseconds: 100),
                  child: Text(
                    isDarkMode
                        ? "Craving some sunlight? ☀️😎"
                        : "Eyes hurting yet? 😂",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }),
        ),
        Align(
          // alignment: Alignment.center,
          child: IgnorePointer(
            ignoring: ignoreTapping,
            child: TextHighlightDecider(
              isCompactMode:
                  getIsMobileSize(context) || getIsTabletSize(context),
              colorStart: StyleUtil.c_170,
              colorEnd: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_24,
              actionDelay: const Duration(milliseconds: 100),
              delayAfterAnimation: const Duration(milliseconds: 300),
              additionalOnTapAction: () => switchWithTransition(),
              additionalOnHoverAction: (value) =>
                  setState(() => themeSwitch = value),
              builder: (Color color) {
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
              "MY HISTORY",
              style: StyleUtil.text_2xl_Bold.copyWith(
                color: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
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
              "Discover a brief overview of my recent experiences, offering a glimpse into the journey I've traveled. Explore the key moments that have shaped my path and accomplishments.",
              style: StyleUtil.text_Base_Medium.copyWith(
                color: (isDarkMode) ? StyleUtil.c_238 : StyleUtil.c_61,
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
    double horPadding = 16, verPadding = 12;

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
                RectGetter(
                  key: _rectKeyWelcomePage,
                  child: TextHighlightDecider(
                    padding: EdgeInsets.symmetric(
                      horizontal: horPadding,
                      vertical: verPadding,
                    ),
                    isCompactMode:
                        getIsMobileSize(context) || getIsTabletSize(context),
                    colorStart: StyleUtil.c_170,
                    colorEnd: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
                    actionDelay: const Duration(milliseconds: 100),
                    additionalOnTapAction: () => _pushNamedWithRectWelcome(),
                    builder: (Color color) {
                      return Text(
                        "Welcome",
                        style: StyleUtil.text_small_Regular.copyWith(
                          color: color,
                        ),
                      );
                    },
                  ),
                ),
                RectGetter(
                  key: _rectKeyCreationPage,
                  child: TextHighlightDecider(
                    padding: EdgeInsets.symmetric(
                      horizontal: horPadding,
                      vertical: verPadding,
                    ),
                    isCompactMode:
                        getIsMobileSize(context) || getIsTabletSize(context),
                    colorStart: StyleUtil.c_170,
                    colorEnd: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
                    actionDelay: const Duration(milliseconds: 100),
                    additionalOnTapAction: () => _pushNamedWithRectCreation(),
                    builder: (Color color) {
                      return Text(
                        "Creation",
                        style: StyleUtil.text_small_Regular.copyWith(
                          color: color,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horPadding,
                    vertical: verPadding,
                  ),
                  child: Text(
                    "History",
                    style: StyleUtil.text_small_Regular.copyWith(
                      color: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
                    ),
                  ),
                ),
                RectGetter(
                  key: _rectKeyFurtherPage,
                  child: TextHighlightDecider(
                    padding: EdgeInsets.symmetric(
                      horizontal: horPadding,
                      vertical: verPadding,
                    ),
                    isCompactMode:
                        getIsMobileSize(context) || getIsTabletSize(context),
                    colorStart: StyleUtil.c_170,
                    colorEnd: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
                    actionDelay: const Duration(milliseconds: 100),
                    additionalOnTapAction: () => _pushNamedWithRectFurther(),
                    builder: (Color color) {
                      return Text(
                        "Further",
                        style: StyleUtil.text_small_Regular.copyWith(
                          color: color,
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
    double horPadding = 16, verPadding = 12;

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
                RectGetter(
                  key: _rectKeyWelcomePageSticky,
                  child: TextHighlightDecider(
                    padding: EdgeInsets.symmetric(
                      horizontal: horPadding,
                      vertical: verPadding,
                    ),
                    isCompactMode:
                        getIsMobileSize(context) || getIsTabletSize(context),
                    colorStart: StyleUtil.c_170,
                    colorEnd: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
                    actionDelay: const Duration(milliseconds: 100),
                    additionalOnTapAction: () =>
                        _pushNamedWithRectWelcomeSticky(),
                    builder: (Color color) {
                      return Text(
                        "Welcome",
                        style: StyleUtil.text_small_Regular.copyWith(
                          color: color,
                        ),
                      );
                    },
                  ),
                ),
                RectGetter(
                  key: _rectKeyCreationPageSticky,
                  child: TextHighlightDecider(
                    padding: EdgeInsets.symmetric(
                      horizontal: horPadding,
                      vertical: verPadding,
                    ),
                    isCompactMode:
                        getIsMobileSize(context) || getIsTabletSize(context),
                    colorStart: StyleUtil.c_170,
                    colorEnd: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
                    actionDelay: const Duration(milliseconds: 100),
                    additionalOnTapAction: () =>
                        _pushNamedWithRectCreationSticky(),
                    builder: (Color color) {
                      return Text(
                        "Creation",
                        style: StyleUtil.text_small_Regular.copyWith(
                          color: color,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horPadding,
                    vertical: verPadding,
                  ),
                  child: Text(
                    "History",
                    style: StyleUtil.text_small_Regular.copyWith(
                      color: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
                    ),
                  ),
                ),
                RectGetter(
                  key: _rectKeyFurtherPageSticky,
                  child: TextHighlightDecider(
                    padding: EdgeInsets.symmetric(
                      horizontal: horPadding,
                      vertical: verPadding,
                    ),
                    isCompactMode:
                        getIsMobileSize(context) || getIsTabletSize(context),
                    colorStart: StyleUtil.c_170,
                    colorEnd: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
                    actionDelay: const Duration(milliseconds: 100),
                    additionalOnTapAction: () =>
                        _pushNamedWithRectFurtherSticky(),
                    builder: (Color color) {
                      return Text(
                        "Further",
                        style: StyleUtil.text_small_Regular.copyWith(
                          color: color,
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
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Container(
      alignment: Alignment.topCenter,
      padding: contentQuotePadding(context),
      height: contentQuoteHeight(context),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
              visible: contentQuoteIconVisible(context),
              child: const SizedBox(width: 32, height: 36, child: Text(""))),
          Text(
            "\"Turn coding into an experience, not just a lesson.\"",
            style: StyleUtil.text_xs_Regular_Italic
                .copyWith(color: StyleUtil.c_170),
          ),
          Visibility(
            visible: contentQuoteIconVisible(context),
            child: SizedBox(
              width: 32,
              height: 36,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_downward_rounded,
                    size: 18,
                    color: isDarkMode ? StyleUtil.c_255 : StyleUtil.c_61,
                  ),
                  Text(
                    "scroll",
                    style: StyleUtil.text_xs_Regular.copyWith(
                        color: isDarkMode ? StyleUtil.c_238 : StyleUtil.c_61),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _historySection() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Padding(
      padding: mainCardPaddingWithBottomQuote(context),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 1100,
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
              color: (isDarkMode) ? StyleUtil.c_33 : StyleUtil.c_255,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    width: 317,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        "U N C O V E R I N G   T H E   P A S T",
                        style: StyleUtil.text_lg_Regular.copyWith(
                          color:
                              (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_61,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "This section narrates the story of my educational and professional journey, tracing the footsteps of learning and self-development.",
                    style: StyleUtil.text_Base_Regular.copyWith(
                        color: (isDarkMode) ? StyleUtil.c_170 : StyleUtil.c_61),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 93 - 60, top: 60),
              width: double.maxFinite,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: SIDE LEFT
                  Flexible(
                    flex: 15,
                    child: Column(
                      children: [
                        HistoryType(
                          titleType: "WORK",
                          historyData: History.historyDataWork,
                        ),
                        HistoryType(
                          titleType: "EDUCATION",
                          historyData: History.historyDataEdu,
                        ),
                      ],
                    ),
                  ),
                  // TODO: SPACER
                  const Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: SizedBox(),
                  ),
                  // TODO: SIDE RIGHT
                  Visibility(
                    visible: contentHistoryVisible(context),
                    child: Flexible(
                      flex: 7,
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            HistoryScoopeType(
                              titleHistoryScoope: "Work",
                              historyData: History.historyDataWork,
                            ),
                            HistoryScoopeType(
                              titleHistoryScoope: "Education",
                              historyData: History.historyDataEdu,
                            ),
                          ],
                        ),
                      ),
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

  Widget _footerTechnology() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Center(
        child: SizedBox(
          width: 125,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Built with  ",
                style: StyleUtil.text_xs_Regular.copyWith(
                  color: StyleUtil.c_170,
                ),
              ),
              Tooltip(
                message: "Flutter Framework",
                child: Image.asset(IconUtil.flutterLogo),
              ),
              // Text(
              //   "  and  ",
              //   style: StyleUtil.text_xs_Regular.copyWith(
              //     color: StyleUtil.c_170,
              //   ),
              // ),
              // Tooltip(
              //     message: "Firebase RTDB",
              //     child: Image.asset(IconUtil.firebaseLogoNew)),
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
      duration: _animationDuration,
      top: rectWelcome.top,
      right: MediaQuery.sizeOf(context).width - rectWelcome.right,
      bottom: MediaQuery.sizeOf(context).height - rectWelcome.bottom,
      left: rectWelcome.left,
      child: Container(
        decoration: BoxDecoration(
          color: (isDarkMode) ? StyleUtil.c_61 : StyleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _transitionToCreationPage(Rect? rectHistory) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    if (rectHistory == null) {
      return const SizedBox();
    }

    return AnimatedPositioned(
      duration: _animationDuration,
      top: rectHistory.top,
      right: MediaQuery.sizeOf(context).width - rectHistory.right,
      bottom: MediaQuery.sizeOf(context).height - rectHistory.bottom,
      left: rectHistory.left,
      child: Container(
        decoration: BoxDecoration(
          color: (isDarkMode) ? StyleUtil.c_61 : StyleUtil.c_170,
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
      duration: _animationDuration,
      top: rectFurther.top,
      right: MediaQuery.sizeOf(context).width - rectFurther.right,
      bottom: MediaQuery.sizeOf(context).height - rectFurther.bottom,
      left: rectFurther.left,
      child: Container(
        decoration: BoxDecoration(
          color: (isDarkMode) ? StyleUtil.c_61 : StyleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _switchTapedWithTransition() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return AnimatedPositioned(
      duration: _animationDuration,
      top: 0,
      right: _isFromLeft
          ? (!_transitionIsActive)
              ? 1.3 * MediaQuery.sizeOf(context).width
              : 0
          : 0,
      bottom: 0,
      left: _isFromLeft
          ? 0
          : (!_transitionIsActive)
              ? 1.3 * MediaQuery.sizeOf(context).width
              : 0,
      child: AnimatedContainer(
        duration: _animationDuration,
        decoration: BoxDecoration(
            color: (isDarkMode) ? StyleUtil.c_61 : StyleUtil.c_170,
            shape: BoxShape.rectangle),
      ),
    );
  }
}

class HistoryType extends ConsumerWidget {
  final String titleType;
  final List<HistoryItemData> historyData;

  const HistoryType({
    super.key,
    required this.titleType,
    required this.historyData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleType,
            style: StyleUtil.text_small_Bold.copyWith(
              color: isDarkMode ? StyleUtil.c_255 : StyleUtil.c_61,
            ),
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: historyData.length,
              itemBuilder: (context, index) {
                return HistoryPath(
                  historyItemData: historyData[index],
                );
              }),
        ],
      ),
    );
  }
}

class HistoryPath extends ConsumerStatefulWidget {
  final HistoryItemData historyItemData;

  const HistoryPath({
    super.key,
    required this.historyItemData,
  });

  @override
  ConsumerState<HistoryPath> createState() => _HistoryPathState();
}

class _HistoryPathState extends ConsumerState<HistoryPath> {
  // Attrib
  late final String title;
  late final String year;
  late final List<String> tag;
  late final String desc;
  late final List<HistoryItemDocumentation>? listDocumentation;

  bool isDocsExpand = false;
  Timer? _animationTimer;
  int animDuration = 100;

  late List<bool> _itemWrapIsVisible;
  late List<bool> _itemColumnIsVisible;

  // TODO: FUNCTION
  void initAttrib() {
    title = widget.historyItemData.historyTitle;
    year = widget.historyItemData.historyYear;
    tag = widget.historyItemData.historyTag;
    desc = widget.historyItemData.historyDescription;
    listDocumentation = widget.historyItemData.historyDocumentations;
  }

  void startWrapAnimation() {
    clearColumnAnimation();
    _animationTimer?.cancel();
    int index = 0;
    _animationTimer =
        Timer.periodic(Duration(milliseconds: animDuration), (timer) {
      if (index < _itemWrapIsVisible.length) {
        setState(() {
          _itemWrapIsVisible[index] = true;
        });
        index++;
      } else {
        timer.cancel();
      }
    });
  }

  void startColumnAnimation() {
    clearWrapAnimation();
    _animationTimer?.cancel();
    int index = 0;
    _animationTimer =
        Timer.periodic(Duration(milliseconds: animDuration), (timer) {
      if (index < _itemColumnIsVisible.length) {
        setState(() {
          _itemColumnIsVisible[index] = true;
        });
        index++;
      } else {
        timer.cancel();
      }
    });
  }

  void clearWrapAnimation() {
    _itemWrapIsVisible = List.generate(
      (listDocumentation?.length ?? 0) > 3 ? 3 : listDocumentation?.length ?? 0,
      (_) => false,
      growable: false,
    );
  }

  void clearColumnAnimation() {
    _itemColumnIsVisible = List.generate(
      listDocumentation?.length ?? 0,
      (_) => false,
      growable: false,
    );
  }

  // TODO: END FUCNTION

  @override
  void initState() {
    // Atrib Init
    initAttrib();
    // Animation Init
    _itemWrapIsVisible = List.generate(
      (listDocumentation?.length ?? 0) > 3 ? 3 : listDocumentation?.length ?? 0,
      (_) => false,
      growable: false,
    );
    _itemColumnIsVisible = List.generate(
      listDocumentation?.length ?? 0,
      (_) => false,
      growable: false,
    );
    startWrapAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 4,
                  child: Text(
                    title,
                    style: StyleUtil.text_xl_Regular.copyWith(
                      color: isDarkMode ? StyleUtil.c_238 : StyleUtil.c_61,
                    ),
                  ),
                ),
                Text(
                  year,
                  style: StyleUtil.text_lg_Regular.copyWith(
                    color: isDarkMode ? StyleUtil.c_238 : StyleUtil.c_61,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: double.maxFinite,
            height: 1,
            color: isDarkMode ? StyleUtil.c_238 : StyleUtil.c_61,
          ),
          SizedBox(
            width: double.maxFinite,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: tag.map((item) {
                return Text(
                  item,
                  style: StyleUtil.text_small_Regular.copyWith(
                    color: isDarkMode ? StyleUtil.c_170 : StyleUtil.c_61,
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              desc,
              style: StyleUtil.text_Base_Regular.copyWith(
                color: isDarkMode ? StyleUtil.c_238 : StyleUtil.c_61,
              ),
            ),
          ),
          documentationSection(),
        ],
      ),
    );
  }

  Widget documentationSection() {
    bool isDocsAvailable = listDocumentation != null;

    return Visibility(
      visible: isDocsAvailable,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () => setState(() {
                (!isDocsExpand) ? startColumnAnimation() : startWrapAnimation();
                isDocsExpand = !isDocsExpand;
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isDocsExpand
                        ? "Collapse all documentation for this history"
                        : "See all documentation for this history",
                    style: StyleUtil.text_small_Regular
                        .copyWith(color: StyleUtil.c_170),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: AnimatedRotation(
                      turns: isDocsExpand ? -0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: StyleUtil.c_170,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: AnimatedSize(
              alignment: Alignment.topLeft,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: docsContentDecider(listDocumentation?.length ?? 0),
            ),
          ),
        ],
      ),
    );
  }

  Widget docsContentDecider(int totalItem) {
    if (!isDocsExpand) {
      // Collapse Mode
      return SizedBox(
        width: double.maxFinite,
        child: Wrap(
          spacing: 10,
          direction: Axis.horizontal,
          children: [
            for (int index = 0;
                index < (totalItem > 3 ? 3 : totalItem);
                index++)
              contentWrapItem(totalItem, index),
          ],
        ),
      );
    } else {
      // Expanded Mode
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int index = 0; index < totalItem; index++)
            contentColumnItem(totalItem, index),
        ],
      );
    }
  }

  Widget contentWrapItem(int totalItem, int index) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return AnimatedOpacity(
      duration: Duration(milliseconds: animDuration),
      opacity: _itemWrapIsVisible[index] ? 1 : 0,
      child: HighlightedWidgetOnHover(
        widgetWidth: 75,
        widgetHeight: 75,
        onTapAction: () => setState(() {
          (!isDocsExpand) ? startColumnAnimation() : startWrapAnimation();
          isDocsExpand = !isDocsExpand;
        }),
        customBorderRadius: BorderRadius.circular(5),
        child: SizedBox(
          width: 75,
          height: 75,
          child: Stack(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: BlurHashImage(
                      listDocumentation![index].docImageListHash[0],
                    ),
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: StyleUtil.c_170,
                ),
                // child: BlurHash(
                //   hash: listDocumentation![index].docImageListHash[0],
                //   image: listDocumentation![index].docImageList[0],
                //   imageFit: BoxFit.cover,
                //   color: Colors.transparent,
                //   duration: const Duration(milliseconds: 400),
                //   curve: Curves.easeOutQuart,
                // ),
                child: Image.asset(
                  fit: BoxFit.cover,
                  listDocumentation![index].docImageList[0],
                ),
              ),
              (totalItem > 3 && index == 2)
                  ? Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        color: StyleUtil.c_61.withValues(alpha: .7),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            isDarkMode
                                ? StyleUtil.c_238.withValues(alpha: .0)
                                : StyleUtil.c_61.withValues(alpha: 0),
                            isDarkMode
                                ? StyleUtil.c_238.withValues(alpha: 1)
                                : StyleUtil.c_61.withValues(alpha: 1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "+${totalItem - 3}",
                          style: StyleUtil.text_lg_Regular.copyWith(
                            color:
                                isDarkMode ? StyleUtil.c_61 : StyleUtil.c_255,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contentColumnItem(int totalItem, int index) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return AnimatedOpacity(
      duration: Duration(milliseconds: animDuration),
      opacity: _itemColumnIsVisible[index] ? 1 : 0,
      child: Padding(
        padding: EdgeInsets.only(bottom: index == totalItem - 1 ? 0 : 8),
        child: HighlightedWidgetOnHover(
          widgetWidth: double.maxFinite,
          widgetHeight: 75,
          onTapAction: () {
            context.goNamed("details_history", queryParameters: {
              "index": index.toString(),
              "id": widget.historyItemData.historyItemDataId,
            });
          },
          child: SizedBox(
            width: double.maxFinite,
            height: 75,
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listDocumentation![index].docType,
                          style: StyleUtil.text_small_Bold.copyWith(
                            color:
                                isDarkMode ? StyleUtil.c_255 : StyleUtil.c_33,
                          ),
                        ),
                        Text(
                          listDocumentation![index].docTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleUtil.text_Base_Regular.copyWith(
                            color:
                                isDarkMode ? StyleUtil.c_238 : StyleUtil.c_61,
                          ),
                        ),
                        Text(
                          listDocumentation![index].docDesc,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleUtil.text_small_Regular.copyWith(
                            color:
                                isDarkMode ? StyleUtil.c_238 : StyleUtil.c_61,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  clipBehavior: Clip.antiAlias,
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: BlurHashImage(
                        listDocumentation![index].docImageListHash[0],
                      ),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: StyleUtil.c_170,
                  ),
                  // child: BlurHash(
                  //   hash: listDocumentation![index].docImageListHash[0],
                  //   image: listDocumentation![index].docImageList[0],
                  //   imageFit: BoxFit.cover,
                  //   color: Colors.transparent,
                  //   duration: const Duration(milliseconds: 400),
                  //   curve: Curves.easeOutQuart,
                  // ),
                  child: Image.asset(
                    fit: BoxFit.cover,
                    listDocumentation![index].docImageList[0],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryScoopeType extends ConsumerWidget {
  final String titleHistoryScoope;
  final List<HistoryItemData> historyData;

  const HistoryScoopeType({
    super.key,
    required this.titleHistoryScoope,
    required this.historyData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleHistoryScoope,
            style: StyleUtil.text_Base_Bold.copyWith(
              color: isDarkMode ? StyleUtil.c_255 : StyleUtil.c_61,
            ),
          ),
          ListView.builder(
            itemCount: historyData.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SubHistoryScoope(
                titleHistory: historyData[index].historyTitle,
              );
            },
          ),
        ],
      ),
    );
  }
}

class SubHistoryScoope extends ConsumerWidget {
  final String titleHistory;

  const SubHistoryScoope({
    super.key,
    required this.titleHistory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    return Container(
      margin: const EdgeInsets.only(top: 7, left: 28),
      height: 24,
      child: Text(
        titleHistory,
        style: StyleUtil.text_Base_Regular.copyWith(
          color: isDarkMode ? StyleUtil.c_238 : StyleUtil.c_61,
        ),
      ),
    );
  }
}

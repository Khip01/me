import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:me/app/provider/page_transition_provider.dart';
import 'package:me/app/theme/style_util.dart';
import 'package:me/shared/helper/helper.dart';
import 'package:me/shared/utils/utils.dart';
import 'package:me/shared/component/components.dart';
import 'package:me/shared/widget/text_highlight_decider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:me/app/provider/theme_provider.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  // TODO: ------ Declaration ------

  // --- Content Top Section ---
  // Dark/Light Theme Switch
  // Switch, animation
  bool isFromLeft = true, transitionIsActive = false, ignoreTapping = false;

  // --- Nav Section ---
  //  Other Hover
  bool githubHover = false, cvHover = false, themeSwitch = false;

  // --- Transition Nav ---
  // Rect Global Key
  final GlobalKey<RectGetterState> _rectKeyCreationPage =
      RectGetter.createGlobalKey();
  final GlobalKey<RectGetterState> _rectKeyHistoryPage =
      RectGetter.createGlobalKey();
  final GlobalKey<RectGetterState> _rectKeyFurtherPage =
      RectGetter.createGlobalKey();

  // Rect
  Rect? _rectCreation;
  Rect? _rectHistory;
  Rect? _rectFurther;

  // Duration constants for page transitions
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration afterAnimationDelay = Duration(milliseconds: 300);

  // TODO: ------ Function ------
  // --- Content Top Section
  // Switch Mode
  void switchWithTransition() async {
    ignoreTapping = true;
    isFromLeft = !isFromLeft;
    setState(() => transitionIsActive = !transitionIsActive);
    ref.read(pageTransitionProvider.notifier).state = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(animationDuration, () {
        ref.read(isDarkModeProvider.notifier).toggle();
        final isDark = ref.read(isDarkModeProvider).value;
        updateMetaThemeColor(isDark);
        changeCookieValue("$isDark");
      });
      Future.delayed(animationDuration + afterAnimationDelay, () {
        setState(() => transitionIsActive = !transitionIsActive);
      }).then((_) {
        ref.read(pageTransitionProvider.notifier).state = false;
        setState(() => ignoreTapping = false);
      });
    });
  }

  // --- Content Body Section ---
  // Open Url
  Future<void> _openUrl(String url) async {
    Uri uri = Uri.parse(url);
    !await launchUrl(uri);
  }

  // Show Snackbar Template
  Future<void> _showSnackbar(String message, String url) async {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 30),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 5,
              color: (isDarkMode)
                  ? StyleUtil.c_success_dark
                  : StyleUtil.c_success_light,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 14.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.check_circle,
                        color: StyleUtil.c_255,
                      ),
                    ),
                    Text(
                      message,
                      style: StyleUtil.text_small_Medium.copyWith(
                        letterSpacing: 1,
                        color: StyleUtil.c_255,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    await _openUrl(url);
  }

  // --- Transition Nav ---
  // Push Page With Transition
  void _handleNavigation(String routeName, GlobalKey<RectGetterState> key,
      Function(Rect?) setRect) {
    if (ignoreTapping) return;

    final rect = RectGetter.getRectFromKey(key);
    if (rect == null) return;

    setState(() {
      ignoreTapping = true;
      setRect(rect);
    });

    ref.read(pageTransitionProvider.notifier).state = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      setState(() =>
          setRect(rect.inflate(1.3 * MediaQuery.sizeOf(context).longestSide)));

      Future.delayed(animationDuration + afterAnimationDelay, () {
        if (!mounted) return;
        final router = GoRouter.of(context);

        ref.read(pageTransitionProvider.notifier).state = false;
        setState(() {
          setRect(null);
          ignoreTapping = false;
        });

        router.goNamed(routeName);
      });
    });
  }

  void _pushNamedWithRectCreation() => _handleNavigation(
      "creation", _rectKeyCreationPage, (r) => _rectCreation = r);

  void _pushNamedWithRectHistory() => _handleNavigation(
      "history", _rectKeyHistoryPage, (r) => _rectHistory = r);

  void _pushNamedWithRectFurther() => _handleNavigation(
      "further", _rectKeyFurtherPage, (r) => _rectFurther = r);

  @override
  void dispose() {
    ignoreTapping = false;
    _rectCreation = null;
    _rectHistory = null;
    _rectFurther = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;
    final scrHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        IgnorePointer(
          ignoring: ignoreTapping,
          child: SelectionArea(
            child: Scaffold(
              body: Container(
                color: (isDarkMode) ? StyleUtil.c_33 : StyleUtil.c_255,
                height: scrHeight,
                // padding: mainCardPadding(context),
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
                        //   borderRadius: BorderRadius.circular(20),
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
                    _footerTechnology(),
                  ],
                ),
              ),
            ),
          ),
        ),
        _transitionToCreationPage(),
        _transitionToHistoryPage(),
        _transitionToFurtherPage(),
        _switchTapedWithTransition(),
      ],
    );
  }

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 24,
          // color: Colors.red,
          margin: const EdgeInsets.only(bottom: 15),
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: alignmentRowLink(context),
            children: [
              Text(
                "Hello ",
                style: StyleUtil.text_lg_Bold.copyWith(
                  color: (isDarkMode) ? StyleUtil.c_238 : StyleUtil.c_61,
                ),
              ),
              Image.asset(IconUtil.wavingHand),
            ],
          ),
        ),
        Container(
          // height: 96,
          // color: Colors.blue,
          margin: const EdgeInsets.only(bottom: 15),
          width: getIsDesktopSmAndBelowSize(context) ? double.maxFinite : 512,
          child: Align(
            alignment: widgetAlignment(context),
            child: Text(
              "Aakhif here, I’m a Cross-Platform Mobile Developer",
              style: StyleUtil.text_2xl_Bold.copyWith(
                color: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
              ),
              textAlign: textAlignment(context),
            ),
          ),
        ),
        Container(
          // height: 48,
          // color: Colors.amberAccent,
          margin: const EdgeInsets.only(bottom: 30),
          width: 694,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "My name is Akhmad Aakhif Athallah, a teenage student who is in the process of learning and has a strong desire to become a cross-platform mobile application developer.",
              style: StyleUtil.text_Base_Medium.copyWith(
                color: (isDarkMode) ? StyleUtil.c_238 : StyleUtil.c_61,
              ),
              textAlign: textAlignment(context),
            ),
          ),
        ),
        SizedBox(
          // color: Colors.lightGreenAccent,
          // height: 24,
          height: 46,
          width: double.maxFinite,
          child: Builder(
            builder: (context) {
              Widget child = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextHighlightDecider(
                    isCompactMode:
                        getIsMobileSize(context) || getIsTabletSize(context),
                    colorStart: StyleUtil.c_170,
                    colorEnd: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_24,
                    actionDelay: const Duration(milliseconds: 300),
                    additionalOnTapAction: () async => await _showSnackbar(
                        "Github Opened Successfully!", LinkUtil.githubLink),
                    builder: (Color color) {
                      return Row(
                        children: [
                          Text(
                            "See My Github Journey",
                            style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: fontSizeWelcomeResize(context),
                              fontWeight: FontWeight.w400,
                              color: color,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.open_in_new,
                              color: color,
                              size: iconSizeWelcomeResize(context),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: TextHighlightDecider(
                      isCompactMode:
                          getIsMobileSize(context) || getIsTabletSize(context),
                      colorStart: StyleUtil.c_170,
                      colorEnd: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_24,
                      actionDelay: const Duration(milliseconds: 300),
                      additionalOnTapAction: () async => await _showSnackbar(
                          "CV Opened Successfully!", LinkUtil.cvLink),
                      builder: (Color color) {
                        return Row(
                          children: [
                            Text(
                              "See My CV",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: fontSizeWelcomeResize(context),
                                fontWeight: FontWeight.w400,
                                color: color,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.open_in_new,
                                color: color,
                                size: iconSizeWelcomeResize(context),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );

              if (getIsMobileSize(context)) {
                return Flexible(
                  child: FittingMobileSizeDecider(
                    sizeIsMobile: true,
                    child: child,
                  ),
                );
              } else {
                return Expanded(
                  child: Align(
                    alignment: alignmentWidgetLink(context),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: child,
                    ),
                  ),
                );
              }
            },
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
      child: Row(
        mainAxisAlignment: alignmentRowNav(context),
        children: [
          bottomHelper(context),
          Builder(builder: (context) {
            Widget child = Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: horPadding, vertical: verPadding),
                  child: Text(
                    "Welcome",
                    style: StyleUtil.text_small_Regular.copyWith(
                      color: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
                    ),
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
                RectGetter(
                  key: _rectKeyHistoryPage,
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
                    additionalOnTapAction: () => _pushNamedWithRectHistory(),
                    builder: (Color color) {
                      return Text(
                        "History",
                        style: StyleUtil.text_small_Regular.copyWith(
                          color: color,
                        ),
                      );
                    },
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
            );

            if (getIsMobileSize(context)) {
              return Flexible(
                child: FittingMobileSizeDecider(
                  sizeIsMobile: true,
                  child: child,
                ),
              );
            } else {
              return Expanded(
                child: Align(
                  alignment: alignmentRowNavContainer(context),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    child: child,
                  ),
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _footerTechnology() {
    return Container(
      alignment: Alignment.topCenter,
      height: contentQuoteHeight(context),
      width: double.maxFinite,
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
    );
  }

  // ------ Transition Page -----
  Widget _transitionToCreationPage() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    if (_rectCreation == null) {
      return const SizedBox();
    }

    return AnimatedPositioned(
      duration: animationDuration,
      top: _rectCreation!.top,
      right: MediaQuery.sizeOf(context).width - _rectCreation!.right,
      bottom: MediaQuery.sizeOf(context).height - _rectCreation!.bottom,
      left: _rectCreation!.left,
      child: Container(
        decoration: BoxDecoration(
          color: (isDarkMode) ? StyleUtil.c_61 : StyleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _transitionToHistoryPage() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    if (_rectHistory == null) {
      return const SizedBox();
    }

    return AnimatedPositioned(
      duration: animationDuration,
      top: _rectHistory!.top,
      right: MediaQuery.sizeOf(context).width - _rectHistory!.right,
      bottom: MediaQuery.sizeOf(context).height - _rectHistory!.bottom,
      left: _rectHistory!.left,
      child: Container(
        decoration: BoxDecoration(
          color: (isDarkMode) ? StyleUtil.c_61 : StyleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _transitionToFurtherPage() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    if (_rectFurther == null) {
      return const SizedBox();
    }

    return AnimatedPositioned(
      duration: animationDuration,
      top: _rectFurther!.top,
      right: MediaQuery.sizeOf(context).width - _rectFurther!.right,
      bottom: MediaQuery.sizeOf(context).height - _rectFurther!.bottom,
      left: _rectFurther!.left,
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
            color: (isDarkMode) ? StyleUtil.c_61 : StyleUtil.c_170,
            shape: BoxShape.rectangle),
      ),
    );
  }
}

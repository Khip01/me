import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:me/utility/utility.dart';
import 'package:me/component/components.dart';
import 'package:me/helper/update_meta_theme_color.dart';
import 'package:me/widget/text_highlight_decider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:me/provider/theme_provider.dart';

import '../helper/init_app_theme.dart';

class FurtherPage extends ConsumerStatefulWidget {
  const FurtherPage({super.key});

  @override
  ConsumerState<FurtherPage> createState() => _FurtherPageState();
}

class _FurtherPageState extends ConsumerState<FurtherPage> {
  // TODO: ------ Declaration ------
  // --- Content Top Section ---
  // Dark/Light Theme Switch
  // Switch, animation
  bool isFromLeft = true, transitionIsActive = false, ignoreTapping = false;

  // --- Nav Section ---
  final List<bool> _iconsHover = List.generate(5, (i) => false);

  //  Other Hover
  bool themeSwitch = false;

  // --- Transition Nav ---
  // Rect Global Key
  final GlobalKey<RectGetterState> _rectKeyWelcomePage =
      RectGetter.createGlobalKey();
  final GlobalKey<RectGetterState> _rectKeyCreationPage =
      RectGetter.createGlobalKey();
  final GlobalKey<RectGetterState> _rectKeyHistoryPage =
      RectGetter.createGlobalKey();

  // Rect
  Rect? _rectWelcome;
  Rect? _rectCreation;
  Rect? _rectHistory;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(animationDuration, () {
        ref.read(isDarkModeProvider.notifier).toggle();
        final isDark = ref.read(isDarkModeProvider).value;
        updateMetaThemeColor(isDark);
        changeCookieValue("$isDark");
      });
      Future.delayed(animationDuration + afterAnimationDelay, () {
        setState(() => transitionIsActive = !transitionIsActive);
      }).then((_) => setState(() => ignoreTapping = false));
    });
  }

  // --- Content Body Section ---
  // Open Url
  Future<void> _openUrl(String url) async {
    Uri uri = Uri.parse(url);
    !await launchUrl(uri);
  }

  // Show Snackbar Template + Open URL
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

  void _pushNamedWithRectCreation() async {
    setState(
        () => _rectCreation = RectGetter.getRectFromKey(_rectKeyCreationPage));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectCreation =
          _rectCreation!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay,
          () => context.goNamed("creation"));
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

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;
    final scrHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        SelectionArea(
          child: Scaffold(
            body: Container(
              color: (isDarkMode) ? StyleUtil.c_33 : StyleUtil.c_255,
              height: scrHeight,
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
        _transitionToWelcomePage(),
        _transitionToCreationPage(),
        _transitionToHistoryPage(),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Container(
            // height: 96,
            // color: Colors.blue,
            margin: const EdgeInsets.only(bottom: 15),
            width: double.maxFinite,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "DISCOVER MORE",
                style: StyleUtil.text_2xl_Bold.copyWith(
                  color: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: flexContentFurther(context),
          child: Container(
            // height: 48,
            // color: Colors.amberAccent,
            margin: const EdgeInsets.only(bottom: 30),
            width: 694,
            child: Wrap(
              spacing: 20,
              runSpacing: 40,
              alignment: WrapAlignment.center,
              children: [
                SizedBox(
                  width: 64,
                  height: 64,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onTap: () async => await _showSnackbar(
                        "Github Opened Successfully!", LinkUtil.githubLink),
                    onHover: (val) {
                      setState(() {
                        _iconsHover[0] = val;
                      });
                    },
                    child: Image.asset(
                      (_iconsHover[0])
                          ? (isDarkMode)
                              ? IconUtil.imgGithubDark
                              : IconUtil.imgGithubLight
                          : IconUtil.imgGithubDefault,
                    ),
                  ),
                ),
                SizedBox(
                  width: 64,
                  height: 64,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onTap: () async => await _showSnackbar(
                        "Instagram Opened Successfully!", LinkUtil.instaLink),
                    onHover: (val) {
                      setState(() {
                        _iconsHover[1] = val;
                      });
                    },
                    child: Image.asset(
                      (_iconsHover[1])
                          ? (isDarkMode)
                              ? IconUtil.imgInstagramDark
                              : IconUtil.imgInstagramLight
                          : IconUtil.imgInstagramDefault,
                    ),
                  ),
                ),
                SizedBox(
                  width: 64,
                  height: 64,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onTap: () async => await _showSnackbar(
                        "Facebook Opened Successfully!", LinkUtil.facebookLink),
                    onHover: (val) {
                      setState(() {
                        _iconsHover[2] = val;
                      });
                    },
                    child: Image.asset(
                      (_iconsHover[2])
                          ? (isDarkMode)
                              ? IconUtil.imgFacebookDark
                              : IconUtil.imgFacebookLight
                          : IconUtil.imgFacebookDefault,
                    ),
                  ),
                ),
                SizedBox(
                  width: 64,
                  height: 64,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onTap: () async => await _showSnackbar(
                        "Gmail Opened Successfully!", LinkUtil.gmailLink),
                    onHover: (val) {
                      setState(() {
                        _iconsHover[3] = val;
                      });
                    },
                    child: Image.asset(
                      (_iconsHover[3])
                          ? (isDarkMode)
                              ? IconUtil.imgGmailDark
                              : IconUtil.imgGmailLight
                          : IconUtil.imgGmailDefault,
                    ),
                  ),
                ),
                SizedBox(
                  width: 64,
                  height: 64,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onTap: () async => await _showSnackbar(
                        "LinkedIn Opened Successfully!", LinkUtil.linkedinLink),
                    onHover: (val) {
                      setState(() {
                        _iconsHover[4] = val;
                      });
                    },
                    child: Image.asset(
                      (_iconsHover[4])
                          ? (isDarkMode)
                              ? IconUtil.imgLinkedinDark
                              : IconUtil.imgLinkedinLight
                          : IconUtil.imgLinkedinDefault,
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horPadding,
                    vertical: verPadding,
                  ),
                  child: Text(
                    "Further",
                    style: StyleUtil.text_small_Regular.copyWith(
                      color: (isDarkMode) ? StyleUtil.c_255 : StyleUtil.c_33,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _footerTechnology() {
    return Container(
      alignment: Alignment.topCenter,
      padding: contentQuotePadding(context).copyWith(bottom: 44),
      height: contentQuoteHeight(context),
      width: double.maxFinite,
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
  Widget _transitionToWelcomePage() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    if (_rectWelcome == null) {
      return const SizedBox();
    }

    return AnimatedPositioned(
      duration: animationDuration,
      top: _rectWelcome!.top,
      right: MediaQuery.sizeOf(context).width - _rectWelcome!.right,
      bottom: MediaQuery.sizeOf(context).height - _rectWelcome!.bottom,
      left: _rectWelcome!.left,
      child: Container(
        decoration: BoxDecoration(
          color: (isDarkMode) ? StyleUtil.c_61 : StyleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

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

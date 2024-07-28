import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:me/utility/utility.dart';
import 'package:me/component/components.dart';
import 'package:me/widget/text_highlight_decider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:me/provider/theme_provider.dart';

import '../helper/init_app_theme.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  // TODO: ------ Declaration ------
  // --- General ---
  final StyleUtil _styleUtil = StyleUtil();
  final IconUtil _iconUtil = IconUtil();
  final LinkUtil _linkUtil = LinkUtil();

  // --- Content Top Section ---
  // Dark/Light Theme Switch
  // Switch, animation
  bool isFromLeft = true, transitionIsActive = false, ignoreTapping = false;

  // --- Nav Section ---
  //  Other Hover
  bool githubHover = false, cvHover = false, themeSwitch = false;

  // --- Transition Nav ---
  // Rect Global Key
  final GlobalKey<RectGetterState> _rectKeyCreationPage = RectGetter.createGlobalKey();
  final GlobalKey<RectGetterState> _rectKeyHistoryPage = RectGetter.createGlobalKey();
  final GlobalKey<RectGetterState> _rectKeyFurtherPage = RectGetter.createGlobalKey();
  // Rect
  Rect? _rectCreation;
  Rect? _rectHistory;
  Rect? _rectFurther;
  // Duration
  Duration animationDuration = const Duration(milliseconds: 300), afterAnimationDelay = const Duration(milliseconds: 300);

  // TODO: ------ Function ------
  // --- Content Top Section
  // Switch Mode
  void switchWithTransition() async {
    ignoreTapping = true; // IGNORE FOR ON TAPPING
    isFromLeft = !isFromLeft;
    setState(() => transitionIsActive = !transitionIsActive);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(animationDuration, () {
        ref.read(isDarkModeProvider.notifier).value = !ref.read(isDarkModeProvider).value; // SET DARK MODE HERE
        changeCookieValue("${ref.read(isDarkModeProvider.notifier).value}"); // SET COOKIE VALUE HERE
      });
      Future.delayed(animationDuration + afterAnimationDelay, () => setState(() {
        transitionIsActive = !transitionIsActive;
      })).then((_) => setState(() {
        ignoreTapping = false;
      }));
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
              color: (isDarkMode) ? _styleUtil.c_success_dark : _styleUtil.c_success_light,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 14.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.check_circle,
                        color: _styleUtil.c_255,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        letterSpacing: 1,
                        fontFamily: "Lato",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _styleUtil.c_255,
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
  void _pushNamedWithRectCreation() async {
    setState(() => _rectCreation = RectGetter.getRectFromKey(_rectKeyCreationPage));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectCreation = _rectCreation!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay, () => context.goNamed("creation"));
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


  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;
    final scrHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        SelectionArea(
          child: Scaffold(
            body: Container(
              color: (isDarkMode) ? _styleUtil.c_33 : _styleUtil.c_255,
              height: scrHeight,
              padding: mainCardPadding(context),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 1100,
                  ),
                  padding: contentCardPadding(context),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (isDarkMode) ? _styleUtil.c_33 : _styleUtil.c_255,
                    boxShadow: [
                      BoxShadow(
                        color: (isDarkMode) ? const Color.fromARGB(
                            255, 61, 61, 61) : const Color.fromARGB(255, 203, 203, 203),
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
                color: (themeSwitch) ? (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_24 : Colors.transparent),
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
                style: TextStyle(
                  fontFamily: "Lato",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: (isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61,
                ),
              ),
              Image.asset(_iconUtil.wavingHand),
            ],
          ),
        ),
        Container(
          // height: 96,
          // color: Colors.blue,
          margin: const EdgeInsets.only(bottom: 15),
          width: 512,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Aakhif here, I’m a Cross-Platform Mobile Developer",
              style: TextStyle(
                fontFamily: "Lato",
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_33,
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
              style: TextStyle(
                fontFamily: "Lato",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: (isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61,
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
          child: Align(
            // alignment: topWidgetAlignment(context),
            child: Row(
              mainAxisAlignment: alignmentRowLink(context),
              children: [
                TextHighlightDecider(
                  isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                  colorStart: _styleUtil.c_170,
                  colorEnd: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_24,
                  actionDelay: const Duration(milliseconds: 300),
                  additionalOnTapAction: () async => await _showSnackbar("Github Opened Successfully!", _linkUtil.githubLink),
                  builder: (Color color){
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
                    isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                    colorStart: _styleUtil.c_170,
                    colorEnd: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_24,
                    actionDelay: const Duration(milliseconds: 300),
                    additionalOnTapAction: () async => await _showSnackbar("CV Opened Successfully!", _linkUtil.cvLink),
                    builder: (Color color){
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
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                        fontFamily: 'Lato', fontSize: 14, color: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_33),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: RectGetter(
                    key: _rectKeyCreationPage,
                    child: TextHighlightDecider(
                      isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                      colorStart: _styleUtil.c_170,
                      colorEnd: (isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_33,
                      actionDelay: const Duration(milliseconds: 100),
                      additionalOnTapAction: () => _pushNamedWithRectCreation(),
                      builder: (Color color){
                        return Text(
                          "Creation",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            color: color,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: RectGetter(
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: RectGetter(
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  // ------ Transition Page -----
  Widget _transitionToCreationPage() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    if(_rectCreation == null) {
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
          color: (isDarkMode) ? _styleUtil.c_61 : _styleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
  Widget _transitionToHistoryPage() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    if(_rectHistory == null) {
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
          color: (isDarkMode) ? _styleUtil.c_61 : _styleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
  Widget _transitionToFurtherPage() {
    bool isDarkMode = ref.watch(isDarkModeProvider).value;

    if(_rectFurther == null) {
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
      right: isFromLeft ? (!transitionIsActive) ? 1.3 * MediaQuery.sizeOf(context).width : 0 : 0,
      bottom: 0,
      left: isFromLeft ? 0 : (!transitionIsActive) ? 1.3 * MediaQuery.sizeOf(context).width : 0,
      child: AnimatedContainer(
        duration: animationDuration,
        decoration: BoxDecoration(
          color: (isDarkMode) ? _styleUtil.c_61 : _styleUtil.c_170,
          shape: BoxShape.rectangle
        ),
      ),
    );
  }
}

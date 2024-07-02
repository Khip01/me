import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:me/utility/utility.dart';
import 'package:me/component/components.dart';
import 'package:me/widget/text_highlight_decider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:me/provider/theme_provider.dart';


class FurtherPage extends ConsumerStatefulWidget {
  const FurtherPage({super.key});

  @override
  ConsumerState<FurtherPage> createState() => _FurtherPageState();
}

class _FurtherPageState extends ConsumerState<FurtherPage> {
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
  // Nav List Hover
  final List<bool> _navHover = List.generate(4, (index) => index == 3 ? true : false);
  List<bool> _iconsHover = List.generate(5, (i) => false);
  //  Other Hover
  bool themeSwitch = false;

  // --- Transition Nav ---
  // Rect Global Key
  final GlobalKey<RectGetterState> _rectKeyWelcomePage = RectGetter.createGlobalKey();
  final GlobalKey<RectGetterState> _rectKeyCreationPage = RectGetter.createGlobalKey();
  final GlobalKey<RectGetterState> _rectKeyHistoryPage = RectGetter.createGlobalKey();
  // Rect
  Rect? _rectWelcome;
  Rect? _rectCreation;
  Rect? _rectHistory;
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
      Future.delayed(animationDuration, () => setState(() {
        ref.read(isDarkMode.notifier).state = !ref.read(isDarkMode); // SET DARK MODE HERE
      }));
      Future.delayed(animationDuration + afterAnimationDelay, () => setState(() {
        transitionIsActive = !transitionIsActive;
      })).then((_) => setState((){
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
  // Show Snackbar Template + Open URL
  Future<void> _showSnackbar(String message, String url) async {
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
              color: (ref.watch(isDarkMode)) ? _styleUtil.c_success_dark : _styleUtil.c_success_light,
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
  void _pushNamedWithRectWelcome() async {
    setState(() => _rectWelcome = RectGetter.getRectFromKey(_rectKeyWelcomePage));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectWelcome = _rectWelcome!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(animationDuration + afterAnimationDelay, () => context.goNamed("welcome"));
    });
  }
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


  @override
  Widget build(BuildContext context) {
    final scrHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        SelectionArea(
          child: Scaffold(
            body: Container(
              color: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
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
                      padding: contentCardPadding(context),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
                        boxShadow: [
                          BoxShadow(
                            color: (ref.watch(isDarkMode)) ? const Color.fromARGB(
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
                color: (themeSwitch) ? (ref.watch(isDarkMode)) ? _styleUtil.c_255 : _styleUtil.c_24 : Colors.transparent),
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
              colorEnd: (ref.watch(isDarkMode)) ? _styleUtil.c_255 : _styleUtil.c_24,
              actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 500 : 100),
              delayAfterAnimation: const Duration(milliseconds: 300),
              additionalOnTapAction: () => switchWithTransition(),
              additionalOnHoverAction: (value) => setState(() => themeSwitch = value),
              builder: (Color color){
                return Icon(
                  (ref.watch(isDarkMode)) ? Icons.dark_mode : Icons.sunny,
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
                    onTap: () async => await _showSnackbar("Github Opened Successfully!", _linkUtil.githubLink),
                    onHover: (val) {
                      setState(() {
                        _iconsHover[0] = val;
                      });
                    },
                    child: Image.asset(
                      (_iconsHover[0]) ? (ref.watch(isDarkMode)) ? _iconUtil.imgGithubDark : _iconUtil.imgGithubLight : _iconUtil.imgGithubDefault,
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
                    onTap: () async => await _showSnackbar("Instagram Opened Successfully!", _linkUtil.instaLink),
                    onHover: (val) {
                      setState(() {
                        _iconsHover[1] = val;
                      });
                    },
                    child: Image.asset(
                      (_iconsHover[1]) ? (ref.watch(isDarkMode)) ? _iconUtil.imgInstagramDark : _iconUtil.imgInstagramLight : _iconUtil.imgInstagramDefault,
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
                    onTap: () async => await _showSnackbar("Facebook Opened Successfully!", _linkUtil.facebookLink),
                    onHover: (val) {
                      setState(() {
                        _iconsHover[2] = val;
                      });
                    },
                    child: Image.asset(
                      (_iconsHover[2]) ? (ref.watch(isDarkMode)) ? _iconUtil.imgFacebookDark : _iconUtil.imgFacebookLight : _iconUtil.imgFacebookDefault,
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
                    onTap: () async => await _showSnackbar("Gmail Opened Successfully!", _linkUtil.gmailLink),
                    onHover: (val) {
                      setState(() {
                        _iconsHover[3] = val;
                      });
                    },
                    child: Image.asset(
                      (_iconsHover[3]) ? (ref.watch(isDarkMode)) ? _iconUtil.imgGmailDark : _iconUtil.imgGmailLight : _iconUtil.imgGmailDefault,
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
                    onTap: () async => await _showSnackbar("LinkedIn Opened Successfully!", _linkUtil.linkedinLink),
                    onHover: (val) {
                      setState(() {
                        _iconsHover[4] = val;
                      });
                    },
                    child: Image.asset(
                      (_iconsHover[4]) ? (ref.watch(isDarkMode)) ? _iconUtil.imgLinkedinDark : _iconUtil.imgLinkedinLight : _iconUtil.imgLinkedinDefault,
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
                  child: RectGetter(
                    key: _rectKeyWelcomePage,
                    child: TextHighlightDecider(
                      isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                      colorStart: _styleUtil.c_170,
                      colorEnd: (ref.watch(isDarkMode)) ? _styleUtil.c_255 : _styleUtil.c_33,
                      actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 500 : 100),
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: RectGetter(
                    key: _rectKeyCreationPage,
                    child: TextHighlightDecider(
                      isCompactMode: getIsMobileSize(context) || getIsTabletSize(context),
                      colorStart: _styleUtil.c_170,
                      colorEnd: (ref.watch(isDarkMode)) ? _styleUtil.c_255 : _styleUtil.c_33,
                      actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 500 : 100),
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
                      colorEnd: (ref.watch(isDarkMode)) ? _styleUtil.c_255 : _styleUtil.c_33,
                      actionDelay: Duration(milliseconds: (getIsMobileSize(context) || getIsTabletSize(context)) ? 500 : 100),
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
                  child: Text(
                    "Further",
                    style: TextStyle(
                        fontFamily: 'Lato', fontSize: 14, color: (ref.watch(isDarkMode)) ? _styleUtil.c_255 : _styleUtil.c_33),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _quoteContentSection(){
    return Container(
      padding: contentQuotePadding(context),
      height: contentQuoteHeight(context),
      width: double.maxFinite,
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
  Widget _transitionToWelcomePage() {
    if(_rectWelcome == null) {
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
          color: (ref.watch(isDarkMode)) ? _styleUtil.c_61 : _styleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
  Widget _transitionToCreationPage() {
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
          color: (ref.watch(isDarkMode)) ? _styleUtil.c_61 : _styleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
  Widget _transitionToHistoryPage() {
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
      right: isFromLeft ? (!transitionIsActive) ? 1.3 * MediaQuery.sizeOf(context).width : 0 : 0,
      bottom: 0,
      left: isFromLeft ? 0 : (!transitionIsActive) ? 1.3 * MediaQuery.sizeOf(context).width : 0,
      child: AnimatedContainer(
        duration: animationDuration,
        decoration: BoxDecoration(
            color: (ref.watch(isDarkMode)) ? _styleUtil.c_61 : _styleUtil.c_170,
            shape: BoxShape.rectangle
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:me/Utility/style_util.dart';
import 'package:me/component/components.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // ### --- Declaration --- ###
  // --- General ---
  final StyleUtil styleUtil = StyleUtil();

  // --- Content Body Section ---
  // Open Url
  Future<void> _openUrl(String url) async {
    Uri uri = Uri.parse(url);
    !await launchUrl(uri);
  }

  // --- Nav Section ---
  // Nav List Hover
  final List<bool> _navHover = List.generate(4, (index) => index == 0 ? true : false);
  //  Other Hover
  bool githubHover = false, cvHover = false, themeSwitch = false;

  // --- Transition Nav ---
  // Rect Global Key
  GlobalKey<RectGetterState> _rectKeyCreationPage = RectGetter.createGlobalKey();
  GlobalKey<RectGetterState> _rectKeyHistoryPage = RectGetter.createGlobalKey();
  GlobalKey<RectGetterState> _rectKeyFurtherPage = RectGetter.createGlobalKey();
  // Rect
  Rect? _rectCreation;
  Rect? _rectHistory;
  Rect? _rectFurther;
  // Duration
  Duration animationDuration = Duration(milliseconds: 300), afterAnimationDelay = Duration(milliseconds: 300);

  // ### --- Function --- ###
  // --- Content Body Section ---
  // Show Snackbar Template
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
              color: styleUtil.c_success,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 14.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.check_circle,
                        color: styleUtil.c_255,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        letterSpacing: 1,
                        fontFamily: "Lato",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: styleUtil.c_255,
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
    final scrHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        Scaffold(
          body: Container(
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
                  color: styleUtil.c_255,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 203, 203, 203),
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
                      child: dashHorizontal(context),
                    ),
                    Positioned(
                      top: 50,
                      right: 0,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: dashVertical(context),
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
        _transitionToCreationPage(),
        _transitionToHistoryPage(),
        _transitionToFurtherPage(),
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
                color: (themeSwitch) ? styleUtil.c_24 : Colors.transparent),
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
              // TODO: Dark/Light Mode
            },
            child: Icon(
              Icons.sunny,
              size: 32,
              color: (themeSwitch) ? styleUtil.c_24 : styleUtil.c_170,
            ),
          ),
        ),
      ],
    );
  }
  Widget _content() {
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
                  color: styleUtil.c_61,
                ),
              ),
              Image.asset('assets/icons/waving_hand.png'),
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
                color: styleUtil.c_33,
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
                color: styleUtil.c_61,
              ),
              textAlign: textAlignment(context),
            ),
          ),
        ),
        SizedBox(
          // color: Colors.lightGreenAccent,
          height: 24,
          child: Align(
            // alignment: topWidgetAlignment(context),
            child: Row(
              mainAxisAlignment: alignmentRowLink(context),
              children: [
                InkWell(
                  onHover: (value) {
                    setState(() {
                      githubHover = value;
                    });
                  },
                  onTap: () async {
                    await _showSnackbar("Github Opened Successfully!",
                        "https://github.com/Khip01");
                  },
                  child: Row(
                    children: [
                      Text(
                        "See My Github Journey",
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color:
                              (githubHover) ? styleUtil.c_24 : styleUtil.c_170,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.open_in_new,
                          color:
                              (githubHover) ? styleUtil.c_24 : styleUtil.c_170,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: InkWell(
                    onHover: (value) {
                      setState(() {
                        cvHover = value;
                      });
                    },
                    onTap: () async {
                      await _showSnackbar("CV Opened Successfully!",
                          "https://app.enhancv.com/share/ae221296/?utm_medium=growth&utm_campaign=share-resume&utm_source=dynamic");
                    },
                    child: Row(
                      children: [
                        Text(
                          "See My CV",
                          style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: (cvHover) ? styleUtil.c_24 : styleUtil.c_170,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.open_in_new,
                            color: (cvHover) ? styleUtil.c_24 : styleUtil.c_170,
                            size: 20,
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
                child: Text(
                  "Welcome",
                  style: TextStyle(
                      fontFamily: 'Lato', fontSize: 14, color: styleUtil.c_33),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: RectGetter(
                  key: _rectKeyCreationPage,
                  child: InkWell(
                    onHover: (value) => setState(() {
                      _navHover[1] = value;
                    }),
                    onTap: () {
                      _pushNamedWithRectCreation();
                    },
                    child: Text(
                      "Creation",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: (_navHover[1]) ? styleUtil.c_33 : styleUtil.c_170,
                      ),
                    ),
                  ),
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
                        color: (_navHover[2]) ? styleUtil.c_33 : styleUtil.c_170,
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
                        color: (_navHover[3]) ? styleUtil.c_33 : styleUtil.c_170,
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


  // ------ Transition Page -----
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
          color: styleUtil.c_33,
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
          color: styleUtil.c_33,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
  Widget _transitionToFurtherPage() {
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
          color: styleUtil.c_33,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:me/component/components.dart';
import 'package:me/provider/theme_provider.dart';
import 'package:me/values/values.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../Utility/style_util.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  // TODO: ------ Declaration ------
  // --- General ---
  final StyleUtil _styleUtil = StyleUtil();

  late double scrHeight;

  // --- Content Top Section ---
  // Dark/Light Theme Switch
  // Switch, animation
  bool _isFromLeft = true, _transitionIsActive = false, ignoreTapping = false;

  // --- Nav Section ---
  // Nav List Hover
  final List<bool> _navHover =
  List.generate(4, (index) => index == 2 ? true : false);
  // Controller for Sliver Nav
  static final ScrollController _navScrollController = ScrollController(initialScrollOffset: 1);
  bool _navIsSticky = false;
  // Value Notifier Sticky Nav Header
  late ValueNotifier<bool> _navIsStickyNotifier = ValueNotifier(false);

  //  Other Hover
  bool _themeSwitch = false;

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

  // Duration
  final Duration _animationDuration = const Duration(milliseconds: 300),
      _afterAnimationDelay = const Duration(milliseconds: 300);

  // TODO: INIT STATE
  @override
  void initState() {
    _navScrollController.addListener((){
      final isVisible = _navScrollController.offset > scrHeight;
      if(_navIsStickyNotifier.value != isVisible){
        _navIsStickyNotifier.value = isVisible;
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
      Future.delayed(
          _animationDuration,
              () => setState(() {
            ref.read(isDarkMode.notifier).state =
            !ref.read(isDarkMode); // SET DARK MODE HERE
          }));
      Future.delayed(
        _animationDuration + _afterAnimationDelay,
      () => setState(() {
        _transitionIsActive = !_transitionIsActive;
      })).then(
        (_) => setState((){
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
    setState(
            () => _rectWelcomeSticky = RectGetter.getRectFromKey(_rectKeyWelcomePageSticky));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectWelcomeSticky =
          _rectWelcomeSticky!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(_animationDuration + _afterAnimationDelay,
              () => context.goNamed("welcome"));
    });
  }

  void _pushNamedWithRectCreationSticky() async {
    setState(
            () => _rectCreationSticky = RectGetter.getRectFromKey(_rectKeyCreationPageSticky));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectCreationSticky =
          _rectCreationSticky!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(_animationDuration + _afterAnimationDelay,
              () => context.goNamed("creation"));
    });
  }

  void _pushNamedWithRectFurtherSticky() async {
    setState(
            () => _rectFurtherSticky = RectGetter.getRectFromKey(_rectKeyFurtherPageSticky));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _rectFurtherSticky =
          _rectFurtherSticky!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide));
      Future.delayed(_animationDuration + _afterAnimationDelay,
              () => context.goNamed("further"));
    });
  }

  @override
  Widget build(BuildContext context) {
    scrHeight = MediaQuery.sizeOf(context).height;

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
                      builder: (context, isVisible, child){
                        return SliverPinnedHeader(
                          child: _navTopSticky(isVisible),
                        );
                      },
                    ),
                    _historyPageSection(),
                  ]
              ),
            ],
          ),
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
                borderRadius: BorderRadius.circular(getIsMobileSize(context) ? 0 : 20),
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
    return Stack(
      children: [
        AnimatedPositioned(
          // alignment: (_themeSwitch) ? Alignment.bottomCenter : Alignment.center,
          top: (_themeSwitch) ? 80 : 55,
          left: 0,
          right: 0,
          duration: const Duration(milliseconds: 150),
          child: AnimatedDefaultTextStyle(
            style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 12,
                color: (_themeSwitch)
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
          child: IgnorePointer(
            ignoring: ignoreTapping,
            child: InkWell(
              onHover: (value) {
                setState(() {
                  _themeSwitch = value;
                });
              },
              onTap: () {
                // Dark/Light Mode switch
                switchWithTransition();
              },
              child: Icon(
                (ref.watch(isDarkMode)) ? Icons.dark_mode : Icons.sunny,
                size: 32,
                color: (_themeSwitch)
                    ? (ref.watch(isDarkMode))
                    ? _styleUtil.c_255
                    : _styleUtil.c_24
                    : _styleUtil.c_170,
              ),
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
              "MY HISTORY",
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
              "Discover a brief overview of my recent experiences, offering a glimpse into the journey I've traveled. Explore the key moments that have shaped my path and accomplishments.",
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
                          color: (_navHover[1])
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
                    "History",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: (ref.watch(isDarkMode))
                            ? _styleUtil.c_255
                            : _styleUtil.c_33),
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
      ),
    );
  }

  Widget _navSectionSticky() {
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
                  child: RectGetter(
                    key: _rectKeyCreationPageSticky,
                    child: InkWell(
                      onHover: (value) => setState(() {
                        _navHover[1] = value;
                      }),
                      onTap: () {
                        _pushNamedWithRectCreationSticky();
                      },
                      child: Text(
                        "Creation",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          color: (_navHover[1])
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
                    "History",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: (ref.watch(isDarkMode))
                            ? _styleUtil.c_255
                            : _styleUtil.c_33),
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
      ),
    );
  }

  Widget _quoteContentSection(){
    return Container(
      padding: contentQuotePadding(context),
      height: contentQuoteHeight(context),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(visible: contentQuoteIconVisible(context), child: const SizedBox(width: 32, height: 36, child: Text(""))),
          Text("\"Turn coding into an experience, not just a lesson.\"", style: TextStyle(fontFamily: 'Lato', fontSize: 12, fontStyle: FontStyle.italic, color: _styleUtil.c_170),),
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

  Widget _historySection(){
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
              color: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
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
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 20,
                            color: (ref.watch(isDarkMode)) ? _styleUtil.c_255 : _styleUtil.c_61
                        ),
                      ),
                    ),
                  ),
                  Text("This section narrates the story of my educational and professional journey, tracing the footsteps of learning and self-development.", style: TextStyle(fontFamily: 'Lato', fontSize: 16, color: (ref.watch(isDarkMode)) ? _styleUtil.c_170 : _styleUtil.c_61),),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 132 - 60, top: 60),
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

  // ------ Transition Page -----
  Widget _transitionToWelcomePage(Rect? rectWelcome) {
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
          color: (ref.watch(isDarkMode)) ? _styleUtil.c_61 : _styleUtil.c_170,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _transitionToCreationPage(Rect? rectHistory) {
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
      duration: _animationDuration,
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
            color: (ref.watch(isDarkMode)) ? _styleUtil.c_61 : _styleUtil.c_170,
            shape: BoxShape.rectangle),
      ),
    );
  }
}

class HistoryType extends ConsumerWidget {
  // General
  final StyleUtil _styleUtil = StyleUtil();

  final String titleType;
  final List<HistoryItemData> historyData;

  HistoryType({
    super.key,
    required this.titleType,
    required this.historyData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleType,
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: ref.watch(isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_61,
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: historyData.length,
            itemBuilder: (context, index) {
              return HistoryPath(
                title: historyData[index].historyTitle,
                year: historyData[index].historyYear,
                tag: historyData[index].historyTag,
                desc: historyData[index].historyDescription,
              );
            }
          ),
        ],
      ),
    );
  }
}

class HistoryPath extends ConsumerWidget {
  // General
  StyleUtil _styleUtil = StyleUtil();

  final String title;
  final String year;
  final List<String> tag;
  final String desc;

  HistoryPath({
    super.key,
    required this.title,
    required this.year,
    required this.tag,
    required this.desc,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
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
                    style: TextStyle(fontFamily: 'Lato', fontSize: 24, color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61),
                  ),
                ),
                Text(
                  year,
                  style: TextStyle(fontFamily: 'Lato', fontSize: 20, color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: double.maxFinite,
            height: 1,
            color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61,
          ),
          SizedBox(
            width: double.maxFinite,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: tag.map((item) {
                return Text(
                  item,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 14,
                    color: ref.watch(isDarkMode) ? _styleUtil.c_170 : _styleUtil.c_61
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
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 16,
                color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryScoopeType extends ConsumerWidget {
  // General
  StyleUtil _styleUtil = StyleUtil();

  final String titleHistoryScoope;
  final List<HistoryItemData> historyData;

  HistoryScoopeType({
    super.key,
    required this.titleHistoryScoope,
    required this.historyData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleHistoryScoope,
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: ref.watch(isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_61,
            ),
          ),
          ListView.builder(
            itemCount: historyData.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
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
  // General
  StyleUtil _styleUtil = StyleUtil();

  final String titleHistory;

  SubHistoryScoope({
    super.key,
    required this.titleHistory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 7, left: 28),
      height: 24,
      child: Text(
        titleHistory,
        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 16,
          color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61,
        ),
      ),
    );
  }
}





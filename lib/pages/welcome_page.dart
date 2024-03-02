import 'package:flutter/material.dart';
import 'package:me/Utility/style_util.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final StyleUtil styleUtil = StyleUtil();

  bool githubHover = false, cvHover = false;

  // Nav List Hover
  final List<bool> _navHover = List.generate(4, (index) => index == 0 ? true : false);

  // Open Url
  Future<void> _openUrl(String url) async {
    Uri uri = Uri.parse(url);
    !await launchUrl(uri);
  }

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

  @override
  Widget build(BuildContext context) {
    final scrHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        height: scrHeight,
        padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 90),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80),
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
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Container(
                    // color: Colors.red,
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
        ),
      ),
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
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Hello 👋",
              style: TextStyle(
                fontFamily: "Lato",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: styleUtil.c_61,
                fontFamilyFallback: const [
                  "Apple Color Emoji",
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          height: 96,
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
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          height: 48,
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
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(
          // color: Colors.lightGreenAccent,
          height: 24,
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                InkWell(
                  onHover: (value) {
                    setState(() {
                      githubHover = value;
                    });
                  },
                  onTap: () async {
                    await _showSnackbar("Github Successfully Opened!",
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
                      await _showSnackbar("CV Successfully Opened!",
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "select navigation",
                style: TextStyle(
                    fontFamily: 'Lato', fontSize: 12, color: styleUtil.c_170,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Icon(
                  Icons.arrow_right_sharp,
                  color: styleUtil.c_170,
                  size: 14,
                ),
              ),
            ],
          ),
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
                child: InkWell(
                  onHover: (value) => setState(() {
                    _navHover[1] = value;
                  }),
                  onTap: () {
                    // TODO: Something
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
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: InkWell(
                  onHover: (value) => setState(() {
                    _navHover[2] = value;
                  }),
                  onTap: () {
                    // TODO: Something
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
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: InkWell(
                  onHover: (value) => setState(() {
                    _navHover[3] = value;
                  }),
                  onTap: () {
                    // TODO: Something
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
            ],
          ),
        ],
      ),
    );
  }
}

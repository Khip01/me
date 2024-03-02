import 'package:flutter/material.dart';
import 'package:me/Utility/style_util.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  StyleUtil styleUtil = StyleUtil();

  @override
  Widget build(BuildContext context) {
    final scrHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        height: scrHeight,
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 90),
        child: Container(
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
                child: Container(
                  // color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80),
                    child: _content(),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Container(
                    // color: Colors.blue,
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
          margin: EdgeInsets.only(bottom: 15),
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
                fontFamilyFallback: [
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
          margin: EdgeInsets.only(bottom: 15),
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
          margin: EdgeInsets.only(bottom: 30),
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
        Container(
          // color: Colors.lightGreenAccent,
          height: 24,
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Row(
                  children: [
                    Text(
                      "See My Github Journey",
                      style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: styleUtil.c_170,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.open_in_new,
                        color: styleUtil.c_170,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Text(
                        "See My CV",
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: styleUtil.c_170,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.open_in_new,
                          color: styleUtil.c_170,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

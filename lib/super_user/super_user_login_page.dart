import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:me/service/firebase_auth_services.dart';
import 'package:me/utility/utility.dart';

import '../component/components.dart';

class SuperUserLoginPage extends StatefulWidget {
  const SuperUserLoginPage({super.key});

  @override
  State<SuperUserLoginPage> createState() => _SuperUserLoginPageState();
}

class _SuperUserLoginPageState extends State<SuperUserLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formState = GlobalKey();

  String? _errorEmailText;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: Container(
          color: StyleUtil.c_33,
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            children: [
              Positioned(
                bottom: -30,
                left: -80,
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage(IconUtil.incognitoFingerprint),
                        fit: BoxFit.fill),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                    child: Container(
                      color: Colors.white.withOpacity(0.0),
                    ),
                  ),
                ),
                // ),
              ),
              Positioned(
                top: -100,
                left: 60,
                child: Container(
                  height: 400,
                  width: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage(IconUtil.incognitoMode),
                        fit: BoxFit.fitWidth),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                    child: Container(
                      color: Colors.white.withOpacity(0.0),
                    ),
                  ),
                ),
                // ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 50,
                child: Container(
                  height: 400,
                  width: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage(IconUtil.incognitoMask),
                        fit: BoxFit.fitWidth),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.white.withOpacity(0.0),
                    ),
                  ),
                ),
                // ),
              ),
              Center(
                child: Container(
                  padding: contentCardPadding(context),
                  margin: mainCardPadding(context),
                  constraints: const BoxConstraints(
                    maxWidth: 920,
                  ),
                  width: double.maxFinite,
                  height: 500,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: StyleUtil.c_33,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 61, 61, 61),
                        blurRadius: 80.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "YOU ARE ABOUT TO ENTER A RESTRICTED AREA!",
                          style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: StyleUtil.c_255,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          "If you have control, then confirm your valid credentials below",
                          style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: StyleUtil.c_238,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Form(
                        key: _formState,
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  style: const TextStyle(
                                    fontFamily: "Lato",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: StyleUtil.c_170,
                                  ),
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required";
                                    } else {
                                      if (!EmailValidator.validate(value)) {
                                        return "Please enter a valid credentials";
                                      } else {
                                        return null;
                                      }
                                    }
                                  },
                                  decoration: InputDecoration(
                                    errorText: _errorEmailText,
                                    errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                    hintText: "?????",
                                    hintStyle: const TextStyle(
                                      fontFamily: "Lato",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: StyleUtil.c_170,
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: StyleUtil.c_170, width: 2),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: StyleUtil.c_170, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  style: const TextStyle(
                                    fontFamily: "Lato",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: StyleUtil.c_61,
                                  ),
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    errorText: _errorEmailText,
                                    errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                    hintText: "????????",
                                    hintStyle: const TextStyle(
                                      fontFamily: "Lato",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: StyleUtil.c_170,
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: StyleUtil.c_170, width: 2),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: StyleUtil.c_170, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(right: 10),
                                      width: 100,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          context.goNamed("welcome");
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(7),
                                          ),
                                          surfaceTintColor: StyleUtil.c_255,
                                          foregroundColor: Colors.black,
                                          backgroundColor: StyleUtil.c_255,
                                        ),
                                        child: const Text(
                                          "Back",
                                          style: TextStyle(
                                            fontFamily: "Lato",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: StyleUtil.c_33,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 170,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (_formState.currentState!.validate()) {
                                            // TODO: ACTION AUTH
                                            await FirebaseAuthServices.signIn(_emailController.text, _passwordController.text);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(7),
                                          ),
                                          surfaceTintColor: StyleUtil.c_170,
                                          foregroundColor: Colors.black,
                                          backgroundColor: StyleUtil.c_170,
                                        ),
                                        child: const Text(
                                          "Take a look 👁️👁️",
                                          style: TextStyle(
                                            fontFamily: "Lato",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: StyleUtil.c_33,
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

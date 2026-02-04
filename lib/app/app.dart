import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/app/routes.dart';
import 'package:me/shared/helper/helper.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAppTheme(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromARGB(255, 155, 155, 155),
          selectionColor: Color.fromARGB(255, 194, 194, 194),
          selectionHandleColor: Color.fromARGB(255, 101, 101, 101),
        ),
        // colorSchemeSeed: Color.fromARGB(255, 241, 241, 241),
        // colorScheme: ColorScheme(brightness: Brightness.light, primary: Color.fromARGB(255, 129, 168, 255), onPrimary: Colors.blue, secondary: Colors.white70, onSecondary: Colors.white54, error: Colors.red, onError: Colors.redAccent, background: Colors.white, onBackground: Color.fromARGB(255, 129, 168, 255), surface: Colors.white, onSurface: Colors.black),
      ),
      builder: (BuildContext context, child) => ResponsiveBreakpoints(
        breakpoints: const [
          Breakpoint(start: 0, end: 480, name: MOBILE),
          Breakpoint(start: 481, end: 600, name: TABLET),
          Breakpoint(start: 601, end: 800, name: 'DESKTOP-SM'),
          Breakpoint(start: 801, end: 1100, name: 'DESKTOP-MD'),
          Breakpoint(start: 1101, end: 1920, name: 'DESKTOP-LG'),
          Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: child!,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false, // Remove Debug banner when debugging
    );
  }
}
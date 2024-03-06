import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:me/pages/creation_page.dart';
import 'package:me/pages/further_page.dart';
import 'package:me/pages/history_page.dart';
import 'package:me/pages/not_found_page.dart';
import 'package:me/pages/welcome_page.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    errorBuilder: (context, state){
      return const NotFoundPage();
    },
    routes: [
      GoRoute(path: "/", name: "welcome", builder: (context, state){
        return WelcomePage();
      }),
      GoRoute(path: "/creation", name: "creation", builder: (context, state){
        return const CreationPage();
      }),
      GoRoute(path: "/history", name: "history", builder: (context, state){
        return const HistoryPage();
      }),
      GoRoute(path: "/further", name: "further", builder: (context, state){
        return const FurtherPage();
      }),
    ],
    initialLocation: '/',
    debugLogDiagnostics: true,
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (BuildContext context, child) =>
          ResponsiveBreakpoints(
              child: child!,
              breakpoints: const [
                Breakpoint(start: 0, end: 480, name: MOBILE),
                Breakpoint(start: 481, end: 600, name: TABLET),
                Breakpoint(start: 601, end: 800, name: 'DESKTOP-SM'),
                Breakpoint(start: 801, end: 1100, name: 'DESKTOP-MD'),
                Breakpoint(start: 1101, end: 1920, name: 'DESKTOP-LG'),
                Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ]),
      routerConfig: _router,
      debugShowCheckedModeBanner: false, // Remove Debug banner when debugging
    );
  }
}
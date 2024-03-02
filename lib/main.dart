import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:me/pages/creation_page.dart';
import 'package:me/pages/further_page.dart';
import 'package:me/pages/history_page.dart';
import 'package:me/pages/not_found_page.dart';
import 'package:me/pages/welcome_page.dart';

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
      routerConfig: _router,
      debugShowCheckedModeBanner: false, // Remove Debug banner when debugging
    );
  }
}
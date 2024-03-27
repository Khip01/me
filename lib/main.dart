import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:me/helper/preload_image.dart';
import 'package:me/pages/not_found_page.dart';
import 'package:me/pages/pages.dart';
import 'package:me/transition_setting/default_transition_page.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Firebase Init
  await preloadImage();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  final GoRouter _router = GoRouter(
    errorBuilder: (context, state){
      return const NotFoundPage();
    },
    routes: [
      GoRoute(path: "/", name: "welcome", pageBuilder: (context, state){
        return buildPageWithDefaultTransition(context: context, state: state, child: const WelcomePage());
      }),
      GoRoute(path: "/creation", name: "creation", pageBuilder: (context, state){
        return buildPageWithDefaultTransition(context: context, state: state, child: const CreationPage());
      }),
      GoRoute(path: "/history", name: "history", pageBuilder: (context, state){
        return buildPageWithDefaultTransition(context: context, state: state, child: const HistoryPage());
      }),
      GoRoute(path: "/further", name: "further", pageBuilder: (context, state){
        return buildPageWithDefaultTransition(context: context, state: state, child: const FurtherPage());
      }),
    ],
    initialLocation: '/',
    debugLogDiagnostics: kDebugMode,
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
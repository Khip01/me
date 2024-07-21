import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:me/helper/object_class_finder_by_id.dart';
import 'package:me/helper/helper.dart';
import 'package:me/pages/history_detail_page.dart';
import 'package:me/pages/pages.dart';
import 'package:me/super_user/super_user.dart';
import 'package:me/transition_setting/default_transition_page.dart';
import 'package:me/values/values.dart';
import 'package:responsive_framework/responsive_framework.dart';
// import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // url strategy remove hashtag # on production flutter web
  // setPathUrlStrategy();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Firebase Init
  // Load All Image Icon
  await preloadIconImage();
  // Load Map Creation
  // final CreationController creationController = CreationController();
  // Map<String, dynamic> resultMap = await creationController.getCreationsMap();
  // setCreationMap(resultMap);
  // final creationsMap = await getDataCreationsJson();
  runApp(ProviderScope(child: MyApp()));
}


class MyApp extends ConsumerWidget {
  late final GoRouter _router;

  MyApp({super.key}) {
    _router = GoRouter(
      errorBuilder: (context, state) {
        return const NotFoundPage();
      },
      routes: [
        GoRoute(path: "/", name: "welcome", pageBuilder: (context, state){
          return buildPageWithDefaultTransition(context: context, state: state, child: const WelcomePage());
        }),
        GoRoute(
          path: "/creation",
          name: "creation",
          routes: [
            GoRoute(
              path: "details",
              name: "details_creation",
              pageBuilder: (context, state) {
                // Catch id Parameter Route
                final id = state.uri.queryParameters["id"];
                // Catch Page Name Point to pop
                final pagePopTo = state.extra as String?;

                // Return /creation page if parameter is invalid
                if(id == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.go('/creation');
                    });
                  return MaterialPage(
                    key: state.pageKey,
                    child: const SizedBox.shrink(),
                  );
                }

                // Search Project By ID
                Object? object = findProjectById(id);

                if(object != null && object is ProjectItemData){
                  return buildPageWithDefaultTransition(context: context, state: state, child: CreationDetailPage(selectedProject: object, pagePopTo: pagePopTo,));
                } else {
                  // Mengarahkan kembali ke halaman /creation jika parameter tidak valid / tidak ditemukan data
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.go('/creation');
                  });
                  return MaterialPage(
                    key: state.pageKey,
                    child: const SizedBox.shrink(),
                  );
                }
              },
            ),
          ],
          pageBuilder: (context, state){
            return buildPageWithDefaultTransition(context: context, state: state, child: const CreationPage());
          },
        ),
        GoRoute(
          path: "/history",
          name: "history",
          routes: [
            GoRoute(
              path: "details",
              name: "details_history",
              pageBuilder: (context, state) {
                // Catch the givin query parameter
                // Index
                final index = state.uri.queryParameters["index"];
                // History Item Data Id
                final historyItemDataId = state.uri.queryParameters["id"];

                // Return /creation page if parameter is invalid
                if(index == null || historyItemDataId == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.go('/history');
                  });
                  return MaterialPage(
                    key: state.pageKey,
                    child: const SizedBox.shrink(),
                  );
                }

                // Search HistoryitemData by ID
                Object? object = findHistoryById(historyItemDataId);
                // convert to integer
                int indexInt = int.parse(index);

                if(object != null && object is HistoryItemData && indexInt < object.historyDocumentations!.length && indexInt >= 0){
                  return buildPageWithDefaultTransition(context: context, state: state, child: HistoryDetailPage(index: indexInt, historyData: object));
                } else {
                  // Mengarahkan kembali ke halaman /creation jika parameter tidak valid / tidak ditemukan data
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.go('/history');
                  });
                  return MaterialPage(
                    key: state.pageKey,
                    child: const SizedBox.shrink(),
                  );
                }
              },
            ),
          ],
          pageBuilder: (context, state){
            return buildPageWithDefaultTransition(context: context, state: state, child: const HistoryPage());
          },
        ),
        GoRoute(path: "/further", name: "further", pageBuilder: (context, state){
          return buildPageWithDefaultTransition(context: context, state: state, child: const FurtherPage());
        }),
        GoRoute(path: "/super-user", name: "super-user-login", pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(context: context, state: state, child: const SuperUserBase());
        }),
      ],
      initialLocation: '/',
      debugLogDiagnostics: kDebugMode,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      builder: (BuildContext context, child) =>
          ResponsiveBreakpoints(
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
      routerConfig: _router,
      debugShowCheckedModeBanner: false, // Remove Debug banner when debugging
    );
  }
}

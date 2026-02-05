import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:me/features/404/not_found_page.dart';
import 'package:me/features/creation/screen/creation_detail_page.dart';
import 'package:me/features/creation/screen/creation_page.dart';
import 'package:me/features/further/screen/further_page.dart';
import 'package:me/features/history/screen/history_detail_page.dart';
import 'package:me/features/history/screen/history_page.dart';
import 'package:me/features/welcome/screen/welcome_page.dart';
import 'package:me/shared/helper/helper.dart';
import 'package:me/shared/values/values.dart';
import 'package:me/shared/widget/custom_transition_screen.dart';
import 'package:me/shared/widget/resizable_sidebar_layout.dart';
import 'package:me/shared/widget/sidebar_chat_widget.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ResizableSidebarLayout(
          mainChild: navigationShell,
          sideChild: SidebarChatWidget.sidebarChat(),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/",
              name: "welcome",
              pageBuilder: (context, state) {
                return CustomTransition.fade(
                  context: context,
                  state: state,
                  child: const WelcomePage(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/creation",
              name: "creation",
              pageBuilder: (context, state) {
                return CustomTransition.fade(
                  context: context,
                  state: state,
                  child: const CreationPage(),
                );
              },
              routes: [
                GoRoute(
                  path: "details",
                  name: "details_creation",
                  parentNavigatorKey: _rootNavigatorKey,
                  redirect: (context, state) {
                    final id = state.uri.queryParameters["id"];
                    final ProjectItemData? project = findProjectById(id);

                    return (project == null) ? '/creation' : null;
                  },
                  pageBuilder: (context, state) {
                    final id = state.uri.queryParameters["id"];
                    final ProjectItemData projectItemData =
                        findProjectById(id)!;
                    final pagePopTo = state.extra as String?;

                    return CustomTransition.fade(
                      context: context,
                      state: state,
                      child: CreationDetailPage(
                        selectedProject: projectItemData,
                        pagePopTo: pagePopTo,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/history",
              name: "history",
              pageBuilder: (context, state) {
                return CustomTransition.fade(
                  context: context,
                  state: state,
                  child: const HistoryPage(),
                );
              },
              routes: [
                GoRoute(
                  path: "details",
                  name: "details_history",
                  parentNavigatorKey: _rootNavigatorKey,
                  redirect: (context, state) {
                    final int? index =
                        int.tryParse(state.uri.queryParameters["index"] ?? '');
                    final String? historyId = state.uri.queryParameters["id"];
                    final HistoryItemData? historyData =
                        findHistoryById(historyId);

                    if (index == null || historyData == null) return '/history';

                    final int docsLength =
                        historyData.historyDocumentations?.length ?? 0;
                    if (index < 0 || index >= docsLength) return '/history';

                    return null;
                  },
                  pageBuilder: (context, state) {
                    final int index =
                        int.parse(state.uri.queryParameters["index"] as String);
                    final historyItemDataId = state.uri.queryParameters["id"];
                    final HistoryItemData object =
                        findHistoryById(historyItemDataId)!;

                    return CustomTransition.fade(
                      context: context,
                      state: state,
                      child:
                          HistoryDetailPage(index: index, historyData: object),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/further",
              name: "further",
              pageBuilder: (context, state) {
                return CustomTransition.fade(
                  context: context,
                  state: state,
                  child: const FurtherPage(),
                );
              },
            ),
          ],
        ),
      ],
    ),

    // GoRoute(
    //   path: "/",
    //   name: "welcome",
    //   pageBuilder: (context, state) {
    //     return CustomTransition.fade(
    //         context: context, state: state, child: const WelcomePage());
    //   },
    // ),
    // GoRoute(
    //   path: "/creation",
    //   name: "creation",
    //   routes: [
    //     GoRoute(
    //       path: "details",
    //       name: "details_creation",
    //       redirect: (context, state) {
    //         final id = state.uri.queryParameters["id"];
    //         final ProjectItemData? project = findProjectById(id);
    //
    //         return (project == null) ? '/creation' : null;
    //       },
    //       pageBuilder: (context, state) {
    //         final id = state.uri.queryParameters["id"];
    //         final ProjectItemData projectItemData = findProjectById(id)!;
    //         final pagePopTo = state.extra as String?;
    //
    //         return CustomTransition.fade(
    //           context: context,
    //           state: state,
    //           child: CreationDetailPage(
    //             selectedProject: projectItemData,
    //             pagePopTo: pagePopTo,
    //           ),
    //         );
    //       },
    //     ),
    //   ],
    //   pageBuilder: (context, state) {
    //     return CustomTransition.fade(
    //       context: context,
    //       state: state,
    //       child: const CreationPage(),
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: "/history",
    //   name: "history",
    //   routes: [
    //     GoRoute(
    //       path: "details",
    //       name: "details_history",
    //       redirect: (context, state) {
    //         final int? index =
    //             int.tryParse(state.uri.queryParameters["index"] ?? '');
    //         final String? historyId = state.uri.queryParameters["id"];
    //         final HistoryItemData? historyData = findHistoryById(historyId);
    //
    //         if (index == null || historyData == null) return '/history';
    //
    //         final int docsLength =
    //             historyData.historyDocumentations?.length ?? 0;
    //         if (index < 0 || index >= docsLength) return '/history';
    //
    //         return null;
    //       },
    //       pageBuilder: (context, state) {
    //         final int index =
    //             int.parse(state.uri.queryParameters["index"] as String);
    //         final historyItemDataId = state.uri.queryParameters["id"];
    //         final HistoryItemData object = findHistoryById(historyItemDataId)!;
    //
    //         return CustomTransition.fade(
    //           context: context,
    //           state: state,
    //           child: HistoryDetailPage(index: index, historyData: object),
    //         );
    //       },
    //     ),
    //   ],
    //   pageBuilder: (context, state) {
    //     return CustomTransition.fade(
    //       context: context,
    //       state: state,
    //       child: const HistoryPage(),
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: "/further",
    //   name: "further",
    //   pageBuilder: (context, state) {
    //     return CustomTransition.fade(
    //       context: context,
    //       state: state,
    //       child: const FurtherPage(),
    //     );
    //   },
    // ),
  ],
  errorBuilder: (context, state) {
    return const NotFoundPage();
  },
  debugLogDiagnostics: kDebugMode,
);

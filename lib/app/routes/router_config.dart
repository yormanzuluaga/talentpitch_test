import 'package:talentpitch_test/feature/playlist/view/play_list_page.dart';
import 'package:talentpitch_test/feature/video/view/video_page.dart';
import 'package:talentpitch_ui/talentpitch_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talentpitch_test/app/routes/routes_names.dart';
import 'package:talentpitch_test/feature/home/view/home_page.dart';
import 'package:talentpitch_test/feature/main_dashboard/view/main_dashboard_page.dart';
import 'package:talentpitch_test/feature/main_dashboard/widgets/detail.dart';

part 'router_handlers.dart';

/// Navigator keys
/// The `healthNavigatorKey` is a global key that is used to access the
/// management navigator.
final healthNavigatorKey = GlobalKey<NavigatorState>();
final rootNavigatorKey = GlobalKey<NavigatorState>();
final homeNavigatorKey = GlobalKey<NavigatorState>();

/// The `managementNavigatorKey` is a global key that is used to access the
/// management navigator.
final managementNavigatorKey = GlobalKey<NavigatorState>();

/// The rootScaffoldMessengerKey is a global key that is used to access the
/// rootScaffold navigator.
final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class CustomRouterConfig {
  static final _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: RoutesNames.home,
    errorPageBuilder: (context, state) {
      return NoTransitionPage(
        child: UnderConstruction(title: state.matchedLocation),
      );
    },
    routes: [
      /// Main ShellRoute for authenticated users
      ShellRoute(
        navigatorKey: homeNavigatorKey,
        builder: _homeHandler,
        routes: [
          /// Home route
          GoRoute(
            path: RoutesNames.home,
            parentNavigatorKey: homeNavigatorKey,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: MainDashboardPage(),
              );
            },
          ),
          ShellRoute(
            parentNavigatorKey: homeNavigatorKey,
            navigatorKey: healthNavigatorKey,
            pageBuilder: (context, state, child) {
              return NoTransitionPage(child: child);
            },
            routes: [
              // Web version
              GoRoute(
                path: RoutesNames.playlist,
                parentNavigatorKey: healthNavigatorKey,
                pageBuilder: _playListPageHandler,
              ),
            ],
          ),
          ShellRoute(
            parentNavigatorKey: homeNavigatorKey,
            navigatorKey: managementNavigatorKey,
            pageBuilder: (context, state, child) {
              return NoTransitionPage(child: child);
            },
            routes: [
              // Mobile version
              GoRoute(
                path: RoutesNames.playlist,
                parentNavigatorKey: managementNavigatorKey,
                pageBuilder: _playListPageHandler,
              ),
            ],
          ),
          GoRoute(
            path: RoutesNames.detail,
            parentNavigatorKey: homeNavigatorKey,
            pageBuilder: _detailPageHandler,
          ),

          /// Nested routes (shared structure for both health and management)
        ],
      ),
      GoRoute(
        path: RoutesNames.video,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: _videoPageHandler,
      ),
    ],
  );

  /// Expose the router instance
  GoRouter get router => _router;
}

/// Pop until a specific path
void popUntilPath(String routePath, BuildContext context) {
  final router = GoRouter.of(context);
  while ('${router.routeInformationProvider.value.uri}' != routePath) {
    if (!router.canPop()) return;
    router.pop();
  }
}

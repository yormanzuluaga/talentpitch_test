import 'package:talentpitch_test/feature/main_dashboard/bloc/category_bloc.dart';
import 'package:talentpitch_test/feature/video/bloc/video_bloc.dart';
import 'package:talentpitch_ui/talentpitch_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talentpitch_test/app/routes/routes.dart';
import 'package:talentpitch_test/injection/injection_container.dart' as injection;
import 'package:talentpitch_test/l10n/l10n.dart';
import 'package:talentpitch_test/app/routes/router_config.dart';

/// {@template app}
/// The `App` class is a Dart class that represents the main application
/// and sets up the theme, localization, and routing.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final router = CustomRouterConfig().router;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injection.sl<CategoryBloc>(),
        ),
        BlocProvider(
          create: (_) => injection.sl<VideoBloc>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: const AppTheme().themeData,
            title: 'Talentepitch',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            scaffoldMessengerKey: rootScaffoldMessengerKey,
          );
        },
      ),
    );
  }
}

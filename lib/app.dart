import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/sevices/router/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'database/database.dart';
import 'features/dashboard/bloc/dashboard_bloc.dart' as dashboard;
import 'generated/l10n.dart';

class App extends StatelessWidget {
  const App({super.key, required AppRouter router, required DatabaseHandler databaseHandler})
      : _router = router,
        _databaseHandler = databaseHandler;

  final AppRouter _router;
  final DatabaseHandler _databaseHandler;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _router),
        RepositoryProvider.value(value: _databaseHandler),
        RepositoryProvider(
          create: (_) => dashboard.DashboardBloc(_databaseHandler)..add(dashboard.LoadDataEvent()),
        ),
      ],
      child: MaterialApp.router(
        routeInformationProvider: _router.router.routeInformationProvider,
        routeInformationParser: _router.router.routeInformationParser,
        routerDelegate: _router.router.routerDelegate,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}

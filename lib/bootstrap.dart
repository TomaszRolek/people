import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef BootstrapBuilder = Future<Widget> Function();

Future<void> bootstrap(BootstrapBuilder builder) async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await configureSystemUi();
    FlutterError.onError = (details) {
      if (kDebugMode) {
        print('Bootstrap file error');
        print([details.exceptionAsString(), details.stack]);
      }
    };

    runApp(await builder());

  }, (error, stackTrace) {
    if (kDebugMode) {
      print('Bootstrap file error - run zoned guarded');
      print([error.toString(), stackTrace]);
    }
  });
}

Future<void> configureSystemUi() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

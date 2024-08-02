import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemBarsTheme extends StatelessWidget {
  @override
  const SystemBarsTheme({super.key, required this.child, this.lightNavigation = false, this.lightStatus = false});

  final Widget child;
  final bool lightStatus;
  final bool lightNavigation;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarDividerColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarContrastEnforced: false,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: lightStatus ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness: lightNavigation ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import '../../../widgets/system_bars_theme.dart';

class DashboardWrapper extends StatelessWidget {
  const DashboardWrapper(
      {super.key,
      required this.body,
      this.lightNavigation = false,
      this.lightStatus = false,
      Color? backgroundColor,
      this.bottomNavBar,
      this.disableTopSafeArea = false})
      : backgroundColor = backgroundColor ?? Colors.black;

  final Widget body;
  final bool lightNavigation;
  final bool lightStatus;
  final Color backgroundColor;
  final Widget? bottomNavBar;
  final bool disableTopSafeArea;

  @override
  Widget build(BuildContext context) {
    return SystemBarsTheme(
      lightNavigation: lightNavigation,
      lightStatus: lightStatus,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            top: !disableTopSafeArea,
            child: Stack(children: [
              NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return false;
                },
                child: body,
              ),
            ]),
          ),
          bottomNavigationBar: bottomNavBar,
        ),
      ),
    );
  }
}

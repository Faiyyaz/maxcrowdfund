import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> pushReplacement({
    @required Widget route,
  }) {
    return navigatorKey.currentState.pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => route,
      ),
    );
  }
}

import 'package:amazon_clone/features/auth/screens/auth_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text(
                'Screen does not exist,\ntry to navigate to another valid screen'),
          ),
        ),
      );
  }
}

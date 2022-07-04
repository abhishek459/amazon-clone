import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'features/home/screens/home_screen.dart';
import 'features/screens/auth_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return CupertinoPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('This Page doesn\'t exist :('),
          ),
        ),
      );
  }
}

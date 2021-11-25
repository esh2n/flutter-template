import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import '../setting_page/setting_page.dart';
import '../app_info_page/app_info_page.dart';
import '../home_page/home_page.dart';
import '../tab_scaffold_page/tab_scaffold_page.dart';
import '../not_found_page/not_found_page.dart';

final routeMapProvider = Provider((ref) {
  return RouteMap(
    onUnknownRoute: (path) {
      return MaterialPage<void>(child: NotFoundPage(path));
    },
    routes: {
      // Root
      '/': (route) => const CupertinoTabPage(
            child: TabScaffoldPage(),
            paths: ['/home', '/settings'],
          ),
      // Home
      '/${HomePage.routeName}': (route) =>
          const MaterialPage<void>(child: HomePage()),
      // Home / App info
      '/${HomePage.routeName}/app-info': (route) =>
          const MaterialPage<void>(child: AppInfoPage()),
      // Settings
      '/settings': (route) => const MaterialPage<void>(child: SettingsPage()),
    },
  );
});

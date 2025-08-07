import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../exports.dart'; // Keep your existing import

/// Global route map tracking by index
final Map<int, Route<dynamic>> routeMap = {};

/// Custom Route Observer with reactive route tracking
class CustomRouteObserver extends NavigatorObserver {
  /// Reactive current route name
  RxString currentRoute = ''.obs;

  void _logCurrentAndPreviousRoutes() {
    printTitle('Current and Previous Routes with Indices:');
    routeMap.forEach((index, route) {
      printWhite('$index: ${route.settings.name}');
    });
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    routeMap[routeMap.length] = route;
    _updateCurrentRoute(route);
    _logCurrentAndPreviousRoutes();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _removeRoute(route);
    if (previousRoute != null) {
      _updateCurrentRoute(previousRoute);
    }
    _logCurrentAndPreviousRoutes();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _removeRoute(route);
    _logCurrentAndPreviousRoutes();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) _removeRoute(oldRoute);
    if (newRoute != null) {
      routeMap[routeMap.length] = newRoute;
      _updateCurrentRoute(newRoute);
    }
    _logCurrentAndPreviousRoutes();
  }

  void _removeRoute(Route route) {
    routeMap.removeWhere((index, r) => r == route);
    _reindexRoutes();
  }

  void _reindexRoutes() {
    final Map<int, Route<dynamic>> reindexedMap = {};
    int currentIndex = 0;
    routeMap.forEach((_, route) {
      reindexedMap[currentIndex++] = route;
    });
    routeMap
      ..clear()
      ..addAll(reindexedMap);
  }

  int? getIndexOfRoute(Route<dynamic> route) {
    try {
      return routeMap.entries.firstWhere((entry) => entry.value == route).key;
    } catch (e) {
      return null;
    }
  }

  Route<dynamic>? getRouteAtIndex(int index) {
    return routeMap[index];
  }

  /// Update the current route observable
  void _updateCurrentRoute(Route route) {
    final routeName = route.settings.name ?? '';

    currentRoute.value = routeName;

    printOkStatus(currentRoute.value);
  }
}

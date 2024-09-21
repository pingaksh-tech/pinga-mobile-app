import 'package:flutter/material.dart';

class GlobalContext {
  GlobalContext._();

  factory GlobalContext() => _instance;

  static GlobalContext get instance => _instance;

  static final GlobalContext _instance = GlobalContext._();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  BuildContext get globalContext => navigatorKey.currentContext!;
}

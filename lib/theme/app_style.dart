import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/handler/app_environment.dart';
import '../exports.dart';

/// Is used to enable the developer options to show the debug information ,logs, extra calculations, etc in the app.
bool developerOptions = AppEnvironment.environmentType != EnvironmentType.production && kDebugMode; //! If is TURN ON the developer options, it will increase the performance of the app.

double defaultPadding = 16.0;
double defaultRadius = 10.0;
double navigationBarSpacing = (defaultPadding / 2).h;

double defaultTopPadding = ScreenUtil().statusBarHeight + defaultPadding;
double defaultBottomPadding = ScreenUtil().bottomBarHeight == 0.0 ? defaultPadding : ScreenUtil().bottomBarHeight + 6.h;

double appButtonHeight = 48.w;

Color get shadowColor => AppColors.lightGrey.withOpacity(0.1);

BoxShadow boxShadow({required offset}) {
  return BoxShadow(
    color: shadowColor,
    blurRadius: 3,
    spreadRadius: 0.5,
    offset: offset,
  );
}

List<BoxShadow> defaultShadow(BuildContext context) => [
      BoxShadow(color: Theme.of(context).iconTheme.color!.withOpacity(0.03), blurRadius: 4, spreadRadius: 3),
    ];

List<BoxShadow> get defaultShadowAllSide => [
      boxShadow(offset: const Offset(-4, -4)),
      boxShadow(offset: const Offset(4, 4)),
      boxShadow(offset: const Offset(-4, 4)),
      boxShadow(offset: const Offset(4, -4)),
    ];

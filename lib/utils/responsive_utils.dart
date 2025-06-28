import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveUtils {
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 900;
  static const double _desktopBreakpoint = 1200;

  /// Check if current screen is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < _mobileBreakpoint;
  }

  /// Check if current screen is tablet
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= _mobileBreakpoint && MediaQuery.of(context).size.width < _tabletBreakpoint;
  }

  /// Check if current screen is large tablet/desktop
  static bool isLargeTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= _tabletBreakpoint && MediaQuery.of(context).size.width < _desktopBreakpoint;
  }

  /// Check if current screen is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= _desktopBreakpoint;
  }

  /// Get responsive padding based on screen size
  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isMobile(context)) {
      return EdgeInsets.all(16.w);
    } else if (isTablet(context)) {
      return EdgeInsets.all(24.w);
    } else if (isLargeTablet(context)) {
      return EdgeInsets.all(32.w);
    } else {
      return EdgeInsets.all(40.w);
    }
  }

  /// Get responsive margin based on screen size
  static EdgeInsets getResponsiveMargin(BuildContext context) {
    if (isMobile(context)) {
      return EdgeInsets.all(8.w);
    } else if (isTablet(context)) {
      return EdgeInsets.all(16.w);
    } else if (isLargeTablet(context)) {
      return EdgeInsets.all(24.w);
    } else {
      return EdgeInsets.all(32.w);
    }
  }

  /// Get responsive font size multiplier
  static double getFontSizeMultiplier(BuildContext context) {
    if (isMobile(context)) {
      return 1.0;
    } else if (isTablet(context)) {
      return 1.2;
    } else if (isLargeTablet(context)) {
      return 1.4;
    } else {
      return 1.6;
    }
  }

  /// Get responsive grid cross axis count
  static int getGridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) {
      return 2;
    } else if (isTablet(context)) {
      return 3;
    } else if (isLargeTablet(context)) {
      return 4;
    } else {
      return 5;
    }
  }

  /// Get responsive drawer width
  static double getDrawerWidth(BuildContext context) {
    if (isMobile(context)) {
      return MediaQuery.of(context).size.width * 0.75;
    } else if (isTablet(context)) {
      return MediaQuery.of(context).size.width * 0.4;
    } else if (isLargeTablet(context)) {
      return MediaQuery.of(context).size.width * 0.3;
    } else {
      return MediaQuery.of(context).size.width * 0.25;
    }
  }

  /// Get responsive bottom navigation height
  static double getBottomNavHeight(BuildContext context) {
    if (isMobile(context)) {
      return 60.h;
    } else if (isTablet(context)) {
      return 70.h;
    } else if (isLargeTablet(context)) {
      return 80.h;
    } else {
      return 90.h;
    }
  }

  /// Get responsive app bar height
  static double getAppBarHeight(BuildContext context) {
    if (isMobile(context)) {
      return 56.h;
    } else if (isTablet(context)) {
      return 64.h;
    } else if (isLargeTablet(context)) {
      return 72.h;
    } else {
      return 80.h;
    }
  }

  /// Get responsive icon size
  static double getIconSize(BuildContext context) {
    if (isMobile(context)) {
      return 24.w;
    } else if (isTablet(context)) {
      return 28.w;
    } else if (isLargeTablet(context)) {
      return 32.w;
    } else {
      return 36.w;
    }
  }

  /// Get responsive button height
  static double getButtonHeight(BuildContext context) {
    if (isMobile(context)) {
      return 48.h;
    } else if (isTablet(context)) {
      return 56.h;
    } else if (isLargeTablet(context)) {
      return 64.h;
    } else {
      return 72.h;
    }
  }

  /// Get responsive border radius
  static double getBorderRadius(BuildContext context) {
    if (isMobile(context)) {
      return 8.r;
    } else if (isTablet(context)) {
      return 12.r;
    } else if (isLargeTablet(context)) {
      return 16.r;
    } else {
      return 20.r;
    }
  }

  /// Get responsive spacing
  static double getSpacing(BuildContext context) {
    if (isMobile(context)) {
      return 16.w;
    } else if (isTablet(context)) {
      return 24.w;
    } else if (isLargeTablet(context)) {
      return 32.w;
    } else {
      return 40.w;
    }
  }

  /// Get responsive aspect ratio for images
  static double getImageAspectRatio(BuildContext context) {
    if (isMobile(context)) {
      return 1.0;
    } else if (isTablet(context)) {
      return 1.2;
    } else if (isLargeTablet(context)) {
      return 1.4;
    } else {
      return 1.6;
    }
  }

  /// Get responsive max width for content
  static double getMaxContentWidth(BuildContext context) {
    if (isMobile(context)) {
      return double.infinity;
    } else if (isTablet(context)) {
      return 600.w;
    } else if (isLargeTablet(context)) {
      return 800.w;
    } else {
      return 1000.w;
    }
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Get device pixel ratio
  static double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// Get screen size category
  static String getScreenSizeCategory(BuildContext context) {
    if (isMobile(context)) return 'mobile';
    if (isTablet(context)) return 'tablet';
    if (isLargeTablet(context)) return 'large_tablet';
    return 'desktop';
  }
}

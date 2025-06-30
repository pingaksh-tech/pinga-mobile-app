import 'package:flutter/material.dart';

enum DeviceType {
  mobile,
  mediumTablet,
  largeTablet,
}

class DeviceUtil {
  /// Determines if the device is a tablet (any size)
  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.shortestSide >= 768; // Tablets generally have a minimum width of 600dp
  }

  /// Determines the specific device type: Mobile, Medium Tablet, or Large Tablet
  static DeviceType getDeviceType(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.shortestSide >= 900) {
      return DeviceType.largeTablet; // Large tablets have a minimum width of 900dp
    } else if (size.shortestSide >= 600) {
      return DeviceType.mediumTablet; // Medium tablets range from 600dp to 899dp
    } else {
      return DeviceType.mobile; // Anything below 600dp is considered mobile
    }
  }

  /// Returns the appropriate design size for ScreenUtil initialization
  static Size getDesignSize(BuildContext context) {
    switch (getDeviceType(context)) {
      case DeviceType.largeTablet:
        return const Size(1024, 1366); // Large tablet design size
      case DeviceType.mediumTablet:
        return const Size(768, 1024); // Medium tablet design size
      case DeviceType.mobile:
        return const Size(360, 690); // Mobile design size
    }
  }
}

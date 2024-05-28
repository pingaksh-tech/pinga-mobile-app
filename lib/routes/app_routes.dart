class AppRoutes {
  AppRoutes._();

  //* * * * * * * * * * * Examples of using GETX route management * * * * * * * * * * *//

  //? Navigating to a named route:
  /// Get.to('/splash-screen');

  //? Without using routes you can do this:
  /// Get.to(()=> const SecondScreen());

  //? Pushing a new route on top of the current route:
  /// Get.toNamed('/splash-screen'); OR Get.toNamed(AppRoutes.splashScreen);

  //? To go to the next screen and no option to go back to the previous screen (for use in SplashScreens, login views, etc.)
  /// Get.off(NextScreen());

  //? To go to the next screen and cancel all previous routes (useful in shopping carts, polls, and tests)
  /// Get.offAll(NextScreen());

  //? Popping to a specific route:
  /// Get.offAllNamed('/splash-screen'); OR Get.offAllNamed(AppRoutes.splashScreen);

  //? To close snackbar, dialogs, bottomSheets, or anything you would normally close with Navigator.pop(context);
  /// Get.back();

  //* * * * * * * * * * * * * * * * * Define all routes * * * * * * * * * * * * * * * * *//

  //? Ex. Bottombar is a Component so it's called the VIEW and the other is a screen.

  /// ***********************************************************************************
  /// *                                COMMON PAGES                                     *
  /// ***********************************************************************************
  static const String navigationBarScreen = '/navigation-bar-screen';

  /// ***********************************************************************************
  /// *                         AUTH AND ONBOARDING PAGES                               *
  /// ***********************************************************************************
  static const String splashScreen = '/splash-screen';
  static const String loginScreen = '/login-screen';

  /// ***********************************************************************************
  ///                                 HOME MODULE
  /// ***********************************************************************************
  static const String dashboardScreen = '/dashboard-screen';
}

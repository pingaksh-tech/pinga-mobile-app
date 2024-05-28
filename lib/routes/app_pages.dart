import 'package:get/get.dart';

import '../view/dashboard/dashboard_screen.dart';
import '../view/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  /// Function to define a GetPage route
  static GetPage<dynamic> _getPage({required String name, required GetPageBuilder page, Bindings? binding, List<GetPage<dynamic>>? children}) {
    return GetPage(
      name: name,
      page: page,
      binding: binding,
      children: children ?? [],
    );
  }

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    _getPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    // _getPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    _getPage(name: AppRoutes.dashboardScreen, page: () => DashboardScreen()),

    // // _getPage(name: AppRoutes.navigationBarScreen, page: () => NavigationBarScreen()),
    // // _getPage(name: AppRoutes.registerScreen, page: () => RegisterScreen()),
  ];
}

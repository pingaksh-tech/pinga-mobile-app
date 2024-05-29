import 'package:get/get.dart';
import 'package:pingaksh_mobile/view/bottombar/bottombar_screen.dart';
import 'package:pingaksh_mobile/view/home/widgets/category/category_screen.dart';
import 'package:pingaksh_mobile/view/home/widgets/product/product_screen.dart';

import '../view/auth_flow/auth_screen.dart';
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
    _getPage(name: AppRoutes.authScreen, page: () => AuthScreen()),
    _getPage(name: AppRoutes.dashboardScreen, page: () => DashboardScreen()),
    _getPage(name: AppRoutes.bottomBarScreen, page: () => BottomBarScreen()),
    _getPage(name: AppRoutes.categoryScreen, page: () => CategoryScreen()),
    _getPage(name: AppRoutes.productScreen, page: () => ProductScreen()),

    // // _getPage(name: AppRoutes.navigationBarScreen, page: () => NavigationBarScreen()),
    // // _getPage(name: AppRoutes.registerScreen, page: () => RegisterScreen()),
  ];
}

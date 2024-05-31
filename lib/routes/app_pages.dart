import 'package:get/get.dart';
import 'package:pingaksh_mobile/view/bottombar/bottombar_screen.dart';
import 'package:pingaksh_mobile/view/category/category_screen.dart';
import 'package:pingaksh_mobile/view/collections/watch_list/watch_list_screen.dart';
import 'package:pingaksh_mobile/view/collections/widgets/add_watchlist/add_watchlist_screen.dart';
import 'package:pingaksh_mobile/view/product/product_screen.dart';
import 'package:pingaksh_mobile/view/product/widgets/filter/filter_screen.dart';

import '../view/auth_flow/auth_screen.dart';
import '../view/cart/cart_screen.dart';
import '../view/dashboard/dashboard_screen.dart';
import '../view/product_details/product_details_screen.dart';
import '../view/profile/profile_screen.dart';
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
    _getPage(name: AppRoutes.profileScreen, page: () => ProfileScreen()),
    _getPage(name: AppRoutes.cartScreen, page: () => CartScreen()),
    _getPage(name: AppRoutes.productDetailsScreen, page: () => ProductDetailsScreen()),
    _getPage(name: AppRoutes.filterScreen, page: () => FilterScreen()),
    _getPage(name: AppRoutes.watchListScreen, page: () => WatchListScreen()),
    _getPage(name: AppRoutes.addWatchListScreen, page: () => AddWatchlistScreen()),
  ];
}

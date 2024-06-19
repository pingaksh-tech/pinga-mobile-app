import 'package:get/get.dart';

import '../view/auth_flow/auth_screen.dart';
import '../view/bottombar/bottombar_screen.dart';
import '../view/cart/cart_screen.dart';
import '../view/cart/widget/stock/cart_stock_screen.dart';
import '../view/cart/widget/summary/summary_screen.dart';
import '../view/category/category_screen.dart';
import '../view/collections/watch_list/watch_list_screen.dart';
import '../view/collections/widgets/add_watchlist/add_watchlist_screen.dart';
import '../view/common/under_maintenance/under_maintenance_screen.dart';
import '../view/dashboard/dashboard_screen.dart';
import '../view/drawer/widgets/catalog/catalogue_screen.dart';
import '../view/drawer/widgets/feedback/feedback_history/feedback_history_screen.dart';
import '../view/drawer/widgets/feedback/feedback_screen.dart';
import '../view/drawer/widgets/pdf_viewer/pdf_viewer.dart';
import '../view/drawer/widgets/settings/settings_screen.dart';
import '../view/drawer/widgets/wishlist/wishlist_screen.dart';
import '../view/orders/widgets/order_filter/order_filter_screen.dart';
import '../view/product_details/product_details_screen.dart';
import '../view/product_details/widgets/image_view/image_view_screen.dart';
import '../view/products/product_screen.dart';
import '../view/products/widgets/filter/filter_screen.dart';
import '../view/products/widgets/variant/variant_screen.dart';
import '../view/profile/profile_screen.dart';
import '../view/splash/splash_screen.dart';
import '../widgets/add_remark/add_remark_screen.dart';
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
    _getPage(name: AppRoutes.underMaintenanceScreen, page: () => const UnderMaintenanceScreen()),
    _getPage(name: AppRoutes.categoryScreen, page: () => CategoryScreen()),
    _getPage(name: AppRoutes.productScreen, page: () => ProductScreen()),
    _getPage(name: AppRoutes.profileScreen, page: () => ProfileScreen()),
    _getPage(name: AppRoutes.cartScreen, page: () => CartScreen()),
    _getPage(name: AppRoutes.productDetailsScreen, page: () => ProductDetailsScreen()),
    _getPage(name: AppRoutes.filterScreen, page: () => FilterScreen()),
    _getPage(name: AppRoutes.watchListScreen, page: () => WatchListScreen()),
    _getPage(name: AppRoutes.addWatchListScreen, page: () => AddWatchlistScreen()),
    _getPage(name: AppRoutes.remarkScreen, page: () => AddRemarkScreen()),
    _getPage(name: AppRoutes.cartStockScreen, page: () => CartStockScreen()),
    _getPage(name: AppRoutes.summaryScreen, page: () => SummaryScreen()),
    _getPage(name: AppRoutes.variantsScreen, page: () => VariantScreen()),
    _getPage(name: AppRoutes.imageViewScreen, page: () => ImageViewScreen()),
    _getPage(name: AppRoutes.wishlistScreen, page: () => WishlistScreen()),
    _getPage(name: AppRoutes.settingsScreen, page: () => SettingsScreen()),
    _getPage(name: AppRoutes.orderFilterScreen, page: () => OrderFilterScreen()),
    _getPage(name: AppRoutes.feedbackScreen, page: () => FeedbackScreen()),
    _getPage(name: AppRoutes.feedbackHistoryScreen, page: () => FeedbackHistoryScreen()),
    _getPage(name: AppRoutes.catalogueScreen, page: () => CatalogueScreen()),
    _getPage(name: AppRoutes.pdfViewerScreen, page: () => PdfViewerScreen()),
  ];
}

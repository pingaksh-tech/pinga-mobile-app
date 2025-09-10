import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/predefine_value_controller.dart';
import 'data/services/notification/firebase_notification_service.dart';
import 'exports.dart';
import 'firebase_options.dart';
import 'utils/custom_route_observer.dart';
import 'utils/device_utils.dart';
import 'utils/global_context.dart';

// import 'view/cart/cart_controller.dart';
// import 'view/home/home_controller.dart';
import 'view/orders/widgets/order_filter/order_filter_controller.dart';
import 'view/products/widgets/filter/filter_controller.dart';
import 'widgets/stretch_scroll_behavior.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init().then((value) async => await LocalStorage.readDataInfo());

  // Set orientation - allow both for better tablet support
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await NotificationsHelper.init();
  await FirebaseNotificationService.initialise();
  FirebaseMessaging.onBackgroundMessage(FirebaseNotificationService.firebaseMessagingBackgroundHandler);

  /// ✅ Register the CustomRouteObserver once here
  final customObserver = CustomRouteObserver();
  Get.put(customObserver);

  /// ✅ Manually sync initial route
  WidgetsBinding.instance.addPostFrameCallback((_) {
    customObserver.currentRoute.value = Get.currentRoute;
    printWarning("✅ Initial route manually synced to: ${Get.currentRoute}");
  });

  runApp(MyApp(customObserver: customObserver));
}

class MyApp extends StatelessWidget {
  final CustomRouteObserver? customObserver;

  const MyApp({super.key, this.customObserver});

  @override
  Widget build(BuildContext context) {
    LocalStorage.printLocalStorageData();
    return LayoutBuilder(
      builder: (context, constraints) {
        final designSize = DeviceUtil.getDesignSize(context);
        return ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return GetMaterialApp(
              title: AppStrings.appName.value,
              debugShowCheckedModeBanner: false,
              initialBinding: BaseBinding(),
              themeMode: ThemeMode.light,
              navigatorKey: GlobalContext.instance.navigatorKey,
              theme: AppTheme.lightMode(
                context,
                kPrimaryColor: LocalStorage.primaryColor,
                kSecondaryColor: LocalStorage.secondaryColor,
                errorColor: AppColors.error,
                fontFamily: AppTheme.fontFamilyName,
              ),
              darkTheme: AppTheme.darkMode(
                context,
                kPrimaryColor: LocalStorage.primaryColor,
                kSecondaryColor: LocalStorage.secondaryColor,
                errorColor: AppColors.error,
                fontFamily: AppTheme.fontFamilyName,
              ),
              scrollBehavior: ScrollBehaviorModified(),
              getPages: AppPages.pages,
              initialRoute: AppRoutes.splashScreen,

              /// ✅ Use the passed-in observer
              navigatorObservers: customObserver != null ? [customObserver!] : [],
            );
          },
        );
      },
    );
  }
}

class BaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BaseController(), permanent: true);
    Get.put(PreDefinedValueController(), permanent: true);
    Get.put(FilterController(), permanent: true);
    Get.put(OrderFilterController(), permanent: true);
    // Get.put(HomeController(), permanent: true);
    // Get.put(CartController(), permanent: true);
    // Get.lazyPut(() => CartController(), fenix: true);
  }
}

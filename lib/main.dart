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
import 'data/services/notification/notification_helper.dart';
import 'exports.dart';
import 'firebase_options.dart';
import 'utils/custom_route_observer.dart';
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
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationsHelper.init();
  await FirebaseNotificationService.initialise();
  FirebaseMessaging.onBackgroundMessage(FirebaseNotificationService.firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalStorage.printLocalStorageData();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          title: AppStrings.appName.value,
          debugShowCheckedModeBanner: false,
          initialBinding: BaseBinding(),
          themeMode: ThemeMode.light,
          navigatorKey: GlobalContext.instance.navigatorKey,
          theme: AppTheme.lightMode(context, kPrimaryColor: LocalStorage.primaryColor, kSecondaryColor: LocalStorage.secondaryColor, errorColor: AppColors.error, fontFamily: AppTheme.fontFamilyName),
          darkTheme: AppTheme.darkMode(context, kPrimaryColor: LocalStorage.primaryColor, kSecondaryColor: LocalStorage.secondaryColor, errorColor: AppColors.error, fontFamily: AppTheme.fontFamilyName),
          scrollBehavior: ScrollBehaviorModified(),
          getPages: AppPages.pages,
          initialRoute: AppRoutes.splashScreen,
          navigatorObservers: [CustomRouteObserver()],
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

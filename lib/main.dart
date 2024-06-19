import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'exports.dart';
import 'utils/global_context.dart';
import 'widgets/stretch_scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init().then((value) async => await LocalStorage.readDataInfo());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
        );
      },
    );
  }
}

class BaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BaseController(), permanent: true);
  }
}

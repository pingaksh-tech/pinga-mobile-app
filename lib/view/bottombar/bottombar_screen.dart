// ignore_for_file: deprecated_member_use

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/controller/dialog_controller.dart';
import 'package:pingaksh_mobile/res/app_bar.dart';
import 'package:pingaksh_mobile/view/bottombar/components/app_drawer.dart';

import '../../exports.dart';
import '../../packages/app_animated_cliprect.dart';
import 'bottombar_controller.dart';

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({super.key});

  final BottomBarController con = Get.put(BottomBarController());
  final DialogController dialogCon = Get.put(DialogController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (con.currentBottomIndex.value != 0) {
          con.isLoggedIn.value = false;
          con.currentBottomIndex.value = 0;
        } else {
          // AppDialogs.backOperation(context);
        }
        return false;
      },
      child: Obx(
        () => AnnotatedRegion<SystemUiOverlayStyle>(
          value: UiUtils.systemUiOverlayStyle(systemNavigationBarColor: Theme.of(context).colorScheme.surface),
          child: Scaffold(
            drawer: const AppDrawer(),
            appBar: MyAppBar(
              showBackIcon: false,
              title: con.bottomBarDataList[con.currentBottomIndex.value].screenName,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: SvgPicture.asset(AppAssets.menuIcon),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
            body: con.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView.separated(
                      itemCount: 15,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                      itemBuilder: (context, index) {
                        return ShimmerUtils.shimmer(
                          child: ShimmerUtils.shimmerContainer(
                            height: 70,
                            width: Get.width,
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                        );
                      },
                    ),
                  )
                : PageTransitionSwitcher(
                    reverse: con.isLoggedIn.value,
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                    ) {
                      return SharedAxisTransition(
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: con.transitionType!,
                        fillColor: const Color(0x00FFFFFF),
                        child: child,
                      );
                    },
                    child: con.bottomBarDataList.isNotEmpty ? con.bottomBarDataList[con.currentBottomIndex.value].screenWidget! : const SizedBox(),
                  ),
            bottomNavigationBar: Obx(
              () => con.bottomBarDataList.length >= 2
                  ? IntrinsicHeight(
                      child: BottomAppBar(
                        notchMargin: 6,
                        color: Theme.of(context).colorScheme.surface,
                        padding: EdgeInsets.symmetric(vertical: defaultPadding / 1.2, horizontal: defaultPadding / 2),
                        shape: const CircularNotchedRectangle(),
                        child: Obx(
                          () => Row(
                            children: List.generate(
                              con.bottomBarDataList.length,
                              (index) => Expanded(
                                child: InkWell(
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  onTap: () {
                                    con.onBottomBarTap(index, hapticFeedback: true);
                                  },
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 250),
                                          padding: EdgeInsets.all(defaultPadding / 1.5),
                                          decoration: BoxDecoration(
                                            color: con.currentBottomIndex.value == index ? Theme.of(context).primaryColor : null,
                                            border: Border.all(color: con.currentBottomIndex.value == index ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.surface, strokeAlign: 5),
                                            shape: BoxShape.circle,
                                          ),
                                          child: con.currentBottomIndex.value == index
                                              ? (isValEmpty(con.bottomBarDataList[index].bottomItem?.selectedImage)
                                                  ? Icon(
                                                      con.bottomBarDataList[index].bottomItem?.selectedIcon,
                                                      size: con.bottomBarDataList[index].bottomItem?.selectedSize,
                                                      color: AppColors.lightSecondary,
                                                    )
                                                  : SvgPicture.asset(
                                                      con.bottomBarDataList[index].bottomItem?.selectedImage ?? "",
                                                      height: con.bottomBarDataList[index].bottomItem?.selectedSize ?? 21,
                                                      color: AppColors.lightSecondary,
                                                    ))
                                              : isValEmpty(con.bottomBarDataList[index].bottomItem?.selectedImage)
                                                  ? Icon(
                                                      con.bottomBarDataList[index].bottomItem?.unselectIcon ?? con.bottomBarDataList[index].bottomItem?.selectedIcon,
                                                      size: con.bottomBarDataList[index].bottomItem?.unselectSize,
                                                      color: Theme.of(context).primaryColor.withOpacity(.9),
                                                    )
                                                  : SvgPicture.asset(
                                                      con.bottomBarDataList[index].bottomItem?.unselectImage ?? con.bottomBarDataList[index].bottomItem?.selectedImage ?? "",
                                                      height: con.bottomBarDataList[index].bottomItem?.unselectSize ?? 21,
                                                      color: Theme.of(context).primaryColor.withOpacity(.9),
                                                    ),
                                        ),
                                        AnimatedClipRect(
                                          open: con.currentBottomIndex.value != index,
                                          child: Text(
                                            con.bottomBarDataList[index].screenName ?? "",
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                  color: Theme.of(context).primaryColor.withOpacity(.9),
                                                  fontSize: 9.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}

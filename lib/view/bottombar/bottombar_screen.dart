// ignore_for_file: deprecated_member_use

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import '../../res/app_colors.dart';
import '../../utils/utils.dart';
import 'bottombar_controller.dart';

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({super.key});

  final BottomBarController con = Get.put(BottomBarController());

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
      child: Obx(() => Scaffold(
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
                      child: Container(
                        color: Theme.of(context).colorScheme.background,
                        child: BottomAppBar(
                          notchMargin: 6,
                          padding: EdgeInsets.symmetric(vertical: defaultPadding / 1.2),
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
                                            padding: EdgeInsets.all(defaultPadding / 1.3),
                                            decoration: BoxDecoration(
                                              color: con.currentBottomIndex.value == index ? Theme.of(context).primaryColor : Theme.of(context).scaffoldBackgroundColor,
                                              border: Border.all(color: con.currentBottomIndex.value == index ? Theme.of(context).primaryColor : Theme.of(context).scaffoldBackgroundColor, strokeAlign: 5),
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
                                          // Text(
                                          //   StrExtension.capitalize(con.bottomBarDataList[index].screenName ?? ""),
                                          //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          //         color: con.currentBottomIndex.value == index ? AppColors.goldColor : Theme.of(context).primaryColor.withOpacity(.9),
                                          //         fontSize: 13,
                                          //         fontWeight: FontWeight.w600,
                                          //       ),
                                          // ),
                                        ],
                                      ),
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
          )),
    );
  }
}

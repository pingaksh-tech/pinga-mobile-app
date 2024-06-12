import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../packages/cached_network_image/cached_network_image.dart';
import '../../packages/app_animated_cliprect.dart';
import '../../res/app_dialog.dart';
import '../../widgets/webview.dart';
import 'app_drawer_controller.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback? homeOnPressed;

  AppDrawer({super.key, this.homeOnPressed});

  final AppDrawerController con = Get.put(AppDrawerController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(() {
        return ListView(
          padding: EdgeInsets.zero,
          physics: const RangeMaintainingScrollPhysics(),
          children: [
            /// Drawer Header
            Stack(
              children: [
                const DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: AppNetworkImage(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    fit: BoxFit.cover,
                    imageUrl: 'https://media.designrush.com/tinymce_images/316674/conversions/Desiree-Qelaj-content.jpg',
                  ),
                ),
                // AppNetworkImage(
                //   height: 60.h,
                //   imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVErxeqhTxrd4NYxO73norO2MWmwcziMvFWg&s',
                //   padding: EdgeInsets.only(top: defaultPadding * 8.5),
                //   shape: BoxShape.circle,
                // ),
                Positioned(
                  top: defaultPadding * 9,
                  right: defaultPadding,
                  child: Text(
                    "",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(),
                  ),
                )
              ],
            ),

            ListTile(
              leading: SvgPicture.asset(
                AppAssets.homeOutlinedSVG,
                height: 16.h,
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              title: Text(
                "Home",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: homeOnPressed,
            ),
            const Divider(height: 1),
            ListTile(
                leading: SvgPicture.asset(
                  AppAssets.like,
                  height: 16.h,
                  colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                ),
                title: Text(
                  "Wishlist",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.wishlistScreen);
                }),
            const Divider(height: 1),

            /// My Catalog
            ListTile(
              leading: SvgPicture.asset(
                AppAssets.catalogIcon,
                height: 16.h,
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              title: Text(
                "My Catalog",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.catalogueScreen);
              },
            ),
            const Divider(height: 1),

            /// My Catalog
            ListTile(
                leading: SvgPicture.asset(
                  AppAssets.settingIcon,
                  height: 16.h,
                  colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                ),
                title: Text(
                  "Setting",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.settingsScreen);
                }),
            const Divider(height: 1),

            /// Customer Care
            ListTile(
              leading: SvgPicture.asset(
                AppAssets.customerCareIcon,
                height: 16.h,
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              title: Text(
                "Customer Care",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: SvgPicture.asset(
                con.isShowCare.isTrue ? AppAssets.upArrow : AppAssets.downArrow,
                height: 8,
              ),
              onTap: () {
                con.isShowCare.value = !con.isShowCare.value;
              },
            ),

            AnimatedClipRect(
              open: con.isShowCare.value,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Column(
                  children: [
                    const Divider(height: 1, indent: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        40.horizontalSpace,
                        Text(
                          "Contact us On",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13.sp),
                        ),
                        const Spacer(),
                        AppIconButton(
                          size: 40,
                          icon: Icon(
                            Icons.call,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                          onPressed: () => makePhoneCall('+91 9409349493'),
                        ),
                        AppIconButton(
                          size: 40,
                          onPressed: () => sendEmail("demo@gmail.com"),
                          icon: Icon(
                            Icons.email_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 22,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),

            /// Policies
            ListTile(
              leading: SvgPicture.asset(
                AppAssets.policiesIcon,
                height: 16.h,
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              title: Text(
                "Policies",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: SvgPicture.asset(
                con.isShowPolicies.isTrue ? AppAssets.upArrow : AppAssets.downArrow,
                height: 8,
              ),
              onTap: () {
                con.isShowPolicies.value = !con.isShowPolicies.value;
              },
            ),

            /// Policies Sub Option
            AnimatedClipRect(
              open: con.isShowPolicies.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 1),

                  /// Privacy Policy
                  subOptionTile(context, icon: AppAssets.productDetailSVG, title: "Privacy Policy", onPressed: () {
                    Get.back();
                    Get.to(const MyWebView(title: "Privacy Policy", webURL: "https://api.flutter.dev/flutter/material/Switch/thumbColor.html"));
                  }),

                  const Divider(height: 1, indent: 40),

                  /// Return Policy
                  subOptionTile(context, icon: AppAssets.rtp, title: "Return Policy", onPressed: () {
                    Get.back();
                    Get.to(const MyWebView(title: "Return Policy", webURL: "https://api.flutter.dev/flutter/material/Switch/thumbColor.html"));
                  }),
                ],
              ),
            ),
            const Divider(height: 1),

            /// Feedback
            ListTile(
              leading: SvgPicture.asset(
                AppAssets.feedbackIcon,
                height: 16.h,
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              title: Text(
                "Feedback",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: SvgPicture.asset(
                con.isShowFeedback.isTrue ? AppAssets.upArrow : AppAssets.downArrow,
                height: 8,
              ),
              onTap: () {
                con.isShowFeedback.value = !con.isShowFeedback.value;
              },
            ),

            /// Feedback Sub Option
            AnimatedClipRect(
              open: con.isShowFeedback.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 1),

                  /// Add Feedback
                  subOptionTile(context, icon: AppAssets.addFeedbackSVG, title: "Add Feedback", onPressed: () {
                    Get.back();
                    Get.toNamed(AppRoutes.feedbackScreen);
                  }),
                  const Divider(height: 1, indent: 40),

                  /// Feedback History
                  subOptionTile(context, icon: AppAssets.feedbackHistorySVG, title: "Feedback History", onPressed: () {
                    Get.back();
                    Get.toNamed(AppRoutes.feedbackHistoryScreen);
                  }),
                ],
              ),
            ),
            const Divider(height: 1),

            /// Log out
            ListTile(
              leading: SvgPicture.asset(
                AppAssets.logOutIcon,
                height: 16.h,
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              title: Text(
                "Log out",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () {
                AppDialogs.logoutDialog(
                  Get.context!,
                  isLoader: false.obs,
                  fullName: "Dishank Gajera",
                  onCancellation: () {
                    Get.back();
                  },
                  onLogout: () async {
                    Get.offAllNamed(AppRoutes.authScreen);
                  },
                );
              },
            ),
          ],
        );
      }),
    );
  }

  Widget subOptionTile(BuildContext context, {required VoidCallback onPressed, required String icon, required String title}) {
    return InkWell(
      onTap: onPressed,
      child: Ink(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
          child: Row(
            children: [
              40.horizontalSpace,
              SvgPicture.asset(
                icon,
                height: 20,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
              (defaultPadding / 2).horizontalSpace,
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../packages/cached_network_image/cached_network_image.dart';
import '../../controller/predefine_value_controller.dart';
import '../../data/repositories/auth/auth_repository.dart';
import '../../packages/app_animated_cliprect.dart';
import '../../res/app_dialog.dart';
import '../../utils/app_aspect_ratios.dart';
import '../../widgets/webview.dart';
import 'app_drawer_controller.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback? homeOnPressed;

  AppDrawer({super.key, this.homeOnPressed});

  final AppDrawerController con = Get.put(AppDrawerController());
  final PreDefinedValueController preValueCon = Get.find<PreDefinedValueController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: ResponsiveUtils.getDrawerWidth(context),
      child: Obx(() {
        return Column(
          children: [
            /// Drawer Header with Profile Banner
            Stack(
              children: [
                DrawerHeader(
                  margin: EdgeInsets.only(top: ResponsiveUtils.getSpacing(context) / 2),
                  padding: EdgeInsets.zero,
                  child: AspectRatio(
                    aspectRatio: AppAspectRatios.r16_7,
                    child: AppNetworkImage(
                      borderRadius: BorderRadius.circular(0),
                      fit: BoxFit.cover,
                      imageUrl: !isValEmpty(preValueCon.profileBanner.value) ? preValueCon.profileBanner.value : 'https://media.designrush.com/tinymce_images/316674/conversions/Desiree-Qelaj-content.jpg',
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const RangeMaintainingScrollPhysics(),
                children: [
                  ListTile(
                    leading: SvgPicture.asset(
                      AppAssets.homeOutlinedSVG,
                      height: ResponsiveUtils.getIconSize(context),
                      colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    ),
                    title: Text(
                      "Home",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize! * ResponsiveUtils.getFontSizeMultiplier(context),
                          ),
                    ),
                    onTap: homeOnPressed,
                  ),
                  const Divider(height: 1),

                  /// My Catalog
                  ListTile(
                    leading: SvgPicture.asset(
                      AppAssets.catalogIcon,
                      height: ResponsiveUtils.getIconSize(context),
                      colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    ),
                    title: Text(
                      "My Catalogue",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize! * ResponsiveUtils.getFontSizeMultiplier(context),
                          ),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.catalogueScreen);
                    },
                  ),
                  const Divider(height: 1),

                  /// Settings
                  /* ListTile(
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
                  const Divider(height: 1),*/

                  /// Customer Care
                  ListTile(
                    leading: SvgPicture.asset(
                      AppAssets.customerCareIcon,
                      height: ResponsiveUtils.getIconSize(context),
                      colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    ),
                    title: Text(
                      "Customer Care",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize! * ResponsiveUtils.getFontSizeMultiplier(context),
                          ),
                    ),
                    trailing: SvgPicture.asset(
                      con.isShowCare.isTrue ? AppAssets.upArrow : AppAssets.downArrow,
                      height: ResponsiveUtils.getIconSize(context) / 2,
                    ),
                    onTap: () {
                      con.isShowCare.value = !con.isShowCare.value;
                    },
                  ),

                  AnimatedClipRect(
                    open: con.isShowCare.value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.getSpacing(context) / 2),
                      child: Column(
                        children: [
                          const Divider(height: 1, indent: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              (ResponsiveUtils.getSpacing(context) * 2.5).horizontalSpace,
                              Text(
                                "Contact us On",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontSize: 13.sp * ResponsiveUtils.getFontSizeMultiplier(context),
                                    ),
                              ),
                              const Spacer(),
                              AppIconButton(
                                  size: ResponsiveUtils.getButtonHeight(context),
                                  icon: Icon(
                                    Icons.call,
                                    color: Theme.of(context).colorScheme.primary,
                                    size: ResponsiveUtils.getIconSize(context),
                                  ),
                                  onPressed: () {
                                    makePhoneCall(LocalStorage.contactMobileNumber);
                                  }),
                              AppIconButton(
                                size: ResponsiveUtils.getButtonHeight(context),
                                onPressed: () => sendEmail(LocalStorage.contactEmailID),
                                icon: Icon(
                                  Icons.email_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: ResponsiveUtils.getIconSize(context) * 1.1,
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
                      height: ResponsiveUtils.getIconSize(context),
                      colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    ),
                    title: Text(
                      "Policies",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize! * ResponsiveUtils.getFontSizeMultiplier(context),
                          ),
                    ),
                    trailing: SvgPicture.asset(
                      con.isShowPolicies.isTrue ? AppAssets.upArrow : AppAssets.downArrow,
                      height: ResponsiveUtils.getIconSize(context) / 2,
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
                          Get.to(MyWebView(title: "Privacy Policy", webURL: LocalStorage.privacyURL));
                        }),

                        const Divider(height: 1, indent: 40),

                        /// Return Policy
                        subOptionTile(context, icon: AppAssets.rtp, title: "Return Policy", onPressed: () {
                          Get.back();
                          Get.to(MyWebView(title: "Return Policy", webURL: LocalStorage.returnURL));
                        }),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  /// Feedback
                  /* ListTile(
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
                  const Divider(height: 1),*/

                  /// Log out
                  ListTile(
                    leading: SvgPicture.asset(
                      AppAssets.logOutIcon,
                      height: ResponsiveUtils.getIconSize(context),
                      colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    ),
                    title: Text(
                      "Log out",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize! * ResponsiveUtils.getFontSizeMultiplier(context),
                          ),
                    ),
                    onTap: () {
                      AppDialogs.logoutDialog(
                        Get.context!,
                        isLoader: con.isLoader,
                        fullName: "${LocalStorage.userModel.firstName} ${LocalStorage.userModel.lastName}",
                        onCancellation: () {
                          Get.back();
                        },
                        onLogout: () async {
                          await AuthRepository.logOutAPI(loader: con.isLoader);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            /// User Profile Section at Bottom
            InkWell(
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.profileScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Padding(
                  padding: ResponsiveUtils.getResponsivePadding(context),
                  child: Row(
                    children: [
                      /// User Avatar
                      Container(
                        height: ResponsiveUtils.isTablet(context) ? 60.r : 50.r,
                        width: ResponsiveUtils.isTablet(context) ? 60.r : 50.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity(0.1),
                        ),
                        child: !isValEmpty(LocalStorage.userModel.userImage)
                            ? ClipOval(
                                child: AppNetworkImage(
                                  imageUrl: LocalStorage.userModel.userImage,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: ResponsiveUtils.isTablet(context) ? 36.r : 30.r,
                                color: AppColors.primary,
                              ),
                      ),

                      (ResponsiveUtils.getSpacing(context) / 2).horizontalSpace,

                      /// User Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${LocalStorage.userModel.firstName} ${LocalStorage.userModel.lastName}",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize! * ResponsiveUtils.getFontSizeMultiplier(context),
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!isValEmpty(LocalStorage.userModel.email))
                              Text(
                                LocalStorage.userModel.email ?? "",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                                      fontSize: Theme.of(context).textTheme.bodySmall!.fontSize! * ResponsiveUtils.getFontSizeMultiplier(context),
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),

                      /// Profile Edit Button

                      AppIconButton(
                        size: ResponsiveUtils.getButtonHeight(context),
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColors.primary,
                          size: ResponsiveUtils.getIconSize(context),
                        ),
                        onPressed: () {
                          Get.back();
                          Get.toNamed(AppRoutes.profileScreen);
                        },
                      )
                    ],
                  ),
                ),
              ),
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
          padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.getSpacing(context) / 2),
          child: Row(
            children: [
              (ResponsiveUtils.getSpacing(context) * 2.5).horizontalSpace,
              SvgPicture.asset(
                icon,
                height: ResponsiveUtils.getIconSize(context),
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
              (ResponsiveUtils.getSpacing(context) / 2).horizontalSpace,
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 13.sp * ResponsiveUtils.getFontSizeMultiplier(context),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

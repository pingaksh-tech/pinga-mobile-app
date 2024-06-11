import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../exports.dart';
import '../../../packages/cached_network_image/cached_network_image.dart';
import '../../widgets/webview.dart';
import 'app_drawer_controller.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback? homeOnPressed;

  AppDrawer({super.key, this.homeOnPressed});

  final AppDrawerController con = Get.put(AppDrawerController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
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
            onTap: () => Get.toNamed(AppRoutes.wishlistScreen),
          ),
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
              // Get.back();
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
            onTap: () => Get.toNamed(AppRoutes.settingsScreen),
          ),
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
          if (con.isShowCare.isTrue)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Row(
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.call,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  AppIconButton(
                    size: 40,
                    onPressed: () {},
                    icon: Icon(
                      Icons.email_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 22,
                    ),
                  )
                ],
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
          if (con.isShowPolicies.isTrue)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Get.to(const MyWebView(title: "Privacy Policy", webURL: "https://api.flutter.dev/flutter/material/Switch/thumbColor.html")),
                  child: Ink(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                      child: Row(
                        children: [
                          40.horizontalSpace,
                          SvgPicture.asset(
                            AppAssets.productDetailSVG,
                            height: 20,
                            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                          ),
                          (defaultPadding / 2).horizontalSpace,
                          Text(
                            "Privacy Policy",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Get.to(const MyWebView(title: "Return Policy", webURL: "https://api.flutter.dev/flutter/material/Switch/thumbColor.html")),
                  child: Ink(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                      child: Row(
                        children: [
                          40.horizontalSpace,
                          SvgPicture.asset(
                            AppAssets.productReturn,
                            height: 20,
                            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                          ),
                          (defaultPadding / 2).horizontalSpace,
                          Text(
                            "Return Policy",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
            onTap: () {
              Get.toNamed(AppRoutes.feedbackScreen);
            },
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
              Get.offAllNamed(AppRoutes.authScreen);
            },
          ),
        ],
      ),
    );
  }
}

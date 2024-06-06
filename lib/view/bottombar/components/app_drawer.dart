import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../exports.dart';
import '../../../packages/cached_network_image/cached_network_image.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

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
            onTap: () {},
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
              // Get.back();
            },
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
            onTap: () {
              // Get.back();
            },
          ),
          const Divider(height: 1),

          /// My Catalog
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
            onTap: () {
              // Get.back();
            },
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
            onTap: () {
              // Get.back();
            },
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
              // Get.back();
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
              // Get.back();
            },
          ),
        ],
      ),
    );
  }
}

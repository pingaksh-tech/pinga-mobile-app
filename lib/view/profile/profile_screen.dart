// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // final ProfileController con = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyAppBar(
      //   title: "Profile",
      //   showBackIcon: false,
      //   backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      //   shadowColor: Theme.of(context).scaffoldBackgroundColor,
      // ),
      body: ListView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + defaultPadding),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.width / 4.w,
                  width: Get.width / 4.w,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(defaultPadding / 3),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(alignment: Alignment.topCenter, image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBE3Jjpigpv57mkc0yD2MEVK19vFBZVF_G9f0y8GfVgYk1cxdHHMMTQAkidmjXD_r0o6s&usqp=CAU"), fit: BoxFit.cover),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: GestureDetector(
                      //     onTap: () => UiUtils.toast("Coming Soon!"),
                      //     child: Container(
                      //       height: 36.h,
                      //       width: 36.h,
                      //       padding: EdgeInsets.all(defaultPadding / 2),
                      //       margin: EdgeInsets.all(defaultPadding / 5),
                      //       decoration: BoxDecoration(
                      //           color: AppColors.goldColor,
                      //           shape: BoxShape.circle,
                      //           border: Border.all(width: 3, color: AppColors.white)),
                      //       child: Center(
                      //         child: Image.asset(
                      //           AppAssets.editIcon,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(width: 5.w),
                SizedBox(
                  height: Get.width / 4.7.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: defaultPadding / 2),
                        child: Text(
                          "Dishank Gajera",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor.withOpacity(0.8)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: defaultPadding / 2),
                        child: Text(
                          "+91 7777990666",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor.withOpacity(0.8)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          GridView.builder(
            itemCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.05, crossAxisSpacing: defaultPadding),
            padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // if (Get.isRegistered<BottomBarController>()) {
                  //   final BottomBarController bottomCon = Get.find<BottomBarController>();
                  //   if (index == 0) {
                  //     bottomCon.onBottomBarTap(1);
                  //   } else if (index == 1) {
                  //     bottomCon.onBottomBarTap(2);
                  //   }
                  // }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(defaultRadius),
                    // boxShadow: defaultShadow(context),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor.withOpacity(0.03)),
                          padding: EdgeInsets.all(defaultPadding),
                          child: SvgPicture.asset(
                            index == 0 ? AppAssets.cart : AppAssets.orders,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                          child: Text(
                            index == 0 ? "14" : "8",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 27, fontWeight: FontWeight.w600, color: AppColors.primary),
                          ),
                        ),
                        Text(index == 0 ? "Total Cart Items" : "Total Orders", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.subText)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: defaultPadding * 2),
          cardTile(
            context,
            title: 'Privacy Policy',
            url: 'https:// /policies/privacy-policy',
            svgPath: AppAssets.privacy,
          ),
          Divider(height: defaultPadding * 1.3),
          cardTile(
            context,
            title: 'Terms and Conditions',
            url: 'https:// /pages/terms-and-condition',
            svgPath: AppAssets.tc,
          ),
          Divider(height: defaultPadding * 1.3),
          cardTile(
            context,
            title: 'Shipping Policy',
            url: 'https:// /policies/shipping-policy',
            svgPath: AppAssets.cart,
          ),
          Divider(height: defaultPadding * 1.3),
          cardTile(
            context,
            title: 'Return Policy',
            url: 'https:// /pages/cancellation-returns',
            svgPath: AppAssets.rtp,
          ),
          Divider(height: defaultPadding * 1.3),
          cardTile(
            context,
            title: 'FAQs',
            url: 'https:// /pages/faqs',
            svgPath: AppAssets.faq,
          ),
          Divider(height: defaultPadding * 1.3),
          cardTile(
            context,
            isLogout: true,
            title: 'Log out',
            svgPath: AppAssets.faq,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget cardTile(
    BuildContext context, {
    required String title,
    String? url,
    required String svgPath,
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (isLogout) {
          Get.offAllNamed(AppRoutes.authScreen);
        } else {
          _launchInBrowser(Uri.parse(url ?? ""));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        // decoration: BoxDecoration(
        //   color: Theme.of(context).primaryColor.withOpacity(0.03),
        //   borderRadius: BorderRadius.circular(10),
        // ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: isLogout
                  ? const Icon(
                      Icons.logout,
                      color: Colors.red,
                    )
                  : SvgPicture.asset(svgPath, height: 19.sp, color: Theme.of(context).primaryColor),
            ),
            Text(
              title,
              style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: isLogout ? Colors.red : Theme.of(Get.context!).primaryColor,
                  ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}

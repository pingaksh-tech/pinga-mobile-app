// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../exports.dart';
import '../../res/app_dialog.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController con = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: ListView(
          physics: const RangeMaintainingScrollPhysics(),
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: Get.height * 0.25,
                  width: Get.width,
                  color: Theme.of(context).colorScheme.surface,
                ),
                Stack(
                  children: [
                    Container(
                      height: Get.height * 0.2,
                      width: Get.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://media.designrush.com/tinymce_images/316674/conversions/Desiree-Qelaj-content.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(defaultRadius),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                          child: Container(
                            color: Colors.black.withOpacity(0.20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: defaultPadding,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: Get.width / 4.w,
                        width: Get.width / 4.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            alignment: Alignment.topCenter,
                            image: con.selectUserProfile.value.isEmpty
                                ? const NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBE3Jjpigpv57mkc0yD2MEVK19vFBZVF_G9f0y8GfVgYk1cxdHHMMTQAkidmjXD_r0o6s&usqp=CAU",
                                  )
                                : FileImage(File(con.selectUserProfile.value)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          AppDialogs.imagePickOptionDialog(
                            context,
                            cameraOnTap: () {
                              Get.back();
                              pickImages(
                                context,
                                isCircleCrop: true,
                                source: ImageSource.camera,
                                croppedFileChange: (cropper) {
                                  if (cropper != null) {
                                    con.selectUserProfile.value = cropper.path;
                                  }
                                },
                              );
                            },
                            galleryOnTap: () {
                              Get.back();
                              pickImages(
                                context,
                                isCircleCrop: true,
                                source: ImageSource.gallery,
                                croppedFileChange: (cropper) {
                                  if (cropper != null) {
                                    con.selectUserProfile.value = cropper.path;
                                  }
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 22.h,
                          width: 22.h,
                          padding: EdgeInsets.all(defaultPadding / 2.2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.editIcon,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            defaultPadding.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  profileTile(
                    context,
                    title: "User name",
                    subTitle: "Dishank Gajera",
                    iconImage: AppAssets.userIcon,
                  ),
                  divider,
                  profileTile(
                    context,
                    title: "User type",
                    subTitle: "GUEST",
                    iconImage: AppAssets.userIcon,
                  ),
                  divider,
                  profileTile(
                    context,
                    title: "Contact no.",
                    subTitle: "9558277156",
                    iconImage: AppAssets.contactIcon,
                  ),
                  divider,
                  profileTile(
                    context,
                    title: "Address",
                    subTitle: "B-450,9th Floor,The Capital,Bkc , Bandra,Mumbai-408051 -408051",
                    iconImage: AppAssets.addressIcon,
                    height: 30.h,
                  ),
                  divider,
                  profileTile(
                    context,
                    title: "GST no.",
                    subTitle: "27AAAAP0267H2ZN",
                    iconImage: AppAssets.gstIcon,
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppButton(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
          title: "Log out",
          borderRadius: BorderRadius.circular(40.r),
          onPressed: () {
            AppDialogs.logoutDialog(
              Get.context!,
              isLoader: con.isLoading,
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
      ),
    );
  }

  Widget profileTile(
    BuildContext context, {
    required String title,
    required String subTitle,
    required String iconImage,
    double? height,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconImage,
          color: Theme.of(context).primaryColor,
          height: height ?? 28.h,
        ),
        (defaultPadding / 1.5).horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.subtitleStyle(context).copyWith(fontSize: 12.sp, color: AppColors.font, height: 1.4),
              ),
              Text(
                subTitle,
                style: AppTextStyle.subtitleStyle(context).copyWith(
                  fontSize: 12.sp,
                  height: 0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Divider get divider => Divider(
        color: Theme.of(Get.context!).primaryColor.withOpacity(0.06),
        height: 20.h,
      );
}

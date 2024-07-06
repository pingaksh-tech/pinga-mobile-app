// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/repositories/auth/auth_repository.dart';
import '../../data/repositories/user/user_repository.dart';
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
                                ? NetworkImage(
                                    con.userDetail.value.userImage ?? LocalStorage.userModel.userImage,
                                  )
                                : FileImage(
                                    File(con.selectUserProfile.value),
                                  ),
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
                                croppedFileChange: (cropper) async {
                                  if (cropper != null) {
                                    con.selectUserProfile.value = cropper.path;
                                    await ProfileRepository.updateProfileApi(userImagePath: con.selectUserProfile.value, isLoader: con.isLoader);
                                  }
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 22.h,
                          width: 22.h,
                          padding: EdgeInsets.all(6.w),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding * 1.3),
              child: Column(
                children: [
                  profileTile(
                    context,
                    title: "Username",
                    subTitle: "${LocalStorage.userModel.firstName ?? ""} ${LocalStorage.userModel.lastName ?? ""}",
                    iconImage: AppAssets.usernameIcon,
                    height: 15.h,
                  ),
                  divider,
                  profileTile(
                    context,
                    title: "User type",
                    subTitle: LocalStorage.userModel.roleId?.name ?? con.userDetail.value.roleId?.name ?? "",
                    iconImage: AppAssets.userIcon,
                  ),
                  divider,
                  profileTile(
                    context,
                    title: "Contact no.",
                    subTitle: LocalStorage.userModel.phone ?? con.userDetail.value.phone ?? "",
                    iconImage: AppAssets.contactIcon,
                  ),
                  divider,
                  profileTile(
                    context,
                    title: "Address",
                    subTitle: con.userDetail.value.address ?? con.userDetail.value.address ?? "",
                    iconImage: AppAssets.addressIcon,
                    height: 30.h,
                  ),
                  divider,
                  profileTile(
                    context,
                    title: "GST no.",
                    subTitle: LocalStorage.userModel.gstNo ?? con.userDetail.value.gstNo ?? "",
                    iconImage: AppAssets.gstIcon,
                  ),
                  divider,
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
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
                    child: Row(
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            AppAssets.logOutSVG,
                            color: Theme.of(context).primaryColor,
                            height: 23.h,
                          ).paddingOnly(left: defaultPadding / 3.5),
                        ),
                        (defaultPadding / 2).horizontalSpace,
                        Text(
                          "Log out",
                          style: AppTextStyle.subtitleStyle(context).copyWith(
                            fontSize: 13.sp,
                            height: 0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(vertical: defaultPadding / 2.5),
                  ),
                  divider,
                ],
              ),
            ),
          ],
        ),
        /*  bottomNavigationBar: AppButton(
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
        ), */
      ),
    );
  }

  Widget profileTile(
    BuildContext context, {
    String? title,
    required String subTitle,
    required String iconImage,
    double? height,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 24.h,
          height: 24.h,
          child: SvgPicture.asset(
            iconImage,
            color: Theme.of(context).primaryColor,
            height: height ?? 20.h,
          ),
        ),
        (defaultPadding / 1.5).horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: AppTextStyle.subtitleStyle(context).copyWith(fontSize: 12.2.sp, color: AppColors.font, height: 1.4),
              ),
              (1.6).verticalSpace,
              Text(
                subTitle,
                style: AppTextStyle.subtitleStyle(context).copyWith(
                  fontSize: 12.6.sp,
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

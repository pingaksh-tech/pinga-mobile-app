import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controller/dialog_controller.dart';

import '../exports.dart';

class AppDialogs {
  // Function to show the Android-style dialog
  static Future<void> materialAppUpdateDialog(BuildContext context, {required VoidCallback onUpdate, required VoidCallback onLater, required RxBool isLoader, required bool isForceUpdate}) async {
    Get.dialog(
      PopScope(
        canPop: false,
        onPopInvoked: (didPop) {},
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Dialog(
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              padding: EdgeInsets.only(top: defaultPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //   decoration: const BoxDecoration(/*color: Theme.of(context).primaryColor,*/ shape: BoxShape.rectangle),
                  //   padding: EdgeInsets.all(defaultPadding),
                  //   child: SvgPicture.asset(
                  //     AppAssets.happypetLogo,
                  //     height: 20.h,
                  //     fit: BoxFit.contain,
                  //     color: Theme.of(context).primaryColor, // ignore: deprecated_member_use
                  //   ),
                  // ),
                  Obx(() {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: defaultPadding / 2, horizontal: defaultPadding),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: AppTheme.fontFamilyName, height: 1.5),
                          children: [
                            TextSpan(
                              text: "A new version of ",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 16, height: 1.5),
                            ),
                            TextSpan(
                              text: "${AppStrings.appName.value} ",
                              style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor, fontSize: 16),
                            ),
                            TextSpan(
                              text: "is available with important enhancements and bug fixes. Please update to the latest version for the best experience. Click ",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 16, height: 1.5),
                            ),
                            TextSpan(
                              text: "'Update' ",
                              style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor, fontSize: 16),
                            ),
                            TextSpan(
                              text: "to get the latest features.",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 16, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: defaultPadding),
                  Row(
                    children: [
                      isForceUpdate == false
                          ? Expanded(
                              child: InkWell(
                                onTap: onLater,
                                child: Container(
                                  height: 46,
                                  padding: EdgeInsets.all(defaultPadding / 2.5),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withOpacity(.2),
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(defaultRadius)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "May be later",
                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (isLoader.isFalse) {
                              onUpdate();
                            }
                          },
                          child: Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: isForceUpdate != true
                                  ? BorderRadius.only(bottomRight: Radius.circular(defaultRadius))
                                  : BorderRadius.only(
                                      bottomRight: Radius.circular(defaultRadius),
                                      bottomLeft: Radius.circular(defaultRadius),
                                    ),
                            ),
                            padding: EdgeInsets.all(defaultPadding / 2.5),
                            child: Obx(
                              () => Center(
                                child: isLoader.isTrue
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : Text(
                                        "Update",
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.sp),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Logout confirmation dialog
  static Future<void> logoutDialog(BuildContext context, {required String fullName, required VoidCallback onLogout, required VoidCallback onCancellation, required RxBool isLoader}) async {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Logout App!'),
            content: Padding(
              padding: EdgeInsets.only(top: defaultPadding / 2),
              child: RichText(
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 15.sp, fontFamily: AppTheme.fontFamilyName, height: 1.5),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Hey 👋 ',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
                    ),
                    TextSpan(
                      text: "$fullName, ",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
                    ),
                    TextSpan(
                      text: 'Are you sure you want to logout from the application ?',
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  if (isLoader.isFalse) {
                    onCancellation();
                  }
                },
                child: const Text('Close'),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () async {
                  if (isLoader.isFalse) {
                    if (await getConnectivityResult()) {
                      Get.back();
                      onLogout();
                    }
                  }
                },
                child: const Text('Logout'),
              ),
            ],
          );
        },
      );
    } else {
      Get.dialog(
        Obx(
          () => PopScope(
            canPop: !isLoader.value,
            onPopInvoked: (didPop) {},
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Dialog(
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  padding: EdgeInsets.only(top: defaultPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: defaultPadding / 1.5),
                        child: Text(
                          'Logout App!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Divider(height: defaultPadding / 3, color: Theme.of(context).primaryColor.withOpacity(.2)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: defaultPadding.w, horizontal: defaultPadding.w).copyWith(top: defaultPadding.h),
                            child: RichText(
                              textAlign: TextAlign.center,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: TextStyle(color: Colors.black, fontSize: 13.sp, fontFamily: AppTheme.fontFamilyName, height: 1.5),
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Hey 👋 ',
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: "$fullName, ",
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const TextSpan(
                                    text: 'Are you sure you want to logout from the application ?',
                                    style: TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (isLoader.isFalse) {
                                  onCancellation();
                                }
                              },
                              child: Container(
                                height: 46,
                                padding: EdgeInsets.all(defaultPadding / 2.5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(.2),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(defaultRadius)),
                                ),
                                child: Center(
                                  child: Text(
                                    "Close",
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (isLoader.isFalse) {
                                  onLogout();
                                }
                              },
                              child: Container(
                                height: 46,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(defaultRadius)),
                                ),
                                padding: EdgeInsets.all(defaultPadding / 2.5),
                                child: Obx(
                                  () => Center(
                                    child: isLoader.isTrue
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            ),
                                          )
                                        : Text(
                                            "Logout",
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.sp),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  // Delete confirmation dialog
  static Future<void> deleteDialog(BuildContext context, {required String fullName, required VoidCallback onDelete, required VoidCallback onCancellation, required RxBool isLoader}) async {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Delete Account!'),
            content: Padding(
              padding: EdgeInsets.only(top: defaultPadding / 2),
              child: RichText(
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 15.sp, fontFamily: AppTheme.fontFamilyName, height: 1.5),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Hey 👋 ',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
                    ),
                    TextSpan(
                      text: "$fullName, ",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
                    ),
                    TextSpan(
                      text: 'Are you sure you want to',
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.sp),
                    ),
                    TextSpan(
                      text: ' delete ',
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.sp),
                    ),
                    TextSpan(
                      text: 'your account ?',
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  if (isLoader.isFalse) {
                    onCancellation();
                  }
                },
                child: const Text('Close'),
              ),
              CupertinoDialogAction(
                onPressed: () async {
                  if (isLoader.isFalse) {
                    if (await getConnectivityResult()) {
                      Get.back();
                      onDelete();
                    }
                  }
                },
                child: const Text('Delete'),
              ),
            ],
          );
        },
      );
    } else {
      Get.dialog(
        Obx(
          () => PopScope(
            canPop: !isLoader.value,
            onPopInvoked: (didPop) {},
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Dialog(
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  padding: EdgeInsets.only(top: defaultPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: defaultPadding / 1.5),
                        child: Text(
                          'Delete Account!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Divider(height: defaultPadding / 3, color: Theme.of(context).primaryColor.withOpacity(.2)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: defaultPadding.w, horizontal: defaultPadding.w).copyWith(top: defaultPadding.h),
                            child: RichText(
                              textAlign: TextAlign.center,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: TextStyle(color: Colors.black, fontSize: 13.sp, fontFamily: AppTheme.fontFamilyName, height: 1.5),
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Hey 👋 ',
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: "$fullName, ",
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const TextSpan(
                                    text: 'Are you sure you want to',
                                    style: TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  const TextSpan(
                                    text: ' delete ',
                                    style: TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  const TextSpan(
                                    text: 'your account ?',
                                    style: TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (isLoader.isFalse) {
                                  onCancellation();
                                }
                              },
                              child: Container(
                                height: 46,
                                padding: EdgeInsets.all(defaultPadding / 2.5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(defaultRadius)),
                                ),
                                child: Center(
                                  child: Text(
                                    "Close",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (isLoader.isFalse) {
                                  onDelete();
                                }
                              },
                              child: Container(
                                height: 46,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(.2),
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(defaultRadius)),
                                ),
                                padding: EdgeInsets.all(defaultPadding / 2.5),
                                child: Obx(
                                  () => Center(
                                    child: isLoader.isTrue
                                        ? SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Theme.of(context).primaryColor,
                                              strokeWidth: 3,
                                            ),
                                          )
                                        : Text(
                                            "Delete",
                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Theme.of(context).primaryColor),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  // Function to show the iOS-style dialog
  static Future<void> cupertinoAppUpdateDialog(BuildContext context, {required VoidCallback onUpdate, VoidCallback? onLater, required RxBool isLoader, required bool isForceUpdate}) async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Update Require'),
          content: Padding(
            padding: EdgeInsets.only(top: defaultPadding / 3),
            child: Text(
              'We have launched a new and improved app. Please update to continue using the app.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          actions: <Widget>[
            if (isForceUpdate == false)
              CupertinoDialogAction(
                onPressed: onLater,
                isDefaultAction: true,
                child: const Text('Later'),
              ),
            CupertinoDialogAction(
              onPressed: () {
                if (isLoader.isFalse) {
                  onUpdate();
                }
              },
              child: const Text('Update Now'),
            ),
          ],
        );
      },
    );
  }

  // Select size dialog
  static Future<dynamic>? sizeSelector(
    BuildContext context, {
    Function(String?)? onChanged,
  }) {
    if (isRegistered<DialogController>()) {
      final DialogController dialogCon = Get.find<DialogController>();
      TextEditingController controller = TextEditingController();
      return showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: SafeArea(
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius / 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Size",
                              style: AppTextStyle.titleStyle(context).copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            AppIconButton(
                              size: 26.h,
                              icon: SvgPicture.asset(AppAssets.crossIcon),
                              onPressed: () {
                                Get.back();
                              },
                            )
                          ],
                        ),
                      ),
                      defaultPadding.verticalSpace,
                      AppTextField(
                        controller: controller,
                        hintText: 'Search',
                        textFieldType: TextFieldType.search,
                        textInputAction: TextInputAction.done,
                        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                        contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 1.7),
                        onChanged: onChanged,
                      ),
                      (defaultPadding / 1.4).verticalSpace,

                      /// Records
                      Expanded(
                        child: ListView.separated(
                          physics: const RangeMaintainingScrollPhysics(),
                          itemCount: dialogCon.productSizeList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(
                              dialogCon.productSizeList[index].size ?? '',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
                            ),
                            onTap: () {
                              Get.back(result: dialogCon.productSizeList[index]);
                            },
                          ),
                          separatorBuilder: (context, index) => Divider(height: 1.h),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
    return null;
  }

  // Select color dialog
  static Future<dynamic>? colorSelector(
    BuildContext context, {
    Function(String?)? onChanged,
  }) {
    if (isRegistered<DialogController>()) {
      final DialogController dialogCon = Get.find<DialogController>();
      TextEditingController controller = TextEditingController();
      return showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: SafeArea(
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius / 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Color",
                              style: AppTextStyle.titleStyle(context).copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            AppIconButton(
                              size: 26.h,
                              icon: SvgPicture.asset(AppAssets.crossIcon),
                              onPressed: () {
                                Get.back();
                              },
                            )
                          ],
                        ),
                      ),
                      defaultPadding.verticalSpace,
                      AppTextField(
                        controller: controller,
                        hintText: 'Search',
                        textFieldType: TextFieldType.search,
                        textInputAction: TextInputAction.done,
                        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                        contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 1.7),
                        onChanged: onChanged,
                      ),
                      (defaultPadding / 1.4).verticalSpace,

                      /// Records
                      Expanded(
                        child: ListView.separated(
                          physics: const RangeMaintainingScrollPhysics(),
                          itemCount: dialogCon.productColorList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(
                              dialogCon.productColorList[index].color ?? '',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
                            ),
                            onTap: () {
                              Get.back(result: dialogCon.productColorList[index]);
                            },
                          ),
                          separatorBuilder: (context, index) => Divider(height: 1.h),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
    return null;
  }

  // Select Diamond Dialog
  static Future<dynamic>? diamondSelector(
    BuildContext context, {
    Function(String?)? onChanged,
  }) {
    if (isRegistered<DialogController>()) {
      final DialogController dialogCon = Get.find<DialogController>();
      TextEditingController controller = TextEditingController();
      return showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: SafeArea(
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius / 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Diamond",
                              style: AppTextStyle.titleStyle(context).copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            AppIconButton(
                              size: 26.h,
                              icon: SvgPicture.asset(AppAssets.crossIcon),
                              onPressed: () {
                                Get.back();
                              },
                            )
                          ],
                        ),
                      ),
                      defaultPadding.verticalSpace,
                      AppTextField(
                        controller: controller,
                        hintText: 'Search',
                        textFieldType: TextFieldType.search,
                        textInputAction: TextInputAction.done,
                        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                        contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 1.7),
                        onChanged: onChanged,
                      ),
                      (defaultPadding / 1.4).verticalSpace,

                      /// Records
                      Expanded(
                        child: ListView.separated(
                          physics: const RangeMaintainingScrollPhysics(),
                          itemCount: dialogCon.productDiamondList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(
                              dialogCon.productDiamondList[index].diamond ?? '',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
                            ),
                            onTap: () {
                              Get.back(result: dialogCon.productDiamondList[index]);
                            },
                          ),
                          separatorBuilder: (context, index) => Divider(height: 1.h),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
    return null;
  }

  // ADD QUANTITY DIALOG
  static Future<dynamic> addQuantityDialog(BuildContext context, {required RxInt quantity, required Function(int) onChanged}) {
    TextEditingController controller = TextEditingController(text: quantity.toString());
    return Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.background,
        titlePadding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding).copyWith(bottom: 0),
        contentPadding: EdgeInsets.all(defaultPadding * 1.2).copyWith(top: defaultPadding / 2),
        actionsPadding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: defaultPadding / 1.4),
        title: Text(
          "Add to cart",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
        ),
        content: AppTextField(
          title: "Quantity",
          controller: controller,
          titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: Theme.of(context).colorScheme.primary),
          contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 1.4, horizontal: defaultPadding / 1.7),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          inputFormatters: [
            LengthLimitingTextInputFormatter(4),
          ],
        ),
        actions: [
          /// CANCEL
          TextButton(
            child: Text(
              "CANCEL",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            onPressed: () {
              Get.back();
            },
          ),

          /// ADD
          TextButton(
            child: Text(
              "ADD",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            onPressed: () {
              Get.back(/*result: RxInt(int.tryParse(controller.value.text.trim()) ?? 1)*/);
              onChanged(int.tryParse(controller.value.text.trim()) ?? 0);
            },
          ),
        ],
      ),
    );
  }

  static Future<dynamic> addMetalDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.background,
        titlePadding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding).copyWith(bottom: 0),
        contentPadding: EdgeInsets.all(defaultPadding * 1.2).copyWith(top: defaultPadding / 2),
        actionsPadding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: defaultPadding / 1.4),
        title: Row(
          children: [
            Expanded(
              child: Text(
                "Add extra metal",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.font,
                    ),
              ),
            ),
            AppIconButton(
              size: 24.h,
              splashColor: Theme.of(context).scaffoldBackgroundColor,
              onPressed: () {
                Get.back();
              },
              // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              icon: SvgPicture.asset(
                AppAssets.crossIcon,
                colorFilter: ColorFilter.mode(AppColors.subText, BlendMode.srcIn),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              title: "Metal Wt",
              hintText: "Add extra metal weight",
              controller: controller,
              contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 1.4, horizontal: defaultPadding / 1.7),
              titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              textInputAction: TextInputAction.done,
            ),
            Text(
              "Metal price",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Text(
              "Metal price",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.font.withOpacity(.7),
                  ),
            ),
            const AppButton(
              flexibleHeight: true,
              title: "Add metal",
            )
          ],
        ),
      ),
    );
  }
}

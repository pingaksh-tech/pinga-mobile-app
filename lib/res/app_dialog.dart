import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/predefine_value_controller.dart';
import '../data/model/cart/retailer_model.dart';
import '../data/model/common/splash_model.dart';
import '../exports.dart';
import '../widgets/custom_radio_button.dart';
import '../widgets/download_selection_tile.dart';
import 'empty_element.dart';

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
                    color: Theme.of(context).colorScheme.surface,
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
    required RxList<DiamondModel> sizeList,
    required RxString selectedSize,
  }) {
    Rx<TextEditingController> controller = TextEditingController().obs;

    return showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Obx(() {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: SafeArea(
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.only(top: defaultPadding),
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
                      if (sizeList.isNotEmpty)
                        AppTextField(
                          controller: controller.value,
                          hintText: 'Search',
                          textInputAction: TextInputAction.search,
                          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                          contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 1.7),
                          onChanged: onChanged,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(defaultPadding / 1.4),
                            child: SvgPicture.asset(
                              AppAssets.search,
                              height: 22,
                              width: 22,
                              color: UiUtils.keyboardIsOpen.isTrue ? Theme.of(context).primaryColor : Colors.grey.shade400, // ignore: deprecated_member_use
                            ),
                          ),
                          suffixIcon: controller.value.text.trim().isNotEmpty
                              ? Center(
                                  child: SvgPicture.asset(
                                    AppAssets.crossIcon,
                                    color: Theme.of(context).primaryColor, // ignore: deprecated_member_use
                                  ),
                                )
                              : null,
                          suffixOnTap: () {
                            FocusScope.of(context).unfocus();
                            controller.value.clear();
                          },
                        ),
                      (defaultPadding / 1.4).verticalSpace,

                      /// Records
                      Expanded(
                        child: sizeList.isNotEmpty
                            ? ListView.separated(
                                physics: const RangeMaintainingScrollPhysics(),
                                itemCount: sizeList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => ListTile(
                                  title: Text(
                                    sizeList[index].name ?? '',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
                                  ),
                                  trailing: AppRadioButton(
                                    isSelected: (sizeList[index].id?.value == selectedSize.value).obs,
                                  ),
                                  onTap: () {
                                    Get.back(
                                      result: sizeList[index],
                                    );
                                  },
                                ),
                                separatorBuilder: (context, index) => Divider(height: 1.h),
                              )
                            : Center(
                                child: Text(
                                  "Size not available",
                                  style: AppTextStyle.titleStyle(context).copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  // Select color dialog
  static Future<dynamic>? colorSelector(
    BuildContext context, {
    Function(String?)? onChanged,
    required RxList<MetalModel> colorList,
    required RxString selectedColor,
  }) {
    TextEditingController controller = TextEditingController();

    return showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
              child: Container(
                width: Get.width,
                padding: EdgeInsets.only(top: defaultPadding),
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
                    if (colorList.isNotEmpty)
                      AppTextField(
                        controller: controller,
                        hintText: 'Search',
                        textInputAction: TextInputAction.search,
                        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                        contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 1.7),
                        onChanged: onChanged,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding / 1.4),
                          child: SvgPicture.asset(
                            AppAssets.search,
                            height: 22,
                            width: 22,
                            color: UiUtils.keyboardIsOpen.isTrue ? Theme.of(context).primaryColor : Colors.grey.shade400, // ignore: deprecated_member_use
                          ),
                        ),
                        suffixIcon: controller.text.trim().isNotEmpty
                            ? Center(
                                child: SvgPicture.asset(
                                  AppAssets.crossIcon,
                                  color: Theme.of(context).primaryColor, // ignore: deprecated_member_use
                                ),
                              )
                            : null,
                        suffixOnTap: () {
                          FocusScope.of(context).unfocus();
                          controller.clear();
                        },
                      ),
                    (defaultPadding / 1.4).verticalSpace,

                    /// Records
                    Expanded(
                      child: colorList.isNotEmpty
                          ? ListView.separated(
                              physics: const RangeMaintainingScrollPhysics(),
                              itemCount: colorList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => ListTile(
                                title: Text(
                                  colorList[index].name ?? '',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
                                ),
                                trailing: AppRadioButton(
                                  isSelected: (colorList[index].id?.value == selectedColor.value).obs,
                                ),
                                onTap: () {
                                  Get.back(result: colorList[index]);
                                },
                              ),
                              separatorBuilder: (context, index) => Divider(height: 1.h),
                            )
                          : Center(
                              child: Text(
                                "Color not available",
                                style: AppTextStyle.titleStyle(context).copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  // Select Diamond Dialog
  static Future<dynamic>? diamondSelector(
    BuildContext context, {
    Function(String?)? onChanged,
    required RxList<DiamondModel> diamondList,
    required RxString selectedDiamond,
  }) {
    TextEditingController controller = TextEditingController();
    return showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
              child: Container(
                width: Get.width,
                padding: EdgeInsets.only(top: defaultPadding),
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
                    if (diamondList.isNotEmpty)
                      AppTextField(
                        controller: controller,
                        hintText: 'Search',
                        textInputAction: TextInputAction.search,
                        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                        contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 1.7),
                        onChanged: onChanged,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding / 1.4),
                          child: SvgPicture.asset(
                            AppAssets.search,
                            height: 22,
                            width: 22,
                            color: UiUtils.keyboardIsOpen.isTrue ? Theme.of(context).primaryColor : Colors.grey.shade400, // ignore: deprecated_member_use
                          ),
                        ),
                        suffixIcon: controller.text.trim().isNotEmpty
                            ? Center(
                                child: SvgPicture.asset(
                                  AppAssets.crossIcon,
                                  color: Theme.of(context).primaryColor, // ignore: deprecated_member_use
                                ),
                              )
                            : null,
                        suffixOnTap: () {
                          FocusScope.of(context).unfocus();
                          controller.clear();
                        },
                      ),
                    (defaultPadding / 1.4).verticalSpace,

                    /// Records
                    Expanded(
                      child: diamondList.isNotEmpty
                          ? ListView.separated(
                              physics: const RangeMaintainingScrollPhysics(),
                              itemCount: diamondList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => ListTile(
                                title: Text(
                                  diamondList[index].name ?? '',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
                                ),
                                trailing: AppRadioButton(
                                  isSelected: (diamondList[index].id?.value == selectedDiamond.value).obs,
                                ),
                                onTap: () {
                                  Get.back(result: diamondList[index]);
                                },
                              ),
                              separatorBuilder: (context, index) => Divider(height: 1.h),
                            )
                          : Center(
                              child: Text(
                                "Diamonds not available",
                                style: AppTextStyle.titleStyle(context).copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  // ADD QUANTITY DIALOG
  static Future<dynamic> addQuantityDialog(BuildContext context, {required RxInt quantity, required Function(int) onChanged, bool isCart = false}) {
    TextEditingController controller = TextEditingController(text: (quantity).toString());
    RxString errorMessage = "".obs;
    RxBool isValidate = true.obs;
    return Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.background,
        titlePadding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding).copyWith(bottom: 0),
        contentPadding: EdgeInsets.all(defaultPadding * 1.2).copyWith(top: defaultPadding / 2),
        actionsPadding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: defaultPadding / 1.4),
        title: Row(
          children: [
            Text(
              "Add to cart",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
        content: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                title: "Quantity",
                controller: controller,
                autofocus: true,
                errorMessage: errorMessage.value,
                validation: isValidate.value,
                titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: Theme.of(context).colorScheme.primary),
                contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 1.4, horizontal: defaultPadding / 1.7),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                ],
              ),
            ],
          );
        }),
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
              if (isCart) {
                if ((int.tryParse(controller.value.text.trim()) ?? 0) <= 0) {
                  isValidate.value = false;
                  errorMessage.value = "Quantity must be greater than 0";
                } else {
                  Get.back();
                  onChanged(int.tryParse(controller.value.text.trim()) ?? 0);
                }
              } else {
                Get.back();
                onChanged(int.tryParse(controller.value.text.trim()) ?? 0);
              }
            },
          ),
        ],
      ),
    );
  }

  // RENAME CATALOGUE
  static Future<dynamic> renameCatalogueDialog(BuildContext context, {String? name, required Function(String) onChanged, required String title, required String dialogTitle}) {
    TextEditingController controller = TextEditingController(text: name ?? '');
    return Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.background,
        titlePadding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding).copyWith(bottom: 0),
        contentPadding: EdgeInsets.all(defaultPadding * 1.2).copyWith(top: defaultPadding / 2),
        actionsPadding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: defaultPadding / 1.4),
        title: Row(
          children: [
            Text(
              dialogTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
        content: SizedBox(
          width: Get.width,
          child: AppTextField(
            title: title,
            hintText: "Enter name",
            controller: controller,
            autofocus: true,
            titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp, color: Theme.of(context).colorScheme.primary),
            contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 1.4, horizontal: defaultPadding / 1.7),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
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
              "SAVE",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            onPressed: () {
              Get.back();
              onChanged(controller.value.text.trim());
            },
          ),
        ],
      ),
    );
  }

  static Future<dynamic> addMetalDialog(BuildContext context) {
    Rx<TextEditingController> controller = TextEditingController().obs;
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
                      fontSize: 15.4.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.font,
                    ),
              ),
            ),
            AppIconButton(
              size: 24.h,
              splashColor: Theme.of(context).scaffoldBackgroundColor,
              icon: SvgPicture.asset(
                AppAssets.crossIcon,
                colorFilter: ColorFilter.mode(AppColors.subText, BlendMode.srcIn),
              ),
              onPressed: () {
                Get.back();
              },
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
              controller: controller.value,
              autofocus: true,
              contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 1.4, horizontal: defaultPadding / 1.7),
              titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onChanged: (_) {
                /// Debounce
                commonDebounce(callback: () async {
                  controller.refresh();
                  /*API CALL*/
                  await null;
                });
              },
            ),
            (defaultPadding / 1.5).verticalSpace,
            Text(
              "Metal price",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            1.verticalSpace,
            Obx(() {
              return Text(
                isValEmpty(controller.value.text.trim()) ? "Metal price" : UiUtils.amountFormat(22311, decimalDigits: 0),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.font.withOpacity(.5),
                    ),
              );
            }),
            (defaultPadding / 1.4).verticalSpace,
            AppButton(
              title: "Add metal",
              flexibleHeight: true,
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }

// Cart Product Detail
  static Future<void> cartProductDetailDialog(BuildContext context, {required String productName}) {
    final PreDefinedValueController dialogCon = Get.find<PreDefinedValueController>();
    return Get.dialog(
      Dialog(
        insetPadding: REdgeInsets.all(defaultPadding * 1.5),
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
        child: Padding(
          padding: EdgeInsets.all(defaultPadding).copyWith(top: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      productName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp),
                    ).paddingSymmetric(vertical: defaultPadding),
                  ),
                  AppIconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: SvgPicture.asset(AppAssets.crossIcon, height: 25.h),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lightGrey),
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: Get.height * 0.5,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const RangeMaintainingScrollPhysics(),
                    separatorBuilder: (context, index) => const Divider(),
                    padding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
                    itemCount: dialogCon.cartProductDetailList.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            dialogCon.cartProductDetailList[index].categoryName ?? "",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15.sp),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            ":",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15.sp),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            dialogCon.cartProductDetailList[index].value ?? "",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // CART DIALOG
  static Future<dynamic> cartDialog(
    BuildContext context, {
    required void Function()? onPressed,
    Widget? content,
    String? buttonTitle2,
    String? dialogTitle,
    String? contentText,
    String? buttonTitle,
    TextStyle? titleStyle,
  }) {
    return Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.background,
        titlePadding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding).copyWith(bottom: 0),
        contentPadding: EdgeInsets.all(defaultPadding * 1.2).copyWith(top: defaultPadding / 2),
        actionsPadding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: defaultPadding / 1.4),
        title: Text(
          dialogTitle ?? "PINGAKSH",
          style: titleStyle ??
              Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
        ),
        content: content ??
            Text(
              contentText ?? "",
              style: Theme.of(context).textTheme.titleMedium,
            ),
        actions: [
          /// CANCEL
          TextButton(
            child: Text(
              buttonTitle ?? "CANCEL",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            onPressed: () {
              Get.back(result: false);
            },
          ),

          /// ADD
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonTitle2 ?? "YES",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<dynamic> cartAlertDialog(
    BuildContext context, {
    required void Function()? onPressed,
    String? contentText,
    bool isCancelButtonShow = false,
  }) {
    return Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        titlePadding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding).copyWith(bottom: 0),
        contentPadding: EdgeInsets.all(defaultPadding * 1.2).copyWith(top: defaultPadding / 2),
        title: Text(
          "Alert",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
        ),
        content: Text(
          contentText ?? "It will take more than 10 minutes to download the catalogue. Do you want to continue?",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          AppButton(
            title: "No",
            height: 28.h,
            flexibleWidth: true,
            onPressed: () {
              Get.back();
            },
          ),
          AppButton(
            title: "Yes",
            height: 28.h,
            flexibleWidth: true,
            onPressed: () {
              Get.back();
            },
          ),
          if (isCancelButtonShow)
            AppButton(
              title: "Cancel",
              height: 28.h,
              flexibleWidth: true,
              onPressed: () {
                Get.back();
              },
            ),
        ],
      ),
    );
  }

  // Product Download Dialog
  static Future<void> productDownloadDialog(BuildContext context, {bool isDownloadFileNameChange = false}) {
    return Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.all(defaultPadding * 1.2),
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
        child: Padding(
          padding: EdgeInsets.all(defaultPadding).copyWith(top: 0, bottom: defaultPadding / 2.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Select an option",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
                    ).paddingOnly(top: defaultPadding, bottom: defaultPadding, left: defaultPadding),
                  ),
                  AppIconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: SvgPicture.asset(AppAssets.crossIcon, height: 25.h),
                  ),
                ],
              ).paddingSymmetric(vertical: defaultPadding / 2),
              DownloadSelectionTile(
                title: "Catalogue (digital)",
                image: AppAssets.catalogueIcon,
                onTap: () {
                  Get.back();
                  isDownloadFileNameChange
                      ? addFileName(context)
                      : AppDialogs.cartAlertDialog(
                          context,
                          onPressed: () {},
                        );
                },
              ),
              DownloadSelectionTile(
                title: "List format",
                image: AppAssets.listFormateIcon,
                onTap: () {
                  Get.back();
                  isDownloadFileNameChange
                      ? addFileName(context)
                      : AppDialogs.cartAlertDialog(
                          context,
                          onPressed: () {},
                        );
                },
              ),
              DownloadSelectionTile(
                image: AppAssets.downloadListIcon,
                title: "Downloaded list",
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.catalogueScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // WatchList Download Dialog
  static Future<void> watchListDownloadDialog(BuildContext context) {
    return Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.all(defaultPadding * 1.2),
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
        child: Padding(
          padding: EdgeInsets.all(defaultPadding).copyWith(top: 0, bottom: defaultPadding / 2.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Select an option",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
                    ).paddingOnly(top: defaultPadding, bottom: defaultPadding, left: defaultPadding),
                  ),
                  AppIconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: SvgPicture.asset(AppAssets.crossIcon, height: 25.h),
                  ),
                ],
              ).paddingSymmetric(vertical: defaultPadding / 2),
              DownloadSelectionTile(
                title: "Download pdf",
                image: AppAssets.pdfIcon,
                onTap: () {
                  Get.back();
                },
              ),
              DownloadSelectionTile(
                title: "Download detailed pdf",
                image: AppAssets.detailPdfIcon,
                onTap: () {
                  Get.back();
                },
              ),
              DownloadSelectionTile(
                title: "Catalogue",
                image: AppAssets.catalogueIcon,
                onTap: () {
                  Get.back();
                  productDownloadDialog(context, isDownloadFileNameChange: true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Add FileName Dialog
  static Future<dynamic> addFileName(BuildContext context) {
    Rx<TextEditingController> fileCon = TextEditingController().obs;
    RxBool fileNameValidation = true.obs;
    RxString nameError = ''.obs;
    bool validation() {
      if (fileCon.value.text.trim().isEmpty) {
        nameError.value = "Please enter filename";
        fileNameValidation.value = false;
      } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(fileCon.value.text)) {
        nameError.value = "File name contains invalid characters";
        fileNameValidation.value = false;
      } else {
        fileNameValidation.value = true;
      }
      return fileNameValidation.isTrue;
    }

    return Get.dialog(
      AlertDialog(
        insetPadding: EdgeInsets.all(defaultPadding * 1.2),
        backgroundColor: AppColors.background,
        titlePadding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2).copyWith(bottom: 0),
        contentPadding: EdgeInsets.all(defaultPadding * 1.2).copyWith(top: defaultPadding / 2, bottom: defaultPadding / 1.5),
        actionsPadding: EdgeInsets.symmetric(horizontal: defaultPadding),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
        title: Row(
          children: [
            Expanded(
              child: Text(
                "Select an option",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
              ).paddingOnly(top: defaultPadding, bottom: defaultPadding, left: defaultPadding),
            ),
            AppIconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset(AppAssets.crossIcon, height: 25.h),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "File Name",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
            ).paddingOnly(bottom: defaultPadding / 3),
            Text(
              "PS: Avoid using special characters. Use'_'instead of space",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
            ).paddingOnly(bottom: defaultPadding / 2),
            Obx(
              () => AppTextField(
                hintText: "Add file name",
                controller: fileCon.value,
                contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 1.4, horizontal: defaultPadding / 1.7),
                keyboardType: TextInputType.text,
                validation: fileNameValidation.value,
                errorMessage: nameError.value,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
                ],
                onChanged: (value) {
                  fileNameValidation.value = true;
                },
              ),
            ),
            (defaultPadding).verticalSpace,
            AppButton(
              title: "Submit",
              flexibleHeight: true,
              onPressed: () {
                if (validation()) {
                  Get.back();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

// Add Attachment Dialog
  static Future<dynamic> addAttachmentDialog(BuildContext context) {
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
                "Choose",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 15.4.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.font,
                    ),
              ),
            ),
            AppIconButton(
              size: 24.h,
              splashColor: Theme.of(context).scaffoldBackgroundColor,
              icon: SvgPicture.asset(
                AppAssets.crossIcon,
                colorFilter: const ColorFilter.mode(AppColors.font, BlendMode.srcIn),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding / 1.2, horizontal: defaultPadding * 1.3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      height: 20.h,
                      AppAssets.addPhotoSVG,
                      colorFilter: ColorFilter.mode(AppColors.font.withOpacity(.6), BlendMode.srcIn),
                    ),
                    4.verticalSpace,
                    Text(
                      "Photos",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding / 1.2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      height: 20.h,
                      AppAssets.documentFill,
                      colorFilter: ColorFilter.mode(AppColors.font.withOpacity(.6), BlendMode.srcIn),
                    ),
                    4.verticalSpace,
                    Text(
                      "Documents",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  // Image Picker Option Dialog
  static Future<void> imagePickOptionDialog(
    BuildContext context, {
    required VoidCallback cameraOnTap,
    required VoidCallback galleryOnTap,
  }) {
    Widget iconButton({
      required IconData? icon,
      required String title,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Column(
          children: [
            Icon(
              icon,
              size: 40.h,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55),
            ),
            Text(
              title,
              style: AppTextStyle.subtitleStyle(context),
            )
          ],
        ),
      );
    }

    return Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.all(defaultPadding * 2),
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
        child: Padding(
          padding: EdgeInsets.all(defaultPadding).copyWith(top: 0, bottom: defaultPadding / 2.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ).paddingSymmetric(vertical: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconButton(
                    icon: Icons.camera_alt_rounded,
                    title: "Camera",
                    onTap: cameraOnTap,
                  ),
                  5.horizontalSpace,
                  iconButton(
                    icon: Icons.photo_rounded,
                    title: "Gallery",
                    onTap: galleryOnTap,
                  )
                ],
              ),
              (defaultPadding).verticalSpace,
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "CANCEL",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Select Retailers dialog
  static Future<dynamic>? retailerSelect(
    BuildContext context, {
    Function(String?)? onChanged,
    required RxList<RetailerModel> retailerList,
    required RxString selectedRetailer,
  }) {
    TextEditingController controller = TextEditingController();

    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: Container(
              width: Get.width,
              padding: EdgeInsets.only(top: defaultPadding),
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
                          "Select Retailer",
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
                  if (retailerList.isNotEmpty)
                    AppTextField(
                      controller: controller,
                      hintText: 'Search',
                      textInputAction: TextInputAction.search,
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 1.7),
                      onChanged: onChanged,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding / 1.4),
                        child: SvgPicture.asset(
                          AppAssets.search,
                          height: 22,
                          width: 22,
                          color: UiUtils.keyboardIsOpen.isTrue ? Theme.of(context).primaryColor : Colors.grey.shade400, // ignore: deprecated_member_use
                        ),
                      ),
                      suffixIcon: controller.text.trim().isNotEmpty
                          ? Center(
                              child: SvgPicture.asset(
                                AppAssets.crossIcon,
                                color: Theme.of(context).primaryColor, // ignore: deprecated_member_use
                              ),
                            )
                          : null,
                      suffixOnTap: () {
                        FocusScope.of(context).unfocus();
                        controller.clear();
                      },
                    ),
                  (defaultPadding / 1.4).verticalSpace,

                  /// Records
                  Expanded(
                    child: retailerList.isNotEmpty
                        ? ListView.separated(
                            physics: const RangeMaintainingScrollPhysics(),
                            itemCount: retailerList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(
                                retailerList[index].businessName ?? '',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
                              ),
                              trailing: AppRadioButton(
                                isSelected: (selectedRetailer.value == retailerList[index].id).obs,
                              ),
                              onTap: () {
                                selectedRetailer.value == retailerList[index].id;
                                Get.back(result: retailerList[index].businessName);
                              },
                            ),
                            separatorBuilder: (context, index) => Divider(height: 1.h),
                          )
                        : const Center(
                            child: EmptyElement(title: "Retailers not available"),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

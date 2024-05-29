// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

class CartDialogs {
  static Future cartItemRemoveDialog({
    required BuildContext context,
    required String deleteNote,
    required VoidCallback onTap,
  }) {
    return Get.dialog(
      Dialog(
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
              Container(
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                  margin: EdgeInsets.symmetric(vertical: defaultPadding / 2).copyWith(top: 0),
                  padding: EdgeInsets.all(defaultPadding),
                  child: SvgPicture.asset(
                    AppAssets.trash,
                    height: 27,
                    color: Colors.white,
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding / 2, horizontal: defaultPadding),
                child: Text(
                  deleteNote,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 46,
                        padding: EdgeInsets.all(defaultPadding / 2.5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(.1),
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(defaultRadius)),
                        ),
                        child: Center(
                          child: Text(
                            "CANCEL",
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(defaultRadius)),
                        ),
                        padding: EdgeInsets.all(defaultPadding / 2.5),
                        child: Center(
                          child: Text(
                            "YES",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14.sp),
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
    );
  }
}

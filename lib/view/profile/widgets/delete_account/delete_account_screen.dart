// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import 'delete_account_controller.dart';

class DeleteAccountScreen extends StatelessWidget {
  DeleteAccountScreen({super.key});

  final DeleteAccountController con = Get.put(DeleteAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: "Delete Account",
      ),
      body: ListView(
        physics: const RangeMaintainingScrollPhysics(),
        padding: EdgeInsets.all(defaultPadding),
        children: [
          Text(
            "Deleting your account will permanently erase all data associated with it, including your profile, settings, and any saved information. Once deleted, this action cannot be undone, and all data will be lost. Please consider this carefully before proceeding.",
            style: AppTextStyle.subtitleStyle(context).copyWith(fontSize: 12.2.sp, color: AppColors.font, height: 1.4),
          ),
          defaultPadding.verticalSpace,
          RichText(
            text: TextSpan(
              text: 'For account deletion, please visit our Contact Us page at ',
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: 'pingaksh.co/contact-us.html',
                  style: AppTextStyle.titleStyle(context).copyWith(
                    fontSize: 12.2.sp,
                    color: Theme.of(context).colorScheme.error,
                    height: 1.4,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrlFunction(
                          Uri.parse("https://pingaksh.co/contact-us.html"),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Divider get divider => Divider(
        color: Theme.of(Get.context!).primaryColor.withOpacity(0.06),
        height: 20.h,
      );
}

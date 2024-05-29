import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/packages/app_animated_cliprect.dart';

import '../../../data/api/api_utils.dart';
import '../../../exports.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: UiUtils.systemUiOverlayStyle(
        isReverse: true,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            ListView(
              padding: EdgeInsets.zero,
              physics: const RangeMaintainingScrollPhysics(),
              children: [
                Image.asset(
                  AppAssets.authBg,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding).copyWith(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Log In / Sign Up',
                        style: AppTextStyle.titleStyle(context),
                      ),
                      Text(
                        'Enter your phone number to get OTP',
                        style: AppTextStyle.subtitleStyle(context),
                      ),
                      (defaultPadding * 1.5).verticalSpace,
                      AppTextField(
                        title: "Phone number",
                        hintText: "Enter your number",
                        controller: con.numberCon.value,
                        validation: con.numberValidation.value,
                        errorMessage: con.numberError.value,
                        keyboardType: TextInputType.phone,
                        scrollPadding: UiUtils.textfieldScrollPadding(context, showError: con.numberValidation.value),
                        textInputAction: TextInputAction.done,
                        padding: EdgeInsets.only(bottom: defaultPadding.h),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        onChanged: (value) {
                          con.numberValidation.value = true;
                        },
                      ),
                      (defaultPadding * 1.5).verticalSpace,
                      AppButton(
                        title: 'Request OTP',
                        borderRadius: BorderRadius.circular(defaultRadius * 4),
                        margin: EdgeInsets.symmetric(horizontal: defaultPadding.w),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedClipRect(
                open: !UiUtils.keyboardIsOpen.value,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SvgPicture.asset(
                      AppAssets.authAsset,
                      fit: BoxFit.fitWidth,
                    ),
                    AnimatedContainer(
                      duration: defaultDuration,
                      color: !UiUtils.keyboardIsOpen.value ? Theme.of(context).scaffoldBackgroundColor : null,
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + defaultPadding * 1.5),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "By using the Pingaksh app you agree to our\n",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12.sp, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55)),
                          children: [
                            TextSpan(
                              text: "Terms of Service",
                              recognizer: TapGestureRecognizer()..onTap = con.isLoading.isFalse ? () => ApiUtils.termsAndConditionsNav() : null,
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500, decoration: TextDecoration.underline, color: Theme.of(context).primaryColor),
                            ),
                            TextSpan(
                              text: " and ",
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12.sp, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55)),
                            ),
                            TextSpan(
                              text: "Privacy Policy",
                              recognizer: TapGestureRecognizer()..onTap = con.isLoading.isFalse ? () => ApiUtils.termsAndConditionsNav() : null,
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500, decoration: TextDecoration.underline, color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

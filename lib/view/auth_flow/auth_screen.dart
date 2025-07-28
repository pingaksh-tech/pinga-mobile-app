import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../data/api/api_utils.dart';
import '../../data/repositories/auth/auth_repository.dart';
import '../../exports.dart';
import '../../packages/animated_counter/animated_counter.dart';
import '../../packages/app_animated_cliprect.dart';
import 'auth_controller.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final AuthController con = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: UiUtils.systemUiOverlayStyle(
        isReverse: true,
        systemNavigationBarColor: Theme.of(context).colorScheme.surface,
      ),
      child: Obx(
        () => PopScope(
          canPop: con.screenType.value == AuthScreenType.login,
          onPopInvoked: (didPop) {
            if (didPop) {
              Get.back();
            } else {
              con.screenType.value = AuthScreenType.login;
            }
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Stack(
              fit: StackFit.expand,
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  physics: const RangeMaintainingScrollPhysics(),
                  children: [
                    // Background Image
                    Image.asset(
                      AppAssets.authBg,
                      fit: BoxFit.fitWidth,
                    ),

                    // Body Contain
                    Padding(
                      padding: EdgeInsets.all(defaultPadding).copyWith(top: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UiUtils.fadeSwitcherWidget(
                            child: Text(
                              switch (con.screenType.value) {
                                AuthScreenType.login => 'Log In',
                                AuthScreenType.otpVerification => "Enter Verification Code",
                              },
                              key: ValueKey(con.screenType.value),
                              style: AppTextStyle.titleStyle(context),
                            ),
                          ),
                          UiUtils.fadeSwitcherWidget(
                            child: SizedBox(
                              key: ValueKey(con.screenType.value),
                              child: switch (con.screenType.value) {
                                AuthScreenType.login => Text(
                                    'Enter your phone number to get OTP',
                                    key: ValueKey(con.screenType.value),
                                    style: AppTextStyle.subtitleStyle(context),
                                  ),
                                AuthScreenType.otpVerification => RichText(
                                    key: ValueKey(con.screenType.value),
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "We just sent an OTP to ",
                                      style: AppTextStyle.subtitleStyle(context),
                                      children: [
                                        TextSpan(
                                          text: "${con.countryObject.value.dialCode} ${con.numberCon.value.text.trim()}",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = con.isLoading.isFalse && con.isResendOtp.isFalse
                                                ? () {
                                                    con.screenType.value = AuthScreenType.login;
                                                  }
                                                : null,
                                          style: AppTextStyle.subtitleStyle(context).copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                              },
                            ),
                          ),
                          (defaultPadding * 1.5).verticalSpace,

                          /// PHONE NUMBER FIELD
                          AnimatedClipRect(
                            open: con.screenType.value == AuthScreenType.login,
                            child: AppTextField(
                              title: "Phone number",
                              hintText: "Enter your number",
                              controller: con.numberCon.value,
                              validation: con.numberValidation.value,
                              errorMessage: con.numberError.value,
                              keyboardType: TextInputType.phone,
                              scrollPadding: UiUtils.textFieldScrollPadding(context, showError: con.numberValidation.value),
                              textInputAction: TextInputAction.done,
                              prefixIcon: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 1.5),
                                width: 55.w,
                                child: Text(
                                  con.countryObject.value.dialCode,
                                  style: AppTextStyle.textFieldStyle(context).copyWith(color: Theme.of(context).textTheme.titleLarge?.color),
                                ),
                              ),
                              onFieldSubmitted: (v) {
                                AuthRepository.sendOtpToPhoneNumberAPI(
                                  loader: con.isLoading,
                                  mobileNumber: con.userMobileNumberWithISDCode,
                                  onSuccess: () {
                                    con.timerStart();
                                    con.otpController.value.clear();
                                    con.isLoading.value = false;
                                    con.screenType.value = AuthScreenType.otpVerification;
                                  },
                                );
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              onChanged: (value) {
                                con.numberValidation.value = true;
                              },
                            ),
                          ),

                          /// OTP FIELD
                          AnimatedClipRect(
                            open: con.screenType.value == AuthScreenType.otpVerification,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Pinput(
                                  controller: con.otpController.value,
                                  androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                                  autofocus: kReleaseMode,
                                  defaultPinTheme: defaultPinTheme,
                                  scrollPadding: UiUtils.textFieldScrollPadding(context, extendBottom: defaultPadding),
                                  length: con.maxOTPLength,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(con.maxOTPLength),
                                  ],
                                  preFilledWidget: const Text(
                                    "-",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: AppColors.lightGrey,
                                    ),
                                  ),
                                  cursor: Container(
                                    width: 2,
                                    height: 20,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  focusedPinTheme: defaultPinTheme.copyWith(
                                    decoration: defaultPinTheme.decoration!.copyWith(
                                      borderRadius: borderRadius,
                                      border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                                    ),
                                    textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                  followingPinTheme: defaultPinTheme.copyWith(
                                    decoration: defaultPinTheme.decoration!.copyWith(
                                      borderRadius: borderRadius,
                                      border: Border.all(color: AppColors.lightGrey),
                                    ),
                                  ),
                                  submittedPinTheme: defaultPinTheme.copyWith(
                                    textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 19, fontWeight: FontWeight.w600),
                                    decoration: defaultPinTheme.decoration!.copyWith(
                                      borderRadius: borderRadius,
                                      border: Border.all(color: Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  errorPinTheme: defaultPinTheme.copyBorderWith(
                                    border: Border.all(color: Colors.redAccent),
                                  ),
                                  onClipboardFound: (value) {
                                    if (value is int) {
                                      con.otpController.value.setText(value);
                                    }
                                  },
                                  onCompleted: (pin) async {
                                    /// VERIFY MOBILE OTP API
                                    await AuthRepository.verifyMobileOtpAPI(
                                      loader: con.isLoading,
                                      mobileNumber: con.userMobileNumberWithISDCode,
                                      otp: con.otpController.value.text.trim(),
                                    );
                                  },
                                  onChanged: (pin) async {
                                    con.checkOTPButtonDisableStatus();
                                    con.otpValidation.value = true;
                                    con.otpError.value = "";
                                  },
                                ),

                                // OTP Resend Note And Button
                                UiUtils.fadeSwitcherWidget(
                                  duration: const Duration(milliseconds: 150),
                                  child: con.isTimerComplete.isTrue
                                      ? Row(
                                          key: ValueKey<bool>(con.isTimerComplete.value),
                                          children: [
                                            Text(
                                              "Don't receive? ",
                                              style: AppTextStyle.subtitleStyle(context),
                                            ),
                                            GestureDetector(
                                              onTap: con.isResendOtp.isFalse
                                                  ? () async {
                                                      con.isResendOtp.value = true;

                                                      /// RESEND MOBILE OTP API
                                                      await AuthRepository.resendOtpToMobileNumAPI(
                                                        loader: con.isResendOtp,
                                                        mobileNumber: con.userMobileNumberWithISDCode,
                                                        onSuccess: () {
                                                          con.timerStart();
                                                        },
                                                      );
                                                    }
                                                  : null,
                                              child: Text(
                                                con.isResendOtp.isFalse ? "Resend OTP" : "OTP Resending...",
                                                key: ValueKey(con.isResendOtp.value),
                                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                      fontSize: 13.sp,
                                                      decoration: con.isResendOtp.isFalse ? TextDecoration.underline : null,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          key: ValueKey<bool>(con.isTimerComplete.value),
                                          children: [
                                            Text(
                                              "Resend code in ",
                                              style: AppTextStyle.subtitleStyle(context),
                                            ),
                                            AnimatedFlipCounter(
                                              value: con.timeLimit.value,
                                              wholeDigits: 2,
                                              prefix: "00:",
                                              textStyle: AppTextStyle.subtitleStyle(
                                                context,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                ).paddingOnly(top: defaultPadding / 2, left: defaultPadding / 4),
                              ],
                            ),
                          ),
                          (defaultPadding * 1.5).verticalSpace,

                          /// SEND & VERIFY OTP BUTTON
                          AppButton(
                            title: switch (con.screenType.value) {
                              AuthScreenType.login => 'Request OTP',
                              AuthScreenType.otpVerification => 'Verify',
                            },
                            loader: con.isLoading.value,
                            disableButton: switch (con.screenType.value) {
                              AuthScreenType.login => false,
                              AuthScreenType.otpVerification => con.disableButton.value,
                            },
                            borderRadius: BorderRadius.circular(defaultRadius * 4),
                            margin: EdgeInsets.symmetric(horizontal: defaultPadding.w),
                            padding: EdgeInsets.only(top: defaultPadding.h),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();

                              switch (con.screenType.value) {
                                case AuthScreenType.login:
                                  if (con.mobileValidation()) {
                                    /// SEND MOBILE OTP API
                                    await AuthRepository.sendOtpToPhoneNumberAPI(
                                      loader: con.isLoading,
                                      mobileNumber: con.userMobileNumberWithISDCode,
                                      onSuccess: () {
                                        con.timerStart();
                                        con.otpController.value.clear();
                                        con.isLoading.value = false;
                                        con.screenType.value = AuthScreenType.otpVerification;
                                      },
                                    );
                                  }
                                  break;

                                case AuthScreenType.otpVerification:
                                  if (con.isResendOtp.isFalse) {
                                    /// VERIFY MOBILE OTP API
                                    await AuthRepository.verifyMobileOtpAPI(
                                      loader: con.isLoading,
                                      mobileNumber: con.userMobileNumberWithISDCode,
                                      otp: con.otpController.value.text.trim(),
                                    );
                                  }

                                  break;
                                default:
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// POLICIES AGREEMENT DETAILS
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
                          // color: !UiUtils.keyboardIsOpen.value ? Theme.of(context).colorScheme.surface : null,
                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + defaultPadding * 1.5),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "By using the ${AppStrings.appName} app you agree to our\n",
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
                                  recognizer: TapGestureRecognizer()..onTap = con.isLoading.isFalse ? () => ApiUtils.privacyPolicyNav() : null,
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
        ),
      ),
    );
  }

  PinTheme get defaultPinTheme {
    return PinTheme(
      width: 47,
      height: 56,
      margin: EdgeInsets.symmetric(horizontal: defaultPadding / 4),
      textStyle: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(color: con.otpError.isEmpty ? Theme.of(Get.context!).primaryColor.withOpacity(.3) : Theme.of(Get.context!).colorScheme.error),
      ),
    );
  }

  BorderRadiusGeometry get borderRadius {
    return BorderRadius.circular(9);
  }
}

import 'package:get/get.dart';

class AppStrings {
  const AppStrings._();

  /// HOW TO USE: Text(AppStrings.appName);

  static RxString appName = "Pingaksh".obs; //? This Variable fill in BaseController

  /// APP INFO LINKS
  static String appSlug = "App";
  static String androidSlug = "Android";
  static String iOSSlug = "iOS";

  /// APPLICATIONS URL
  static String playStoreURL = "https://play.google.com/store/apps/details?id=com.";
  static String appStoreURL = "https://apps.apple.com/us/app/gotilo-maze-king/id0000000000";

  /// APP INFO LINKS
  static String privacyURL = "https://www.quetzalpos.com/contact";
  static String termsURL = "https://www.quetzalpos.com/contact";
  static String aboutUsURL = "https://www.quetzalpos.com/contact";
  static String contactUsURL = "https://www.quetzalpos.com/contact";
  static String contactMobileNumber = "+917666862553";
  static String contactEmailID = "hello@pingaksh.co";

  static String noInternetAvailable = "No Internet available";

  static String defaultUserProfileURL = "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg";
  static String defaultPingakshLogoURL = "https://yt3.googleusercontent.com/4Cm5FVfm_c4bZ5CzBpxLUxLSIOr9f3uttmvwdua_WOGC1FeWqLSzI2rmohyCsmL2Lm9mSJt4Gg=s900-c-k-c0x00ffffff-no-rj";

  static String otpSendSuccessfully = "OTP Send Successfully";
  static String logoutString = "Are you sure you want to logout?";
  static String exitAppString = "Are you sure you want to quit the application?";
  static String deleteAccountString = "Are you sure you want to delete your account?";
  static String otpErrorText = 'Please enter 6 digit OTP';
  static String invalidOTP = 'Invalid OTP. Please try again.';
  static String otpVerificationSuccessfully = "OTP verification successfully";
  static String loginSuccessfully = "Login Successfully";
}

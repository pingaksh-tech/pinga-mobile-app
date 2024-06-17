import 'package:get/get.dart';

class AppStrings {
  const AppStrings._();

  /// HOW TO USE: Text(AppStrings.appName);

  static RxString appName = "".obs; //? This Variable fill in BaseController

  /// Applications links
  static String playStoreLink = "https://play.google.com/store/apps/details?id=com.";
  static String appStoreLink = "https://apps.apple.com/us/app/gotilo-maze-king/id0000000000";

  static String contactUs = "https://www.quetzalpos.com/contact";

  static String noInternetAvailable = "No Internet available";

  static String defaultUserProfileURL = "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg";


  static String otpSendSuccessfully = "OTP Send Successfully";
  static String logoutString = "Are you sure you want to logout?";
  static String exitAppString = "Are you sure you want to quit the application?";
  static String deleteAccountString = "Are you sure you want to delete your account?";
  static String otpErrorText = 'Please enter 6 digit OTP';
  static String invalidOTP = 'Invalid OTP. Please try again.';
  static String otpVerificationSuccessfully = "OTP verification successfully";
}

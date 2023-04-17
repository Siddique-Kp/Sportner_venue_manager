import 'package:flutter/material.dart';

import '../../home/view/bottom_navbar_view.dart';
import '../../home/view/create_venue_view.dart';
import '../../home/view/home_view.dart';
import '../../vendor_registration/view/login_view.dart';
import '../../vendor_registration/view/otp_page_view.dart';
import '../../vendor_registration/view/sign_up_view.dart';
import '../../vendor_registration/view/splash_screen_view.dart';

class AppScreens {
  static const homeScreen = "/homeScreen";
  static const loginScreen = "/userLogin";
  static const signUpScreen = "/userSignUp";
  static const otpScreen = "/otpRegister";
  static const splashScreen = "/splashScreen";
  static const mainScreen = "/mainScreen";
  static const createVenuefrstScreen = "/createVenuefrstScreen";
  static const createVenueScndScreen = "/createVenueScndScreen";
  static const createVenueThirdScreen = "/createVenueThirdScreen";

  static Map<String, Widget Function(BuildContext)> routes = {
    "/splashScreen": (context) => const SplashScreen(),
    "/userSignUp": (context) => const VendorSignUpScreen(),
    "/userLogin": (context) => const VendorLoginScreen(),
    "/otpRegister": (context) => const OtpVerificationPage(),
    "/homeScreen": (context) => const HomeScreenView(),
    "/mainScreen": (context) => BottomBarView(),
    "/createVenuefrstScreen": (context) => CreateVenueView(),
  };
}

import 'package:flutter/material.dart';

import '../../home/view/bottom_navbar_view.dart';
import '../../home/view/create_venue_scnd_view.dart';
import '../../home/view/create_venue_third_view.dart';
import '../../home/view/create_venue_view.dart';
import '../../home/view/bookings_view.dart';
import '../../vendor_registration/view/login_view.dart';
import '../../vendor_registration/view/otp_page_view.dart';
import '../../vendor_registration/view/sign_up_view.dart';
import '../../vendor_registration/view/splash_screen_view.dart';

class AppScreens {
  static const loginScreen = "/userLogin";
  static const signUpScreen = "/userSignUp";
  static const otpScreen = "/otpRegister";
  static const splashScreen = "/splashScreen";
  static const mainScreen = "/mainScreen";
  static const bookingsScreenView = "/BookingsScreenView";
  static const createVenuefrstScreen = "/createVenuefrstScreen";
  static const createVenueScndScreen = "/createVenueScndScreen";
  static const createVenueThirdScreen = "/createVenueThirdScreen";

  static Map<String, Widget Function(BuildContext)> routes = {
    "/splashScreen": (context) => const SplashScreen(),
    "/userSignUp": (context) => const VendorSignUpScreen(),
    "/userLogin": (context) => const VendorLoginScreen(),
    "/otpRegister": (context) => const OtpVerificationPage(),
    "/BookingsScreenView": (context) => const BookingsScreenView(),
    "/mainScreen": (context) => BottomBarView(),
    "/createVenuefrstScreen": (context) => CreateVenueView(),
    "/createVenueScndScreen": (context) => const CreateVenueScndView(),
    "/createVenueThirdScreen": (context) => const CreateVenueThirdView(),
  };
}

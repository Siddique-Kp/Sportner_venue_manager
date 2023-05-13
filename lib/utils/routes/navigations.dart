import 'package:flutter/material.dart';

import '../../home/view/bottom_navbar_view.dart';
import '../../home/view/create_venue_scnd_view.dart';
import '../../home/view/create_venue_third_view.dart';
import '../../home/view/create_venue_view.dart';
import '../../home/view/bookings_view.dart';
import '../../home/view/select_map_view.dart';
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
  static const selectMapScreen = "/selectMapScreen";

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
    "/selectMapScreen": (context) => const SelectMapView(),
  };

  static Route animatedRoute({
    required dynamic route,
    double dx = 0.0,
    double dy = 1.0,
    bool fade = true,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = Offset(dx, dy);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return fade
            ? FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: child,
                ),
              )
            : SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
      },
    );
  }
}

import 'dart:developer';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportner_venue_manager/home/view/bottom_navbar_view.dart';
import 'package:sportner_venue_manager/vendor_registration/view/login_view.dart';
import 'package:sportner_venue_manager/utils/keys.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          log(snapshot.data.toString());
          return AnimatedSplashScreen(
            splashIconSize: double.infinity,
            splash: Padding(
              padding: const EdgeInsets.all(50.0),
              child: SizedBox(
                width: double.infinity,
                child: SvgPicture.asset(
                  "assets/LOGO.svg",
                ),
              ),
            ),
            nextScreen: snapshot.data!,
          );
        },
      ),
    );
  }
}

Future<Widget> loginStatus() async {
  final status = await SharedPreferences.getInstance();
  final vendorLoggedIn = status.getBool(GlobalKeys.vendorLoggedIN);
  final vendorSignedIn = status.getBool(GlobalKeys.vendorSignedUp);
  final vendorSignedWithGoogle = status.getBool(GlobalKeys.vendorLoggedWithGoogle);
  if (vendorLoggedIn == false ||
      vendorLoggedIn == null && vendorSignedIn == false ||
      vendorSignedIn == null && vendorSignedWithGoogle == false ||
      vendorSignedWithGoogle == null) {
    return const VendorLoginScreen();
  }
  return  BottomBarView();
}

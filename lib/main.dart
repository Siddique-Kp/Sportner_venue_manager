import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view/bottom_navbar_view.dart';
import 'package:sportner_venue_manager/home/view/home_view.dart';
import 'package:sportner_venue_manager/home/view_model/bottom_navbar_view_model.dart';
import 'package:sportner_venue_manager/vendor_registration/view_model/firebase_auth_view_model.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';
import 'package:sportner_venue_manager/vendor_registration/view/login_view.dart';
import 'package:sportner_venue_manager/vendor_registration/view/otp_page_view.dart';
import 'package:sportner_venue_manager/vendor_registration/view/sign_up_view.dart';
import 'package:sportner_venue_manager/vendor_registration/view/splash_screen_view.dart';
import 'package:sportner_venue_manager/vendor_registration/view_model/sign_up_view_model.dart';

import 'vendor_registration/view_model/login_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignUpViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseAuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'sportner turf booking app',
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldColor,
          // primarySwatch: PrimaryColor.appColor,
          primaryColor: AppColors.appColor,
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                AppColors.kButtonColor,
              ),
            ),
          ),
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white,
            iconTheme: IconThemeData(
              color: AppColors.black,

            ),
              titleTextStyle: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              elevation: 1),
        ),
        routes: {
          "/splashScreen": (context) => const SplashScreen(),
          "/userSignUp": (context) => const VendorSignUpScreen(),
          "/userLogin": (context) => const VendorLoginScreen(),
          "/otpRegister": (context) => const OtpVerificationPage(),
          "/homeScreen": (context) => const HomeScreenView(),
          "/mainScreen": (context) =>  BottomBarView(),
        },
        initialRoute: "/splashScreen",
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

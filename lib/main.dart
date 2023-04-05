import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view/home_view.dart';
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
            scaffoldBackgroundColor: MyColors.scaffoldColor,
            // primarySwatch: PrimaryColor.appColor,
            primaryColor: MyColors.appMainGreenColor,
            elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(MyColors.kButtonColor),
              ),
            ),
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                  color: MyColors.scaffoldColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 0)),
        routes: {
          "/splashScreen": (context) => const SplashScreen(),
          "/userSignUp": (context) => const VendorSignUpScreen(),
          "/userLogin": (context) => const VendorLoginScreen(),
          "/otpRegister": (context) => const OtpVerificationPage(),
          "/homeScreen": (context) => const HomeScreenView(),
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



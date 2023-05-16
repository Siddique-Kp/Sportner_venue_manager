import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view_model/booking_view_model.dart';
import 'package:sportner_venue_manager/home/view_model/bottom_navbar_view_model.dart';
import 'package:sportner_venue_manager/home/view_model/google_map_view_model.dart';
import 'package:sportner_venue_manager/home/view_model/quick_book_view_model.dart';
import 'package:sportner_venue_manager/home/view_model/venue_details_view_model.dart';
import 'package:sportner_venue_manager/utils/routes/navigations.dart';
import 'package:sportner_venue_manager/vendor_registration/view_model/firebase_auth_view_model.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';
import 'package:sportner_venue_manager/vendor_registration/view_model/sign_up_view_model.dart';
import 'home/view_model/create_venue_view_model.dart';
import 'home/view_model/edit_venue_view_model.dart';
import 'home/view_model/home_view_model.dart';
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
        ChangeNotifierProvider(
          create: (context) => CreateVenueViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookingViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => GoogleMapViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditVenueViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => VenueDetailsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => QuickBookViewModel(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
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
                    elevation: 3),
              ),
              routes: AppScreens.routes,
              initialRoute: "/splashScreen",
            );
          }),
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

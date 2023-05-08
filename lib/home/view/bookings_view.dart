import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/components/error_data_widget.dart';
import 'package:sportner_venue_manager/home/components/normal_alert_box.dart';
import 'package:sportner_venue_manager/home/view_model/booking_view_model.dart';
import 'package:sportner_venue_manager/home/view_model/bottom_navbar_view_model.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import '../../utils/global_colors.dart';
import '../../vendor_registration/view_model/firebase_auth_view_model.dart';
import '../components/bookings_components/booking_card.dart';

class BookingsScreenView extends StatelessWidget {
  const BookingsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingViewModel = context.watch<BookingViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        centerTitle: true,
        title: const Text(
          "Bookings",
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              NormalAlertBox.alertBox(
                context: context,
                title: "Log out!",
                content: "Do you want to logout",
                onPressed: () {
                       context.read<FirebaseAuthViewModel>().vendorLoginStatus(context);
              context.read<BottomNavViewModel>().changeBottomNavindex(0);
                },
              );
         
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => bookingViewModel.getBookingDatas(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.appColor,
                Color.fromARGB(202, 103, 211, 151),
                Color.fromARGB(255, 168, 214, 189),
                Color.fromARGB(255, 255, 255, 255),
              ],
            ),
          ),
          child: bookingViewModel.errorData?.code == 404
              ? const NoInternetWidget()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView(
                    children: [
                      AppSizes.kHeight20,
                      BookingCard(
                        bookingDataList: bookingViewModel.bookingDataList,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

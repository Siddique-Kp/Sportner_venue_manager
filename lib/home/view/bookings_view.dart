import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                context
                    .read<FirebaseAuthViewModel>()
                    .vendorLoginStatus(context);
                context.read<BottomNavViewModel>().changeBottomNavindex(0);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: FutureBuilder(
              future: context.read<BookingViewModel>().getBookingDatas(),
              builder: (context, snapshot) {
                final bookingDataList =
                    context.watch<BookingViewModel>().bookingDataList;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null) {
                  return const Center(
                    child: Text("No bookings yet"),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
                return ListView(
                  children: [
                    AppSizes.kHeight20,
                    BookingCard(bookingDataList: bookingDataList),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

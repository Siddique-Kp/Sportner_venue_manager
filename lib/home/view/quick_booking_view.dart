import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view_model/quick_book_view_model.dart';

import '../../utils/global_colors.dart';
import '../../utils/global_values.dart';
import '../../utils/textstyles.dart';
import '../components/quick_booking_component/available_sport_widget.dart';
import '../components/quick_booking_component/booking_button_widget.dart';
import '../components/quick_booking_component/date_container_widget.dart';
import '../components/quick_booking_component/facility_widget.dart';
import '../components/quick_booking_component/time_managment_widget.dart';
import '../view_model/venue_details_view_model.dart';

class QuickBookingView extends StatelessWidget {
  const QuickBookingView({super.key});

  @override
  Widget build(BuildContext context) {
        final venueData = context.watch<VenueDetailsViewModel>().venueData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<QuickBookViewModel>().clearBookingSelection();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Booking",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvailableSportsWidget(venueData: venueData),
              AppSizes.kHeight20,
              const Divider(thickness: 2, color: AppColors.black),
              AppSizes.kHeight20,
              const FacilityWidget(),
              AppSizes.kHeight20,
              Text("Select Date", style: AppTextStyles.textH2),
              AppSizes.kHeight20,
              const DateContainerWidget(),
              AppSizes.kHeight30,
              const TimeManageWidget()
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BookingSlotBottomBar(),
    );
  }
}
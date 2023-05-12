import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/components/bookings_components/booking_loading_widget.dart';
import 'package:sportner_venue_manager/home/components/error_data_widget.dart';
import 'package:sportner_venue_manager/home/view_model/booking_view_model.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import '../../utils/global_colors.dart';
import '../components/bookings_components/booking_card.dart';
import '../components/bookings_components/bookings_pop_up_button.dart';

class BookingsScreenView extends StatelessWidget {
  const BookingsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingViewModel = context.watch<BookingViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Text(
          "Bookings",
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        elevation: 0,
        actions: const [
          BookingsPopUpButton(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => bookingViewModel.getBookingDatas(),
        child: bookingViewModel.isLoading
              ? const BookingLoadingWidget()
              :  Container(
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
          child:bookingViewModel.errorCode == 404
                  ? const NoInternetWidget()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ListView(
                        children: [
                          AppSizes.kHeight10,
                          BookingCard(
                            bookingDataList: bookingViewModel.allbookingList,
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}

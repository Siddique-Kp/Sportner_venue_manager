import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/components/venues_list_components/sports_icon.dart';
import 'package:sportner_venue_manager/home/model/booking_data_model.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/textstyles.dart';
import '../../view_model/booking_view_model.dart';
import 'separator.dart';

class BookingCard extends StatelessWidget {
  final List<BookingDataModel> bookingDataList;
  const BookingCard({
    super.key,
    required this.bookingDataList,
  });

  @override
  Widget build(BuildContext context) {
    final bookingViewModel = context.read<BookingViewModel>();
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: bookingDataList.length,
      separatorBuilder: (context, index) => AppSizes.kHeight10,
      itemBuilder: (context, index) {
        final isBookingExpired =
            bookingViewModel.isBookingExpired(bookingDataList[index]);
        return Card(
          elevation: 0,
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  _cardTopSide(
                      index: index,
                      context: context,
                      isBookingExpired: isBookingExpired),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SeparatorWidget(),
                  ),
                  _cardBottomSide(index),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Expanded _cardBottomSide(int index) {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.blueAccent,
                    size: 20,
                  ),
                  Text(
                    bookingDataList[index].name!,
                    style: AppTextStyles.textH4,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.sportscourt,
                    color: Colors.green,
                    size: 18,
                  ),
                  AppSizes.kWidth5,
                  Text(
                    bookingDataList[index].venueName!,
                    style: AppTextStyles.textH5,
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${bookingDataList[index].paymentType} Payment",
                style: AppTextStyles.textH4grey,
              ),
              Text(
                "₹${bookingDataList[index].price}",
                style: const TextStyle(
                  color: AppColors.appColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Expanded _cardTopSide({
    required int index,
    required BuildContext context,
    required bool isBookingExpired,
  }) {
    final bookingViewModel = context.read<BookingViewModel>();
    return Expanded(
      flex: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _timeContainer(
            isBookingExpired: isBookingExpired,
            time: bookingViewModel.convertTo12HourFormat(
              bookingDataList[index].slotTime!.split("-").first,
            ),
            status: "From",
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(Sports.spots(sport: bookingDataList[index].sport!)),
                  Text(
                    bookingDataList[index].facility!,
                    style: AppTextStyles.textH4,
                  ),
                ],
              ),
              Text(
                bookingDataList[index].slotDate!,
                style: AppTextStyles.textH5,
              ),
            ],
          ),
          _timeContainer(
            isBookingExpired: isBookingExpired,
            time: bookingViewModel.convertTo12HourFormat(
              bookingDataList[index].slotTime!.split("-").last,
            ),
            status: "To",
          ),
        ],
      ),
    );
  }

  Column _timeContainer({
    required String time,
    required String status,
    required bool isBookingExpired,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: time.split(" ").first,
                style: AppTextStyles.textH1,
              ),
              TextSpan(
                text: " ${time.split(" ").last}",
                style: AppTextStyles.textH5,
              ),
            ],
          ),
        ),
        Container(
          height: 20,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            color: isBookingExpired
                ? const Color.fromARGB(213, 244, 67, 54)
                : const Color.fromARGB(175, 0, 180, 100),
          ),
          child: Center(
            child: Text(
              status,
              style: AppTextStyles.textH5White,
            ),
          ),
        ),
      ],
    );
  }
}

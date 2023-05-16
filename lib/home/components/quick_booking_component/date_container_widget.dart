import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view_model/quick_book_view_model.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../view_model/venue_details_view_model.dart';

class DateContainerWidget extends StatelessWidget {
  const DateContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bookingViewModel = context.read<QuickBookViewModel>();
    final venueViewModel = context.read<VenueDetailsViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      venueViewModel.getDayIndex(
          DateFormat('EEEE').format(bookingViewModel.selectedDate!));
    });

    bookingViewModel.getSlotAvailability(venueId: venueViewModel.venueData.id!);
    

    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.075,
      width: double.infinity,
      child: Row(
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => AppSizes.kWidth5,
            itemBuilder: (context, index) {
              return _dateContainer(index, context, size);
            },
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: bookingViewModel.selectedDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 15)),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: AppColors.appColor,
                        buttonTheme: const ButtonThemeData(
                            textTheme: ButtonTextTheme.primary,
                            buttonColor: AppColors.appColor),
                        colorScheme:
                            const ColorScheme.light(primary: AppColors.appColor)
                                .copyWith(secondary: AppColors.appColor),
                      ),
                      child: child!,
                    );
                  },
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    bookingViewModel.setDate(
                      selectedDate,
                      venueViewModel.venueData.id,
                    );
                    venueViewModel.getDayIndex(DateFormat('EEEE')
                        .format(bookingViewModel.selectedDate!));
                  }
                });
              },
              icon: const Icon(Icons.calendar_month_outlined, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateContainer(index, BuildContext context, Size size) {
    final bookingViewModel = context.watch<QuickBookViewModel>();
    final venueViewModel = context.watch<VenueDetailsViewModel>();
    final dates = bookingViewModel.dates;
    final lastLimitDate = DateTime.now().add(const Duration(days: 15));
    bool isDateEnabled = true;
    if (dates[index].isAfter(lastLimitDate)) {
      isDateEnabled = false;
    }
    final dateStyle = TextStyle(
      color: !isDateEnabled
          ? AppColors.grey
          : bookingViewModel.selectedDate == dates[index]
              ? AppColors.white
              : Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
    return GestureDetector(
      onTap: isDateEnabled
          ? () {
              bookingViewModel.setSelectedDate(
                dates[index],
                venueViewModel.venueData.id.toString(),
              );
              venueViewModel.getDayIndex(
                  DateFormat('EEEE').format(bookingViewModel.selectedDate!));
            }
          : null,
      child: Container(
        width: size.width * 0.15,
        decoration: BoxDecoration(
          border: Border.all(
            color: !isDateEnabled
                ? AppColors.lightgrey
                : bookingViewModel.selectedDate == dates[index]
                    ? AppColors.appColor
                    : AppColors.black,
          ),
          borderRadius: BorderRadius.circular(6),
          color: bookingViewModel.selectedDate == dates[index]
              ? AppColors.appColor
              : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(DateFormat('MMM').format(dates[index]), style: dateStyle),
              Text(dates[index].day.toString(), style: dateStyle),
              Text(DateFormat('EEE').format(dates[index]).toUpperCase(),
                  style: dateStyle)
            ],
          ),
        ),
      ),
    );
  }
}

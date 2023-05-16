import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view_model/quick_book_view_model.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';
import '../../model/venue_details_model.dart';
import '../../view_model/venue_details_view_model.dart';

class TimeManageWidget extends StatelessWidget {
  const TimeManageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final quickBookViewModel = context.watch<QuickBookViewModel>();
    // final venueViewModel = context.watch<VenueDetailsViewModel>();
    String chosenTime = quickBookViewModel.selectedTime;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text("From", style: AppTextStyles.textH2),
            AppSizes.kHeight20,
            _timeContainer(
              context,
              isFromSlot: true,
              choosenTime: quickBookViewModel
                  .convertTo12HourFormat(chosenTime.split("-").first),
            ),
          ],
        ),
        Container(
          height: 90,
          width: 1.5,
          color: AppColors.black,
        ),
        Column(
          children: [
            Text("To", style: AppTextStyles.textH2),
            AppSizes.kHeight20,
            _timeContainer(
              context,
              isFromSlot: false,
              choosenTime: quickBookViewModel
                  .convertTo12HourFormat(chosenTime.split("-").last),
            )
          ],
        )
      ],
    );
  }

  Widget _timeContainer(
    BuildContext context, {
    required String choosenTime,
    required bool isFromSlot,
  }) {
    return GestureDetector(
      onTap: () async {
        if (isFromSlot) {
          _showSlotsBottomSheet(context, true);
        } else if (!isFromSlot) {
          _showSlotsBottomSheet(context, false);
        }
      },
      child: Container(
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.lightgrey,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(choosenTime, style: AppTextStyles.textH4),
                AppSizes.kWidth5,
                const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showSlotsBottomSheet(BuildContext context, bool isFromSlot) {
    final venueViewModel = context.read<VenueDetailsViewModel>();
    final quickBookViewModel = context.read<QuickBookViewModel>();

    return showModalBottomSheet(
      context: context,
      builder: (context) {
        List<Slot> venueDataSlot = venueViewModel.venueData.slots!;
        return Container(
          margin: const EdgeInsets.all(20),
          child: venueDataSlot[venueViewModel.dayIndex].slots!.isEmpty
              ? Wrap(
                  children: [
                    Center(
                        child: Text("No Slots", style: AppTextStyles.textH4)),
                  ],
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 45,
                  ),
                  shrinkWrap: true,
                  itemCount:
                      venueDataSlot[venueViewModel.dayIndex].slots!.length,
                  itemBuilder: (BuildContext context, int slotIndex) {
                    final canSelectTimeslot =
                        quickBookViewModel.canSelectTimeSlot(
                      isFromSlot: isFromSlot,
                      slotIndex: slotIndex,
                      context: context,
                    );

                    final isBookedSlot = quickBookViewModel.slotAvailability.any(
                        (element) =>
                            element.slotTime ==
                            venueDataSlot[venueViewModel.dayIndex]
                                .slots![slotIndex]);
                    return InkWell(
                      onTap: canSelectTimeslot && !isBookedSlot
                          ? () {
                              quickBookViewModel.setSelectedTime(
                                venueDataSlot[venueViewModel.dayIndex]
                                    .slots![slotIndex],
                              );
                              Navigator.pop(context);
                            }
                          : null,
                      child: Material(
                        elevation:isBookedSlot?0: 1,
                        borderRadius: BorderRadius.circular(7),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: isBookedSlot
                                ? AppColors.red
                                : AppColors.lightgrey,
                          ),
                          child: Center(
                            child: Text(
                              quickBookViewModel.convertTo12HourFormat(
                                  quickBookViewModel.timeSlotText),
                              style: TextStyle(
                                color: isBookedSlot
                                    ? AppColors.grey
                                    : canSelectTimeslot
                                        ? AppColors.black
                                        : AppColors.lightgrey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

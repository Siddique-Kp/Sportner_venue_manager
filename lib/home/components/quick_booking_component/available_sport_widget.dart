import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view_model/quick_book_view_model.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';
import '../../model/venue_details_model.dart';
import '../venues_list_components/sports_icon.dart';

class AvailableSportsWidget extends StatelessWidget {
  final VenueDataModel venueData;
  const AvailableSportsWidget({
    super.key,
    required this.venueData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available Sports",
          style: AppTextStyles.textH3,
        ),
        AppSizes.kHeight20,
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: venueData.sportFacility!.length,
                separatorBuilder: (context, index) => AppSizes.kWidth10,
                itemBuilder: (BuildContext context, int index) {
                  return _soprtContainer(index, context, venueData);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _soprtContainer(
    int index,
    BuildContext context,
    VenueDataModel venueData,
  ) {
    final bookingSlotViewModel = context.watch<QuickBookViewModel>();
    bool isSelected = index == bookingSlotViewModel.selectedSport;
    final icons = Sports.spots(sport: venueData.sportFacility![index].sport!);
    return InkWell(
      onTap: () {
        bookingSlotViewModel.setSelectedSport(
          index,
          venueData.sportFacility![index].facility!,
          venueData.sportFacility![index].sport!,
        );
      },
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isSelected ? AppColors.appColor : AppColors.lightgrey,
          ),
          width: 70.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icons,
                color: isSelected ? AppColors.white : AppColors.black,
              ),
              AppSizes.kHeight10,
              Text(
                venueData.sportFacility![index].sport!.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: isSelected ? AppColors.white : AppColors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view_model/create_venue_view_model.dart';
import 'package:sportner_venue_manager/utils/textstyles.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../model/create_venue_model.dart';
import '../../model/sports_data_model.dart';
import '../venues_list_components/sports_icon.dart';

class SelectSportWidget extends StatelessWidget {
  const SelectSportWidget({
    super.key,
    required this.allSports,
    required this.createVenueModel,
  });

  final SportsDataModel? allSports;
  final CreateVenueViewModel createVenueModel;

  @override
  Widget build(BuildContext context) {
    return
     Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select sports", style: AppTextStyles.textH4),
        AppSizes.kHeight10,
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: allSports!.response!.length,
            separatorBuilder: (context, index) => AppSizes.kWidth5,
            itemBuilder: (context, sportIndex) {
              return GestureDetector(
                onTap: () {
                  final defaultFacility = 
                      allSports!.response![sportIndex].facilityDetails!.first;
                  context
                      .read<CreateVenueViewModel>()
                      .setSelectSport(sportIndex, allSports,defaultFacility);

                  if (createVenueModel.selectedSportIndex
                      .contains(sportIndex)) {
                    _facilityBottomSheet(context, sportIndex);
                    createVenueModel.setDefaultFacility(defaultFacility);
                  }
                  log(createVenueModel.selectedFacility
                      .map((e) => e.facility)
                      .toString());
                  log(createVenueModel.selectedFacility.length.toString());
                },
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color:
                        createVenueModel.selectedSportIndex.contains(sportIndex)
                            ? AppColors.appColor
                            : AppColors.lightgrey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Icon(
                      Sports.spots(
                          sport: allSports!.response![sportIndex].sport!),
                      color: createVenueModel.selectedSportIndex
                              .contains(sportIndex)
                          ? AppColors.white
                          : AppColors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  _facilityBottomSheet(context, int sportIndex) {
    List<FacilityDetail> facilities =
        allSports!.response![sportIndex].facilityDetails!;
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select facility",
                    style: AppTextStyles.textH5,
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: facilities.length,
                    itemBuilder: (BuildContext context, int facilityIndex) {
                      return _radioButton(
                        sportIndex,
                        facilityIndex,
                        context,
                        facilities,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _radioButton(
    int sportIndex,
    int facilityIndex,
    BuildContext context,
    List<FacilityDetail> facilities,
  ) {
    final facility = facilities[facilityIndex];
    final createVenueModel = context.watch<CreateVenueViewModel>();
    final sports = allSports!.response![sportIndex];
    for (SportFacility facility in createVenueModel.selectedFacility) {
      log('${facility.sport} (${facility.facility})');
    }
    return Row(
      children: [
        Radio(
          value: facility,
          groupValue: createVenueModel.facility,
          activeColor: AppColors.appColor,
          onChanged: (value) {
            createVenueModel.setSelectedFacility(value!, sports.id!);
          },
        ),
        Text(facility.facility.toString())
      ],
    );
  }
}

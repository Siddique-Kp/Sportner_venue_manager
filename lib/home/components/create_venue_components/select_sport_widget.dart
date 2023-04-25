import 'package:flutter/material.dart';
import 'package:sportner_venue_manager/utils/textstyles.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../model/sports_data_model.dart';
import '../venues_list_components/sports_icon.dart';

class SelectSportWidget extends StatelessWidget {
  const SelectSportWidget({
    super.key,
    required this.allSports,
  });

  final SportsDataModel? allSports;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select sports"),
        AppSizes.kHeight10,
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: allSports!.response!.length,
            itemBuilder: (context, index1) {
              return InkWell(
                onTap: () {
                  _facilityBottomSheet(context, index1);
                },
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.lightgrey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Icon(
                      Sports.spots(sport: allSports!.response![index1].sport!),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => AppSizes.kWidth5,
          ),
        )
      ],
    );
  }

  _facilityBottomSheet(context, int index1) {                                   
    return showModalBottomSheet(                                                
      context: context,
      builder: (context) {
        return Wrap(
          direction: Axis.vertical,
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
                itemCount: allSports!.response![index1].facilityDetails!.length,
                itemBuilder: (BuildContext context, int index2) {
                  return _radioButton(index1,index2, context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _radioButton(int index1,int index2, BuildContext context) {
    // final bookingSlotViewModel = context.watch<BookingSlotViewModel>();
    final values = allSports!.response![index1].facilityDetails![index2];
    return Row(
      children: [
        Radio(
          value: values,
          groupValue: null,
          activeColor: AppColors.appColor,
          onChanged: (value) {
            // bookingSlotViewModel.setRadioButton(value.toString());
          },
        ),
        Text(values.facility.toString())
      ],
    );
  }
}

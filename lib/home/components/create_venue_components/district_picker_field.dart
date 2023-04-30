import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/utils/textstyles.dart';
import '../../../utils/districts.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../view_model/create_venue_view_model.dart';

class DistrictPickerField extends StatelessWidget {
  const DistrictPickerField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final createVenueModel = context.watch<CreateVenueViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSizes.kHeight5,
         Text("District",style: AppTextStyles.textH4),
        AppSizes.kHeight5,
        DropdownButtonFormField<String>(
          borderRadius: BorderRadius.circular(5),
          validator: (value) {
            if (value == 'Select District' || value == null || value.isEmpty) {
              return "Select a district";
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: AppColors.appColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          value: createVenueModel.districtName,
          onChanged: (String? newDistrict) {
            if (newDistrict != null) {
              context.read<CreateVenueViewModel>().getDistrict(newDistrict);
            }
          },
          items: Districts.districts.map(
            (String district) {
              return DropdownMenuItem<String>(
                value: district,
                child: Text(district),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}

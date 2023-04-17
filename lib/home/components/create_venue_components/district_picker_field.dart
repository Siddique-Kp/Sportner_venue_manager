import 'package:flutter/material.dart';

import '../../../utils/districts.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';

class DistrictPickerField extends StatelessWidget {
  const DistrictPickerField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Select District';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSizes.kHeight5,
        const Text("District"),
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
          value: dropdownValue,
          onChanged: (String? newValue) {
            if (newValue != null) {
              // setState(() {
              //   dropdownValue = newValue;
              // });
            }
          },
          items: Districts.districts.map((String district) {
            return DropdownMenuItem<String>(
              value: district,
              child: Text(district),
            );
          }).toList(),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view_model/quick_book_view_model.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';

class FacilityWidget extends StatelessWidget {
  const FacilityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final quickBookViewModel = context.watch<QuickBookViewModel>();
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Text("Facility", style: AppTextStyles.textH2),
        quickBookViewModel.facility.isEmpty ?AppSizes.kWidth5 :_radioButton(context)
        ],
      ),
    );
  }

  Widget _radioButton(BuildContext context) {
    final quickBookViewModel = context.watch<QuickBookViewModel>();
    final value = quickBookViewModel.facility;
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: quickBookViewModel.selectedRadioButton,
          activeColor: AppColors.appColor,
          onChanged: (value) {
            quickBookViewModel.setRadioButton(value.toString());
          },
        ),
        Text(value)
      ],
    );
  }
}

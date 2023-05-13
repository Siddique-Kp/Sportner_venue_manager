import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/components/glass_snack_bar.dart';
import 'package:sportner_venue_manager/home/view_model/create_venue_view_model.dart';
import 'package:sportner_venue_manager/home/view_model/edit_venue_view_model.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import 'package:sportner_venue_manager/utils/routes/navigations.dart';
import 'package:sportner_venue_manager/utils/textstyles.dart';
import 'package:sportner_venue_manager/vendor_registration/components/snackbar.dart';
import '../components/create_venue_components/google_map_widget.dart';
import '../components/create_venue_components/select_time_slot_components.dart';
import '../components/error_data_widget.dart';

class CreateVenueThirdView extends StatelessWidget {
  const CreateVenueThirdView({
    super.key,
    this.isEditVenue = false,
    this.venueId = "",
  });

  final bool isEditVenue;
  final String venueId;

  @override
  Widget build(BuildContext context) {
    final createVenueViewModel = context.watch<CreateVenueViewModel>();
    final title = isEditVenue ? "Edit your" : "Add new";
    return Scaffold(
      appBar: AppBar(
        title: Text("$title venue"),
        centerTitle: true,
      ),
      body: createVenueViewModel.errorData?.code == 404
          ? const NoInternetWidget()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSizes.kHeight20,
                      _selectLocation(context),
                      AppSizes.kHeight30,
                      _selecTimeSlot(),
                    ],
                  ),
                  _submitbutton(context, venueId),
                ],
              ),
            ),
    );
  }

  Widget _submitbutton(BuildContext context, String venueId) {
    final createVenueViewModel = context.watch<CreateVenueViewModel>();
    final editVenueViewModel = context.watch<EditVenueViewModel>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 40.h,
            width: 100.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                disabledBackgroundColor: AppColors.lightgrey,
              ),
              onPressed: createVenueViewModel.createVenueThirdValidate()
                  ? () {
                      if (isEditVenue) {
                        context
                            .read<EditVenueViewModel>()
                            .editVenueApiService(
                                context: context, venueId: venueId)
                            .then((value) {
                          if (value == true) {
                            Navigator.pushNamedAndRemoveUntil(context,
                                AppScreens.mainScreen, (route) => false);
                            GlassSnackBar.snackBar(
                                context: context,
                                title: "Venue updated",
                                subtitle: "Venue updated successfully");
                          } else {
                            SnackBarWidget.snackBar(
                                context, "Could not update venue");
                          }
                        });
                      } else {
                        context
                            .read<CreateVenueViewModel>()
                            .createVenueApiService(context);
                      }
                    }
                  : null,
              child:
                  createVenueViewModel.isLoading || editVenueViewModel.isLoading
                      ? const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        )
                      : Text(isEditVenue ? "UPDATE" : "SUBMIT"),
            ),
          )
        ],
      ),
    );
  }

  Column _selecTimeSlot() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select slot",
          style: AppTextStyles.textH3,
        ),
        AppSizes.kHeight20,
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3,
          ),
          itemCount: 7,
          itemBuilder: (BuildContext context, int dayIndex) {
            final days = TimeSlotByDays.days;
            return InkWell(
              onTap: () {
                TimeSlotByDays.timeSlotBottomSheet(
                    context, days[dayIndex], dayIndex);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.lightgrey,
                ),
                child: Center(
                  child: SizedBox(
                    width: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          days[dayIndex],
                          style: AppTextStyles.textH4,
                        ),
                        AppSizes.kWidth10,
                        const Icon(Icons.expand_more),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _selectLocation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(
              EdgeInsets.all(0),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppScreens.selectMapScreen,
            );
          },
          child: const Text("Tap to Select location"),
        ),
        AppSizes.kHeight10,
        Container(
          height: 150,
          width: double.infinity,
          color: AppColors.lightgrey,
          child: const GoogleMapWidget(),
        ),
      ],
    );
  }
}

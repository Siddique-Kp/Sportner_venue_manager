import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';
import '../../view_model/create_venue_view_model.dart';

class VenueImageWidget extends StatelessWidget {
  const VenueImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final createVenueViewModel = context.watch<CreateVenueViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Venue Image", style: AppTextStyles.textH4),
        AppSizes.kHeight10,
        InkWell(
          onTap: () {
            context.read<CreateVenueViewModel>().venueImagePicker(context);
          },
          child: Container(
            height: 170.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey,width: 2),
              borderRadius: BorderRadius.circular(5),
              color: AppColors.grey
            ),
            child: createVenueViewModel.venueImageCloudinary == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.black,
                    ),
                  )
                : createVenueViewModel.venueImageCloudinary!.isEmpty
                    ? const Center(child: Icon(Icons.image))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: Image.network(
                          createVenueViewModel.venueImageCloudinary!,
                          fit: BoxFit.cover,
                        ),
                      ),
          ),
        )
      ],
    );
  }
}

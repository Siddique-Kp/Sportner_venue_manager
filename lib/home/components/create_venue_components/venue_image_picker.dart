import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
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
        const Text("Venue Image"),
        AppSizes.kHeight10,
        InkWell(
          onTap: () {
            context.read<CreateVenueViewModel>().venueImagePicker(context);
          },
          child: Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
           
              child: createVenueViewModel.venueImage == null
                  ? const Center(child:  Icon(Icons.image))
                  : ClipRRect(
                    child: Image.file(
                        createVenueViewModel.venueImage!,
                        fit: BoxFit.cover,
                        
                      ),
                  ),
            
          ),
        )
      ],
    );
  }
}

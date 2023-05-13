import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';
import '../../view_model/create_venue_view_model.dart';

class DocumentImagePicker extends StatelessWidget {
  const DocumentImagePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final createVenueViewModel = context.watch<CreateVenueViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text("Document",style: AppTextStyles.textH4),
        AppSizes.kHeight10,
        InkWell(
          onTap: ()async {
          await  context
                .read<CreateVenueViewModel>()
                .documentPicker(context);
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(166, 220, 220, 220),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text(
                        "Choose file",
                        style: TextStyle(
                          color: AppColors.appColor,
                        ),
                      ),
                    ),
                  ),
                  AppSizes.kWidth10,
                  Expanded(
                    child: Text(
                      createVenueViewModel.venueDocumentName == "" ||
                      createVenueViewModel.venueDocumentName == null
                          ? "Add Venue Document"
                          : createVenueViewModel.venueDocumentName!
                              .split("/")
                              .last,
                              overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

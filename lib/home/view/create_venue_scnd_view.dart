import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view_model/create_venue_view_model.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import '../components/create_venue_components/discount_and_amount_field.dart';
import '../components/create_venue_components/document_image_picker.dart';
import '../components/create_venue_components/venue_image_picker.dart';

class CreateVenueScndView extends StatelessWidget {
  const CreateVenueScndView({super.key});

  @override
  Widget build(BuildContext context) {
    final createVenueViewModel = context.watch<CreateVenueViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new venue"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            AppSizes.kHeight30,
            const DocumentImagePicker(),
            AppSizes.kHeight10,
            DiscountAndAmountField(
              controller: createVenueViewModel.venuePriceCntrllr,
              title: "Amount",
              hintText: "Per Hour",
            ),
            AppSizes.kHeight10,
            DiscountAndAmountField(
              controller: createVenueViewModel.venueDiscountCntrllr,
              title: "Dicount %",
              hintText: "Percentage%",
            ),
            AppSizes.kHeight20,
            const VenueImageWidget()
          ],
        ),
      ),
    );
  }
}



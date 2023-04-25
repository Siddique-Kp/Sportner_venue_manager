import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view_model/create_venue_view_model.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import 'package:sportner_venue_manager/utils/routes/navigations.dart';

import '../components/create_venue_components/district_picker_field.dart';
import '../components/create_venue_components/venue_text_field.dart';

class CreateVenueView extends StatelessWidget {
  CreateVenueView({super.key});
  final _firstKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final createVenueViewModel = context.watch<CreateVenueViewModel>();
    final createVenueViewModelRead = context.watch<CreateVenueViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new venue"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _firstKey,
              child: Column(
                children: [
                  AppSizes.kHeight20,
                  VenueTextFldWidget(
                    controller: createVenueViewModel.venueNameCntrllr,
                    title: "Venue name",
                    hintText: "Enter Venue name",
                  ),
                  VenueTextFldWidget(
                    controller: createVenueViewModel.venueMobileCntrllr,
                    title: "Mobile",
                    hintText: "Enter mobile number",
                    keyboardType: TextInputType.number,
                    isMobile: true,
                  ),
                  VenueTextFldWidget(
                    controller: createVenueViewModel.venueAddressCntrllr,
                    title: "Address",
                    hintText: "Enter address",
                  ),
                  const DistrictPickerField(),
                  VenueTextFldWidget(
                    controller: createVenueViewModel.venueDescriptionCntrllr,
                    title: "Description",
                    hintText: "Type something about the venue",
                    isDescription: true,
                  ),
                  AppSizes.kHeight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () async {
                            await context
                                .read<CreateVenueViewModel>()
                                .getAllSports();
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(
                                context, AppScreens.createVenueScndScreen);
                            // if (_firstKey.currentState!.validate()) {
                            //   log("form");
                            // }
                          },
                          style: ElevatedButton.styleFrom(elevation: 0),
                          child: const Text("Next"),
                        ),
                      ),
                    ],
                  ),
                  AppSizes.kHeight20,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

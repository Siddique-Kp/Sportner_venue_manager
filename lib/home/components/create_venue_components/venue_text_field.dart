import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../view_model/create_venue_view_model.dart';

class VenueTextFldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool isDescription;
  final bool isMobile;
  final TextInputType keyboardType;
  const VenueTextFldWidget({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.isDescription = false,
    this.isMobile = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final createVenueViewModel = context.watch<CreateVenueViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: createVenueViewModel.isFocused
                  ? Colors.green
                  : AppColors.black,
            ),
          ),
          AppSizes.kHeight5,
          VenueTextField(
            controller: controller,
            isDescription: isDescription,
            keyboardType: keyboardType,
            isMobile: isMobile,
            hintText: hintText,
          ),
        ],
      ),
    );
  }
}

class VenueTextField extends StatelessWidget {
  const VenueTextField({
    super.key,
    required this.controller,
    this.isDescription = false,
    required this.keyboardType,
    this.isMobile = false,
    required this.hintText,
  });

  final TextEditingController controller;
  final bool isDescription;
  final TextInputType keyboardType;
  final bool isMobile;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: isDescription ? 5 : 1,
      keyboardType: keyboardType,
      validator: (value) {
        if (isMobile) {
          if (value == null || value.isEmpty) {
            return "Mobile number is required";
          } else if (value.length != 10) {
            return "Enter valid mobile number";
          }
        }
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(5),
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.appColor),
          borderRadius: BorderRadius.circular(5.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

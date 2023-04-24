import 'package:flutter/material.dart';
import 'venue_text_field.dart';

class DiscountAndAmountField extends StatelessWidget {
  const DiscountAndAmountField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        SizedBox(
          height: 50,
          width: 150,
          child: VenueTextField(
            controller: controller,
            keyboardType: TextInputType.number,
            hintText: hintText,
          ),
        )
      ],
    );
  }
}
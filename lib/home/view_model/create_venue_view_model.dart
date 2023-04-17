import 'package:flutter/material.dart';

class CreateVenueViewModel with ChangeNotifier {
  final venueNameCntrllr = TextEditingController();
  final venueMobileCntrllr = TextEditingController();
  final venueAddressCntrllr = TextEditingController();
  final venueDescriptionCntrllr = TextEditingController();
  final venuePriceCntrllr = TextEditingController();
  final venueDiscountCntrllr = TextEditingController();

  bool _isFocused = false;

  bool get isFocused => _isFocused;

  setFocusTextFld() {
    _isFocused = true;
    notifyListeners();
  }

  setUnFocusTextFld() {
    _isFocused = false;
    notifyListeners();
  }
}

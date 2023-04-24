import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../vendor_registration/components/snackbar.dart';

class CreateVenueViewModel with ChangeNotifier {
  final venueNameCntrllr = TextEditingController();
  final venueMobileCntrllr = TextEditingController();
  final venueAddressCntrllr = TextEditingController();
  final venueDescriptionCntrllr = TextEditingController();
  final venuePriceCntrllr = TextEditingController();
  final venueDiscountCntrllr = TextEditingController();

  bool _isFocused = false;
  File? _venueDocument;
  File? _venueImage;

  bool get isFocused => _isFocused;
  File? get venueDocument => _venueDocument;
  File? get venueImage => _venueImage;

  setFocusTextFld() {
    _isFocused = true;
    notifyListeners();
  }

  setUnFocusTextFld() {
    _isFocused = false;
    notifyListeners();
  }

  // ---- Pick image from gallery

   Future<File?> documentPicker(context) async {
    _venueDocument = await imagePicker(context);
    return _venueDocument;
  }
   Future<File?> venueImagePicker(context) async {
    _venueImage = await imagePicker(context);
    return _venueImage;
  }

  Future<File?> imagePicker(context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }

      final pickedImage = File(image.path);
      // _venueDocument = pickedImage;
      notifyListeners();
      return pickedImage;
    } on PlatformException {
      return SnackBarWidget.snackBar(context, "Something went wrong");
    }
  }
}

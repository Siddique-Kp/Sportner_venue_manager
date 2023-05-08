import 'package:flutter/material.dart';
import '../../utils/textstyles.dart';

class NormalAlertBox {
  static alertBox({
    required BuildContext context,
    required String title,
    required String content,
    required GestureTapCallback onPressed,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
            content,
            style: AppTextStyles.textH4,
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            MaterialButton(
              onPressed: onPressed,
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}

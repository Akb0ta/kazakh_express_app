import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message, bool isMessage) {
    var snackBar = SnackBar(
      backgroundColor: (isMessage) ? AppColors.primary : Colors.red,
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

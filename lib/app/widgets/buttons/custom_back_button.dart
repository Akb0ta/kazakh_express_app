import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

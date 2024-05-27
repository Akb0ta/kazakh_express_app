import 'package:bus_app/app/widgets/custom_indicator.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? function;
  final bool? isLoading;
  final bool? isEnable;
  final Color? color;
  final Color? textColor;
  const CustomButton(
      {super.key,
      required this.text,
      this.color,
      this.textColor,
      this.function,
      this.isEnable = true,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (isEnable == true) ? function : null,
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: (color == null)
              ? (isEnable == true)
                  ? AppColors.kPrimaryGreen
                  : AppColors.kPrimaryGreen.withOpacity(0.5)
              : (isEnable == true)
                  ? color
                  : color!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: (isLoading == false)
                ? Text(
                    text,
                    style: TextStyle(
                        color: (textColor == null)
                            ? AppColors.kPrimaryWhite
                            : textColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )
                : CustomIndicator(
                    size: 24,
                    isWhite: true,
                  )),
      ),
    );
  }
}

import 'package:bus_app/app/screens/navigator/components/gradient_icon.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  final String assetImage;
  final bool isSelected;
  final String text;
  const NavigationItem(
      {super.key,
      required this.assetImage,
      required this.isSelected,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientSvgIcon(
          isSelected: isSelected,
          assetName: assetImage, // Path to your SVG file
          size: (isSelected)
              ? (assetImage.contains('ticket'))
                  ? 36.0
                  : 28
              : (assetImage.contains('ticket'))
                  ? 26.0
                  : 20, // Adjust the size as needed
        ),
        const SizedBox(
          height: 5,
        ),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) => (isSelected)
              ? AppColors.kPrimaryGradientWhite.createShader(bounds)
              : AppColors.kPrimaryGradientWhite.createShader(bounds),
          child: Text(text,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ],
    );
  }
}

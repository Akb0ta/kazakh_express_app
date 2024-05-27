import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookInfoCard extends StatelessWidget {
  final String title;
  final String data;
  final String asset;

  const BookInfoCard(
      {super.key,
      required this.title,
      required this.data,
      required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Image.asset(
          asset,
          color: AppColors.primary,
          height: 50,
          width: 50,
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              data,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        )
      ]),
    );
  }
}

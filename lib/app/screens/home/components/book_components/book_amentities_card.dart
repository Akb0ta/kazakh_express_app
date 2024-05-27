import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class BookAmenitiesCard extends StatelessWidget {
  const BookAmenitiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: AppColors.primary),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCard('LED TV', Icons.tv),
              buildCard('Reading lights', Icons.light),
              buildCard('Free WIFI', Icons.wifi_tethering)
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCard('Snacks', Icons.food_bank),
              buildCard('Chargin points', Icons.charging_station),
              buildCard('Conditioner', Icons.fax_rounded)
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCard('Toilet', Icons.wc),
              buildCard('Pillows and blankets', Icons.fit_screen),
              buildCard('', null),
            ],
          )
        ],
      ),
    );
  }

  buildCard(text, icon) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (icon != null)
              ? Icon(
                  icon,
                  color: Colors.white,
                )
              : SizedBox(),
          SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

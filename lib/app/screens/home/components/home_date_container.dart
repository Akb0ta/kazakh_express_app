import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class HomeSearchDate extends StatelessWidget {
  final String title;
  final String value;
  const HomeSearchDate({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          // width: double.infinity,
          // height: 200,
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary, width: 1),
            borderRadius: BorderRadius.circular(5),
            shape: BoxShape.rectangle,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.calendar_month,
                color: Colors.black54,
              ),
              SizedBox(
                width: 10,
              ),
              (value == '')
                  ? Text(
                      'DD/MM/YYYY',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    )
                  : Text(
                      value,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
            ],
          ),
        ),
        Positioned(
          left: 30,
          top: 12,
          child: Container(
            padding: EdgeInsets.only(bottom: 0, left: 10, right: 10),
            color: Colors.white,
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}

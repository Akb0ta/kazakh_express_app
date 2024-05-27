import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class HomeCountContainer extends StatelessWidget {
  final String title;
  final int count;
  final Function() onAdd;
  final Function() onDelete;

  const HomeCountContainer(
      {super.key,
      required this.title,
      required this.count,
      required this.onAdd,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
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
              GestureDetector(onTap: onDelete, child: Icon(Icons.remove)),
              SizedBox(
                width: 10,
              ),
              Text(count.toString()),
              SizedBox(
                width: 10,
              ),
              GestureDetector(onTap: onAdd, child: Icon(Icons.add)),
            ],
          ),
        ),
        Positioned(
          left: 25,
          top: 12,
          child: Container(
            padding: EdgeInsets.only(bottom: 0, left: 3, right: 3),
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

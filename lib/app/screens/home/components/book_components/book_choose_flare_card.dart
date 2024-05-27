import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class BookChooseFlareCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String price;
  final List datas;
  final bool isSelected;
  const BookChooseFlareCard(
      {super.key,
      required this.title,
      required this.price,
      required this.isSelected,
      required this.subTitle,
      required this.datas});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: (isSelected == false) ? AppColors.primary : Colors.amberAccent,
          borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Center(
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 18),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              subTitle,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            children: datas.map<Widget>((e) {
              return Row(
                children: [
                  (e['isCheck'] == true)
                      ? CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.check,
                            size: 15,
                            color: Colors.white,
                          ))
                      : CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: Colors.white,
                          )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    e['text'],
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 16),
                  )
                ],
              );
            }).toList(),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                price + ' KZT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }
}

import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class BookStopCard extends StatelessWidget {
  final routesData;

  const BookStopCard({super.key, required this.routesData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.primary, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 69, 90, 100),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Icon(
                    Icons.bus_alert,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  Text(
                    routesData['aPointStation'],
                    style: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(routesData['startTime'] + ', ' + routesData['aPoint'],
                      style: TextStyle(
                          color: Colors.grey[100], fontWeight: FontWeight.w500))
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: routesData['stops'].map<Widget>((e) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.bus_alert),
                    SizedBox(
                      width: 35,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e['name'],
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          e['stopStart'] + ' - ' + e['stopFinish'],
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 41, 181, 156),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Icon(
                    Icons.location_searching,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  Text(
                    routesData['bPointStation'],
                    style: TextStyle(
                        color: Colors.grey[100], fontWeight: FontWeight.w500),
                  ),
                  Text(routesData['finishTime'] + ', ' + routesData['bPoint'],
                      style: TextStyle(
                          color: Colors.grey[100], fontWeight: FontWeight.w500))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

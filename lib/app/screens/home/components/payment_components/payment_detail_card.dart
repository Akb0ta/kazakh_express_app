import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentInfoCard extends StatelessWidget {
  final resData;
  final localData;
  const PaymentInfoCard(
      {super.key, required this.resData, required this.localData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.primary,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    resData['aPoint'],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text('KZ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600))
                ],
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '⦿ - - - - ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.bus_alert,
                color: Colors.white,
              ),
              Text(
                ' - - - - ⦿',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  Text(
                    resData['bPoint'],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text('KZ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ],
          ),
          Center(
            child: Text(
                localData['date'] +
                    ', ' +
                    localData['passangers'].toString() +
                    ' passanger(s)',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Seat: ' + localData['seat'],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                (localData['fare'].toString() == '0')
                    ? 'Rate: Restriced'
                    : (localData['fare'].toString() == '1')
                        ? 'Rate: Standart'
                        : 'Rate: Fully Flexible',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Price: ' + localData['price'] + ' KZT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    );
  }
}

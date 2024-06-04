import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentInfoCard extends StatelessWidget {
  final resData;
  final localData;
  final selectedSeatsString;
  const PaymentInfoCard(
      {super.key,
      required this.resData,
      required this.localData,
      required this.selectedSeatsString});

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
                'Price: ' +
                    (double.parse(localData['price'].toString()) *
                            selectedSeatsString.length)
                        .toStringAsFixed(0) +
                    ' KZT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Seats: ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                children: selectedSeatsString.map<Widget>((e) {
                  return Text(
                    (e + ', ').toString().toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  );
                }).toList(),
              )
            ],
          )
        ],
      ),
    );
  }
}

import 'package:bus_app/app/screens/home/components/home_payment.page.dart';
import 'package:bus_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class BookCheckCard extends StatelessWidget {
  final int selectedFare;
  final String price;
  final resData;
  final localData;
  final selectedSeatsData;
  const BookCheckCard(
      {super.key,
      required this.selectedFare,
      required this.price,
      required this.resData,
      required this.localData,
      required this.selectedSeatsData});

  @override
  Widget build(BuildContext context) {
    var selectedSeatsString = [];
    for (var i = 0; i < selectedSeatsData.length; i++) {
      if (selectedSeatsData[i] != -1) {
        int rowNumber = (selectedSeatsData[i] ~/ 4) + 1;
        String strSeat = rowNumber.toString() +
            ' ' +
            String.fromCharCode((selectedSeatsData[i] % 4) + 'a'.codeUnitAt(0));
        selectedSeatsString.add(strSeat);
      }
    }

    return Container(
      height: 210,
      color: AppColors.primary,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rate',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    (selectedFare == 0)
                        ? 'Restriced'
                        : (selectedFare == 1)
                            ? 'Standart'
                            : (selectedFare == 2)
                                ? 'Fully Flexible'
                                : 'Not selected',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Fare',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    ((price == '')
                                ? 0
                                : double.parse(price) *
                                    selectedSeatsData.length)
                            .toStringAsFixed(0) +
                        ' KZT',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seat',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                children: selectedSeatsString.map((e) {
                  return Text(
                    e.toUpperCase() + ', ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  );
                }).toList(),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            text: 'Confirm',
            function: () {
              localData['price'] = price.toString();
              localData['fare'] = selectedFare.toString();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePaymentPage(
                          selectedSeatsString: selectedSeatsString,
                          localData: localData,
                          resData: resData,
                        )),
              );
            },
            isEnable: (selectedFare == -1 || selectedSeatsData.contains(-1))
                ? false
                : true,
            color: Colors.white,
            textColor: AppColors.primary,
          )
        ],
      ),
    );
  }
}

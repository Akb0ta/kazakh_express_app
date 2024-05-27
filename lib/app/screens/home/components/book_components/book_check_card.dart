import 'package:bus_app/app/screens/home/components/home_payment.page.dart';
import 'package:bus_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class BookCheckCard extends StatelessWidget {
  final int selectedFare;
  final String price;
  final resData;
  final localData;
  final int seat;
  const BookCheckCard(
      {super.key,
      required this.selectedFare,
      required this.price,
      required this.resData,
      required this.localData,
      required this.seat});

  @override
  Widget build(BuildContext context) {
    String strSeat = 'Not selected';

    if (seat != -1) {
      // Преобразование индекса в номер строки и букву
      int rowNumber = (seat ~/ 4) + 1;
      strSeat = rowNumber.toString() +
          ' ' +
          String.fromCharCode((seat % 4) + 'a'.codeUnitAt(0));

      // Возвращаем строку и букву, образующие место
    }

    return Container(
      height: 170,
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
                    'Seat',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    strSeat.toUpperCase(),
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
                    price.toString() + ' KZT',
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
            height: 30,
          ),
          CustomButton(
            text: 'Confirm',
            function: () {
              localData['seat'] = strSeat.toUpperCase();
              localData['price'] = price.toString();
              localData['fare'] = selectedFare.toString();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePaymentPage(
                          localData: localData,
                          resData: resData,
                        )),
              );
            },
            isEnable: (selectedFare == -1 || seat == -1) ? false : true,
            color: Colors.white,
            textColor: AppColors.primary,
          )
        ],
      ),
    );
  }
}

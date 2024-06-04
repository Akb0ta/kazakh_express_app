import 'dart:async';

import 'package:bus_app/api/api.dart';
import 'package:bus_app/api/local_storage.dart';
import 'package:bus_app/app/functions/global_functions.dart';
import 'package:bus_app/app/screens/home/components/payment_components/payment_detail_card.dart';
import 'package:bus_app/app/screens/home/components/payment_components/payment_success_page.dart';
import 'package:bus_app/app/widgets/buttons/custom_back_button.dart';
import 'package:bus_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_app/app/widgets/modals/fake_pay_modal.dart';
import 'package:bus_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:bus_app/data/local_data.dart';
import 'package:flutter/material.dart';

class HomePaymentPage extends StatefulWidget {
  final resData;
  final localData;
  final selectedSeatsString;
  const HomePaymentPage(
      {super.key,
      required this.resData,
      required this.localData,
      required this.selectedSeatsString});

  @override
  State<HomePaymentPage> createState() => _HomePaymentPageState();
}

class _HomePaymentPageState extends State<HomePaymentPage> {
  TextEditingController cardName = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardDate = TextEditingController();
  TextEditingController cardCvv = TextEditingController();
  TextEditingController promo = TextEditingController();
  String cardNameString = '';
  String cardNumberString = '';
  String cardDateString = '';
  String cardCvvString = '';
  String promoString = '';
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _addListeners();
  }

  void _addListeners() {
    cardName.addListener(() {
      setState(() {
        cardNameString = cardName.text;
      });
    });
    cardNumber.addListener(() {
      setState(() {
        cardNumberString = cardNumber.text;
      });
    });
    cardDate.addListener(() {
      setState(() {
        cardDateString = cardDate.text;
      });
    });
    cardCvv.addListener(() {
      setState(() {
        cardCvvString = cardCvv.text;
      });
    });
    promo.addListener(() {
      setState(() {
        promoString = promo.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [CustomBackButton()],
              ),
              Center(
                child: Text(
                  'Payment',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              PaymentInfoCard(
                resData: widget.resData,
                localData: widget.localData,
                selectedSeatsString: widget.selectedSeatsString,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Credit card details',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(hintText: 'Name on card', controller: cardName),
              SizedBox(
                height: 10,
              ),
              CustomTextField(hintText: 'Card number', controller: cardNumber),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        hintText: 'MM/YY', controller: cardDate),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child:
                        CustomTextField(hintText: 'CVV', controller: cardCvv),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Promo code',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(hintText: 'Promo code', controller: promo),
              SizedBox(
                height: 10,
              ),
              (promo.text == '2024')
                  ? Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Promo code',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Text('400' + ' KZT')
                        ],
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    (promo.text == '2024')
                        ? Text(((double.parse(widget.localData['price']) *
                                        widget.selectedSeatsString.length) -
                                    400)
                                .toStringAsFixed(0) +
                            ' KZT')
                        : Text((double.parse(widget.localData['price']) *
                                    widget.selectedSeatsString.length)
                                .toStringAsFixed(0) +
                            ' KZT')
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              CustomButton(
                text: 'Confirm and pay',
                function: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PaymentModal();
                    },
                  );
                  setState(() {
                    isLoading = true;
                  });
                  await Future.delayed(Duration(seconds: 5));

                  var routeData = await ApiClient()
                      .get('routes', widget.resData['routeID']);
                  for (var i = 0; i < widget.selectedSeatsString.length; i++) {
                    var seatIndex = GlobalFunctions().getSeatIndex(widget
                        .selectedSeatsString[i]
                        .toString()
                        .toLowerCase()
                        .replaceAll(' ', ''));
                    var seatList =
                        GlobalFunctions().createBoolList([seatIndex]);
                    if (routeData!['seats'].length == 0) {
                      routeData['seats'].add({
                        'date': widget.localData['date'].toString(),
                        'seats': seatList
                      });
                      await ApiClient()
                          .update('routes', routeData['routeID'], routeData);
                    } else {
                      bool isExist = false;
                      for (var i = 0; i < routeData['seats'].length; i++) {
                        if (routeData['seats'][i]['date'] ==
                            widget.localData['date']) {
                          isExist = true;
                          routeData['seats'][i]['seats'][seatIndex] = true;
                        }
                      }
                      if (isExist == false) {
                        routeData['seats'].add({
                          'date': widget.localData['date'].toString(),
                          'seats': seatList
                        });
                      }
                      await ApiClient()
                          .update('routes', routeData['routeID'], routeData);
                    }
                  }

                  String userId = await SecureStorage().read('userId') ?? '';
                  var userData = await ApiClient().get('users', userId);
                  var userTickets =
                      userData!['tickets']; // assuming it's a List
                  var newTicket = {
                    'routeId': routeData!['routeID'],
                    'rate': widget.localData['fare'],
                    'date': widget.localData['date'],
                    'seat': widget.selectedSeatsString,
                    'name': userData['name']
                  };

                  var newUserTickets = [...userTickets, newTicket];
                  userData['tickets'] = newUserTickets;
                  await ApiClient().update('users', userId, userData);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentSuccessPage(
                              resData: newTicket,
                            )),
                  );
                  setState(() {
                    isLoading = false;
                  });
                },
                isLoading: isLoading,
                isEnable: (cardName.text.length != 0 &&
                        cardNumber.text.length != 0 &&
                        cardDate.text.length != 0 &&
                        cardCvv.text.length != 0)
                    ? true
                    : false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

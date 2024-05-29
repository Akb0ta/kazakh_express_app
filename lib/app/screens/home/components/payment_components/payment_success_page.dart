import 'dart:async';
import 'package:bus_app/app/screens/navigator/main_navigator.dart';
import 'package:bus_app/app/screens/tickets/components/ticket_card.dart';
import 'package:bus_app/app/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatefulWidget {
  final resData;
  const PaymentSuccessPage({Key? key, required this.resData});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              SizedBox(height: 70),
              Text(
                'Have a good trip!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Your ticket has been booked successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, color: Colors.green),
              ),
              SizedBox(height: 5),
              Text(
                'Thank you for booking your travel with Kazakh Express! We’ve sent a copy of your booking confirmation to your email address. ',
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  'Ticket detail',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 5),
              TicketCard(
                resData: widget.resData,
              ),
              SizedBox(height: 25),
              CustomButton(
                text: 'Finish',
                function: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomNavigationBar()),
                    (Route<dynamic> route) => false,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

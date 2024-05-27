import 'dart:async';
import 'package:bus_app/app/screens/navigator/main_navigator.dart';
import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Use Future.delayed to navigate to the next page after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => CustomNavigationBar()),
        (Route<dynamic> route) => false,
      );
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              SizedBox(height: 100),
              Text(
                'Have a good trip, Muhammad!',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Your ticket has been booked successfully!',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              SizedBox(height: 5),
              Text(
                'Thank you for booking your travel with Kazakh Express! We’ve sent a copy of your booking confirmation to your email address. ',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

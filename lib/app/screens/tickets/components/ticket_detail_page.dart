import 'package:bus_app/app/screens/tickets/components/ticket_card.dart';
import 'package:flutter/material.dart';

class TicketDetailPage extends StatelessWidget {
  final resData;
  const TicketDetailPage({super.key, required this.resData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Column(
              children: resData['seat'].map<Widget>((e) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: TicketCard(
                    resData: resData,
                    seat: e,
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}

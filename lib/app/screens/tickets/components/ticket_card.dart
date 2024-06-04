import 'package:bus_app/const/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatefulWidget {
  final resData;
  final String? seat;
  const TicketCard({super.key, required this.resData, this.seat});

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  DocumentSnapshot? document;
  DocumentSnapshot? document2;

  @override
  void initState() {
    super.initState();
    fetchDocument();
  }

  Future<void> fetchDocument() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('routes')
          .doc(widget.resData['routeId'])
          .get();
      if (snapshot.exists) {
        document = snapshot;
        // DocumentSnapshot snapshot2 = await FirebaseFirestore.instance
        //     .collection('companies')
        //     .doc(document!['companyID'])
        //     .get();
        // document2 = snapshot2;
        setState(() {});
      } else {
        // Handle case where document does not exist
      }
    } catch (error) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 510,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary,
        ),
        child: (document != null)
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              document!['aPoint'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text('KZ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600)),
                            Text(document!['startTime'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
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
                              document!['bPoint'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text('KZ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600)),
                            Text(document!['finishTime'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '------------------------------------------',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Passanger',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                                Text('1 person',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                            Column(
                              children: [
                                Text('Seat',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                                (widget.seat != null)
                                    ? Text(widget.seat.toString().toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400))
                                    : Text(
                                        widget.resData['seat']
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400))
                              ],
                            ),
                            Column(
                              children: [
                                Text('Date',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                                Text(widget.resData['date'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Name',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                                Text(widget.resData['name'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                            Column(
                              children: [
                                Text('Rate',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    (widget.resData['rate'] == '2')
                                        ? 'Fully'
                                        : (widget.resData['rate'] == '1')
                                            ? 'Standart'
                                            : 'Restriced',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                            Column(
                              children: [
                                Text('Rest Stop',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    document!['stops'].length.toString() ?? '1',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            )),
                      ),
                      Text(
                        '------------------------------------',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Container(
                        width: 40,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomLeft: Radius.circular(40),
                            )),
                      )
                    ],
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Show this to driver in bus',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/images/qr.png'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Cencel Reservation',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

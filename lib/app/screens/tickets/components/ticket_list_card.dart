import 'package:bus_app/api/api.dart';
import 'package:bus_app/api/local_storage.dart';
import 'package:bus_app/app/screens/home/components/home_book_page.dart';
import 'package:bus_app/app/screens/tickets/components/ticket_card.dart';
import 'package:bus_app/app/screens/tickets/components/ticket_detail_page.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TicketListCard extends StatefulWidget {
  final data;

  const TicketListCard({
    super.key,
    required this.data,
  });

  @override
  State<TicketListCard> createState() => _TicketListCardState();
}

class _TicketListCardState extends State<TicketListCard> {
  String companyName = '';
  var routeData;

  @override
  void initState() {
    super.initState();
    // Call a separate method to perform asynchronous initialization
    initializeData();
  }

  void initializeData() async {
    await getUserData();
  }

  Future<void> getUserData() async {
    routeData = await ApiClient().get('routes', widget.data['routeId']);
    var companyData =
        await ApiClient().get('companies', routeData['companyID']);
    companyName = companyData!['name'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (routeData != null)
        ? Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.primary,
                )),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/bus.png',
                          width: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(companyName)
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      routeData['startTime'],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      routeData['finishTime'],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      routeData['aPoint'],
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    Column(
                      children: [
                        Text(
                          routeData['estimate'] + ' ',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '⦿ - - - - - ',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.bus_alert,
                              color: Colors.black,
                            ),
                            Text(
                              ' - - - - - ⦿',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                    Text(
                      routeData['bPoint'],
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ],
                ),
                Divider(
                  color: AppColors.primary,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      routeData['prices'][0] +
                          ' KZT - ' +
                          routeData['prices'][2] +
                          ' KZT',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TicketDetailPage(
                                    resData: widget.data,
                                  )),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.primary),
                        child: Center(
                          child: Text(
                            'View more',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

import 'package:bus_app/api/local_storage.dart';
import 'package:bus_app/app/screens/home/components/home_search_card.dart';
import 'package:bus_app/app/screens/tickets/components/ticket_list_card.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({
    super.key,
  });

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  int selectedType = 0;
  DocumentSnapshot? document;
  var activeTickets = [];
  var unactiveTickets = [];
  @override
  void initState() {
    super.initState();
    fetchDocument();
  }

  Future<void> fetchDocument() async {
    try {
      String userId = await SecureStorage().read('userId') ?? '';
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        for (var i = 0; i < snapshot['tickets'].length; i++) {
          DateTime todayDate = DateTime.now();
          List<String> parts = snapshot['tickets'][i]['date'].split('/');
          String formattedDateString = '${parts[2]}-${parts[1]}-${parts[0]}';

          // Parse the formatted date string into a DateTime object
          DateTime targetDate = DateTime.parse(formattedDateString);

          bool isUnActive = todayDate.isAfter(targetDate);
          if (isUnActive) {
            unactiveTickets.add(snapshot['tickets'][i]);
          } else {
            activeTickets.add(snapshot['tickets'][i]);
          }
        }
        document = snapshot;

        setState(() {});
      } else {}
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kPrimaryWhite,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Stack(children: [
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 90),
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'My tickets',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 26),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  (document != null)
                      ? (selectedType == 0)
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15.0, right: 15, left: 15),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: activeTickets.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return TicketListCard(
                                      data: activeTickets[index]);
                                },
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15.0, right: 15, left: 15),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: unactiveTickets.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return TicketListCard(
                                      data: unactiveTickets[index]);
                                },
                              ),
                            )
                      : Center(
                          child: CircularProgressIndicator(),
                        )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 5.5,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 15, color: Colors.grey)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  width: MediaQuery.of(context).size.width / 2.1,
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = 0;
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: (selectedType == 0)
                                    ? AppColors.primary
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            width: MediaQuery.of(context).size.width / 2.3 / 2,
                            height: 35,
                            child: Center(
                              child: Text(
                                'Active',
                                style: TextStyle(
                                  color: (selectedType == 0)
                                      ? Colors.white
                                      : Colors.grey[400],
                                ),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = 1;
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: (selectedType == 1)
                                    ? AppColors.primary
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            width: MediaQuery.of(context).size.width / 2.3 / 2,
                            height: 35,
                            child: Center(
                              child: Text(
                                'History',
                                style: TextStyle(
                                  color: (selectedType == 1)
                                      ? Colors.white
                                      : Colors.grey[400],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}

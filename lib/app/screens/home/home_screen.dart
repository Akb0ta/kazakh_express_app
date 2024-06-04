import 'package:bus_app/api/api.dart';
import 'package:bus_app/app/screens/home/components/home_date_container.dart';
import 'package:bus_app/app/screens/home/components/home_person_count.dart';
import 'package:bus_app/app/screens/home/components/home_search_container.dart';
import 'package:bus_app/app/screens/home/components/search_page.dart';
import 'package:bus_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_app/app/widgets/custom_snackbar.dart';
import 'package:bus_app/app/widgets/modals/search_modal.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:bus_app/data/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedType = 0;
  String fromField = '';
  String toField = '';
  String fromDate = '';
  String toDate = '';
  int adults = 0;
  int children = 0;
  int students = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryBackgroundColor,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
            height: MediaQuery.of(context).size.height / 3.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's book your\nTicket",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width / 1.15,
                height: MediaQuery.of(context).size.height / 1.9,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width / 1.15,
                        height: MediaQuery.of(context).size.height / 2.1,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 10)
                            ]),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          var data = await showModalBottomSheet(
                                            context: context,
                                            backgroundColor: Colors.white,
                                            isScrollControlled: true,
                                            builder: (context) {
                                              return SearchModal();
                                            },
                                          );
                                          fromField = data;
                                          setState(() {});
                                        },
                                        child: HomeSearchContainer(
                                          value: fromField,
                                          title: 'From',
                                        )),
                                    GestureDetector(
                                      onTap: () async {
                                        var data = await showModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.white,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return SearchModal();
                                          },
                                        );
                                        toField = data;
                                        setState(() {});
                                      },
                                      child: HomeSearchContainer(
                                        value: toField,
                                        title: 'To',
                                      ),
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    String lFromField = fromField;
                                    fromField = toField;
                                    toField = lFromField;
                                    setState(() {});
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 60, right: 5),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              width: 1,
                                              color: AppColors.primary)),
                                      child: Icon(
                                        Icons.swap_calls,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            (selectedType == 0)
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          final DateTime? picked =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2025),
                                          );

                                          if (picked != null) {
                                            setState(() {
                                              fromDate =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(picked);
                                            });
                                          }
                                        },
                                        child: HomeSearchDate(
                                          value: fromDate,
                                          title: 'From',
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final DateTime? picked =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2025),
                                          );

                                          if (picked != null) {
                                            setState(() {
                                              toDate = DateFormat('dd/MM/yyyy')
                                                  .format(picked);
                                            });
                                          }
                                        },
                                        child: HomeSearchDate(
                                          value: toDate,
                                          title: 'To',
                                        ),
                                      )
                                    ],
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2025),
                                      );

                                      if (picked != null) {
                                        setState(() {
                                          fromDate = DateFormat('dd/MM/yyyy')
                                              .format(picked);
                                        });
                                      }
                                    },
                                    child: HomeSearchDate(
                                      value: fromDate,
                                      title: 'From',
                                    ),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HomeCountContainer(
                                  onAdd: () {
                                    setState(() {
                                      adults++;
                                    });
                                  },
                                  onDelete: () {
                                    if (adults != 0) {
                                      adults--;
                                    }

                                    setState(() {});
                                  },
                                  count: adults,
                                  title: 'Adults',
                                ),
                                HomeCountContainer(
                                  onAdd: () {
                                    children++;
                                    setState(() {});
                                  },
                                  onDelete: () {
                                    if (children != 0) {
                                      children--;
                                    }

                                    setState(() {});
                                  },
                                  count: children,
                                  title: 'Children',
                                ),
                                HomeCountContainer(
                                  onAdd: () {
                                    students++;
                                    setState(() {});
                                  },
                                  count: students,
                                  onDelete: () {
                                    if (students != 0) {
                                      students--;
                                    }
                                    setState(() {});
                                  },
                                  title: 'Students',
                                )
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            CustomButton(
                                text: 'Search',
                                function: () async {
                                  var data;
                                  if (selectedType == 0) {
                                    if (adults + students + children != 0 &&
                                        fromDate != '' &&
                                        fromField != '' &&
                                        toField != '' &&
                                        toDate != '') {
                                      data = await ApiClient()
                                          .getCompaniesByRoutesAndRoadDay(
                                              fromField,
                                              toField,
                                              fromDate,
                                              toDate,
                                              adults + students + children);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SearchPage(
                                                  localDatas: {
                                                    'from': fromField,
                                                    'to': toField,
                                                    'date': fromDate,
                                                    'passangers': (adults +
                                                            children +
                                                            students)
                                                        .toString()
                                                  },
                                                  resData: data,
                                                )),
                                      );
                                    } else {
                                      CustomSnackBar.show(context,
                                          'Please fill all blank!', false);
                                    }
                                  } else {
                                    if (adults + students + children != 0 &&
                                        fromDate != '' &&
                                        fromField != '' &&
                                        toField != '') {
                                      data = await ApiClient()
                                          .getCompaniesByRoutesAndRoadDay(
                                              fromField,
                                              toField,
                                              fromDate,
                                              toDate,
                                              adults + students + children);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SearchPage(
                                                  localDatas: {
                                                    'from': fromField,
                                                    'to': toField,
                                                    'date': fromDate,
                                                    'passangers': (adults +
                                                            children +
                                                            students)
                                                        .toString()
                                                  },
                                                  resData: data,
                                                )),
                                      );
                                    } else {
                                      CustomSnackBar.show(context,
                                          'Please fill all blank!', false);
                                    }
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(blurRadius: 15, color: Colors.grey)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        width: MediaQuery.of(context).size.width / 2.2,
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
                                  width: MediaQuery.of(context).size.width /
                                      2.3 /
                                      2,
                                  height: 35,
                                  child: Center(
                                    child: Text(
                                      'Round',
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
                                  width: MediaQuery.of(context).size.width /
                                      2.3 /
                                      2,
                                  height: 35,
                                  child: Center(
                                    child: Text(
                                      'One way',
                                      style: TextStyle(
                                        color: (selectedType == 1)
                                            ? Colors.white
                                            : Colors.grey[400],
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';

class BookBusCard extends StatelessWidget {
  final Function(int value) onChoose;
  final selectedBoxes;
  final String date;
  final seatAvailable;
  const BookBusCard(
      {super.key,
      required this.seatAvailable,
      required this.onChoose,
      required this.date,
      required this.selectedBoxes});

  @override
  Widget build(BuildContext context) {
    var generatedSeats = [];
    if (seatAvailable.length == 0) {
      for (int i = 0; i < 15 * 4; i++) {
        generatedSeats.add(false);
      }
    } else {
      var isExist = false;
      for (var seat in seatAvailable) {
        if (seat['date'] == date) {
          generatedSeats = seat['seats'];
          isExist = true;
        }
      }
      if (isExist == false) {
        for (int i = 0; i < 15 * 4; i++) {
          generatedSeats.add(false);
        }
      }
    }

    return Container(
      padding: EdgeInsets.all(15),
      // height: MediaQuery.of(context).size.height / 1.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 207, 189, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100.0), // Rounded corner on the top-left
          topRight: Radius.circular(100.0), // Rounded corner on the top-right
        ),
      ),
      child: Column(children: [
        SizedBox(
          height: 90,
        ),
        Container(
          height: 60,
          color: Colors.white.withOpacity(0.5),
          width: MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.r_mobiledata,
              size: 40,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Container(
            padding: EdgeInsets.all(10),
            color: Colors.white.withOpacity(0.5),
            // width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(child: Text('A'))),
                            SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(child: Text('B'))),
                            SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(child: Text(''))),
                            SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(child: Text('C'))),
                            SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(child: Text('D'))),
                          ],
                        ),
                        Column(
                          children: List.generate(
                            generatedSeats.length ~/ 4,
                            (int columnIndex) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  4, // Each row has 3 seats
                                  (int rowIndex) {
                                    int index = columnIndex * 4 + rowIndex;
                                    bool isAvailable = generatedSeats[index];
                                    if (rowIndex == 1) {
                                      return Row(
                                        children: [
                                          buildSeatContainer(
                                              isAvailable, index),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                              child: Text(
                                            (columnIndex + 1).toString(),
                                            style: TextStyle(fontSize: 18),
                                          )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return buildSeatContainer(
                                          isAvailable, index);
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ))
              ],
            ))
      ]),
    );
  }

  Widget buildSeatContainer(
    bool isAvailable,
    int index,
  ) {
    return InkWell(
      onTap: () {
        onChoose(index);
      },
      child: Container(
        margin: EdgeInsets.all(4),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isAvailable
              ? Color.fromARGB(255, 228, 117, 154)
              : (selectedBoxes.contains(index))
                  ? Colors.amber
                  : Colors.grey[300],
        ),
      ),
    );
  }
}

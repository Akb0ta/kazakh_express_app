import 'package:bus_app/app/screens/home/bloc/home_bloc.dart';
import 'package:bus_app/app/screens/home/components/book_components/book_amentities_card.dart';
import 'package:bus_app/app/screens/home/components/book_components/book_bus_card.dart';
import 'package:bus_app/app/screens/home/components/book_components/book_check_card.dart';
import 'package:bus_app/app/screens/home/components/book_components/book_choose_flare_card.dart';
import 'package:bus_app/app/screens/home/components/book_components/book_info_card.dart';
import 'package:bus_app/app/screens/home/components/book_components/book_stop_card.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookPage extends StatelessWidget {
  final resData;
  final localData;
  const BookPage({super.key, required this.resData, required this.localData});

  // String selectedImage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kPrimaryWhite,
        body: BlocProvider(
          create: (context) => HomeBloc()
            ..add(HomeLoad(
                companyId: resData['companyID'],
                passengetCount: localData['passangers'])),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoaded) {
                return SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 25.0,
                          bottom: 16.0,
                        ),
                        height: MediaQuery.of(context).size.height / 3.8,
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
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: 25,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          resData['aPoint'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        Text('KZ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
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
                                          resData['bPoint'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        Text('KZ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600))
                                      ],
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text(
                                      localData['date'] +
                                          ', ' +
                                          localData['passangers'].toString() +
                                          ' passanger(s)',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      (state.companyData != null)
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 270,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                state.selectedImage))),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: state.companyData['images']
                                        .map<Widget>((e) {
                                      int index = state.companyData['images']
                                          .indexOf(e);
                                      return InkWell(
                                        onTap: () {
                                          BlocProvider.of<HomeBloc>(context)
                                            ..add(HomeChangeSelectedImage(
                                                image: e));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: (index != 0) ? 10 : 5),
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(e))),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  Divider(
                                    color: AppColors.primary,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BookInfoCard(
                                          title: 'Distance',
                                          data: resData['distance'] + ' km',
                                          asset: 'assets/images/distance.png'),
                                      BookInfoCard(
                                          title: 'Estimated time  ',
                                          data: resData['estimate'],
                                          asset: 'assets/images/clock.png'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BookInfoCard(
                                          title: 'Number of stops',
                                          data: state
                                              .companyData['routes'].length
                                              .toString(),
                                          asset: 'assets/images/stop.png'),
                                      BookInfoCard(
                                          title: 'Departure point',
                                          data: resData['aPointStation'],
                                          asset: 'assets/images/location.png'),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : CircularProgressIndicator(),
                      Divider(
                        color: AppColors.primary,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Stops',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: BookStopCard(routesData: resData),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Amenities',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: BookAmenitiesCard(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Choose your set',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromARGB(
                                          255, 228, 117, 154)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Booked')
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Available')
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.orange),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Your Seat')
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: BookBusCard(
                            date: localData['date'],
                            selectedBoxes: state.passengers,
                            onChoose: (value) {
                              BlocProvider.of<HomeBloc>(context)
                                ..add(HomeChangeSelectedIndex(index: value));
                            },
                            seatAvailable: resData['seats']),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<HomeBloc>(context)
                                  ..add(HomeChangeSelectedFare(index: 0));
                              },
                              child: BookChooseFlareCard(
                                  isSelected:
                                      (state.selectedFare == 0) ? true : false,
                                  price: resData['prices'][0],
                                  title: 'Restriced',
                                  subTitle:
                                      'Basic fare type, no travel flexibility',
                                  datas: [
                                    {
                                      'isCheck': false,
                                      'text': 'No journey amendments',
                                    },
                                    {
                                      'isCheck': false,
                                      'text': 'No further discounts',
                                    },
                                    {
                                      'isCheck': false,
                                      'text': 'No cancellations refund',
                                    },
                                    {
                                      'isCheck': true,
                                      'text': 'Baggage 5 kg',
                                    },
                                  ]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<HomeBloc>(context)
                                  ..add(HomeChangeSelectedFare(index: 1));
                              },
                              child: BookChooseFlareCard(
                                  isSelected:
                                      (state.selectedFare == 1) ? true : false,
                                  price: resData['prices'][1],
                                  title: 'Standart',
                                  subTitle: 'Best ticket for most customers',
                                  datas: [
                                    {
                                      'isCheck': true,
                                      'text': 'Can amend ticket with fee',
                                    },
                                    {
                                      'isCheck': true,
                                      'text': 'Can be discounted ',
                                    },
                                    {
                                      'isCheck': false,
                                      'text': 'No cancellations refund',
                                    },
                                    {
                                      'isCheck': true,
                                      'text': 'Baggage 15 kg',
                                    },
                                  ]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<HomeBloc>(context)
                                  ..add(HomeChangeSelectedFare(index: 2));
                              },
                              child: BookChooseFlareCard(
                                  isSelected:
                                      (state.selectedFare == 2) ? true : false,
                                  price: resData['prices'][2],
                                  title: 'Fully Flexible',
                                  subTitle: 'Fully flexible ticket',
                                  datas: [
                                    {
                                      'isCheck': true,
                                      'text': 'Unlimited free amendments',
                                    },
                                    {
                                      'isCheck': true,
                                      'text': 'Can be discounted ',
                                    },
                                    {
                                      'isCheck': true,
                                      'text':
                                          'Full cancellation up to 24 hours ',
                                    },
                                    {
                                      'isCheck': true,
                                      'text': 'Baggage 30 kg',
                                    },
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      BookCheckCard(
                          localData: localData,
                          resData: resData,
                          selectedSeatsData: state.passengers,
                          selectedFare: state.selectedFare,
                          price: (state.selectedFare != -1)
                              ? resData['prices'][state.selectedFare].toString()
                              : ''),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}

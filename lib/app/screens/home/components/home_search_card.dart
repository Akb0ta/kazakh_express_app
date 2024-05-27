import 'package:bus_app/api/api.dart';
import 'package:bus_app/app/screens/home/components/home_book_page.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeSearchCard extends StatefulWidget {
  final data;
  final localData;
  const HomeSearchCard(
      {super.key, required this.data, required this.localData});

  @override
  State<HomeSearchCard> createState() => _HomeSearchCardState();
}

class _HomeSearchCardState extends State<HomeSearchCard> {
  String companyName = '';

  @override
  void initState() {
    super.initState();
    // Call a separate method to perform asynchronous initialization
    initializeData();
  }

  void initializeData() async {
    await getCompaniesNames();
  }

  Future<void> getCompaniesNames() async {
    var companyData =
        await ApiClient().get('companies', widget.data['companyID']);
    setState(() {
      companyName = companyData!['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Container(
                color: Colors.green.withOpacity(0.2),
                padding: EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  'CHEAP',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w700),
                )),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.data['startTime'],
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              Text(
                widget.data['finishTime'],
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
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
                widget.data['aPoint'],
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              Column(
                children: [
                  Text(
                    widget.data['estimate'] + ' ',
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
                widget.data['bPoint'],
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
                widget.data['prices'][0] +
                    ' KZT - ' +
                    widget.data['prices'][2] +
                    ' KZT',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookPage(
                              localData: widget.localData,
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
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

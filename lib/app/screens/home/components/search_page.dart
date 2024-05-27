import 'package:bus_app/app/screens/home/components/home_search_card.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final localDatas;
  final resData;
  const SearchPage(
      {super.key, required this.resData, required this.localDatas});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int selectedType = 0;
  var resData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kPrimaryWhite,
        body: Stack(children: [
          Container(
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
                          padding: const EdgeInsets.only(top: 70.0),
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
                                    widget.localDatas['from'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
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
                                    widget.localDatas['to'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
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
                                widget.localDatas['date'] +
                                    ', ' +
                                    widget.localDatas['passangers'].toString() +
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
                SizedBox(
                  height: 20,
                ),
                (resData.length == 0)
                    ? (widget.resData.length != 0)
                        ? Column(
                            children: widget.resData.map<Widget>((e) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      top: 15, left: 10, right: 10),
                                  child: HomeSearchCard(
                                    localData: widget.localDatas,
                                    data: e,
                                  ));
                            }).toList(),
                          )
                        : Center(
                            child: Text('Not founded!'),
                          )
                    : Column(
                        children: resData.map<Widget>((e) {
                          return Padding(
                              padding:
                                  EdgeInsets.only(top: 15, left: 10, right: 10),
                              child: HomeSearchCard(
                                localData: widget.localDatas,
                                data: e,
                              ));
                        }).toList(),
                      )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 4.1,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 15, color: Colors.grey)],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width / 1.4,
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
                              'recommend',
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
                        selectedType = 1;
                        if (widget.resData.length > 1) {
                          resData = widget.resData.sort((a, b) =>
                              a['prices'][0].compareTo(b['prices'][0]));
                        }
                        setState(() {});
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
                              'fast',
                              style: TextStyle(
                                color: (selectedType == 1)
                                    ? Colors.white
                                    : Colors.grey[400],
                              ),
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedType = 2;
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: (selectedType == 2)
                                  ? AppColors.primary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          width: MediaQuery.of(context).size.width / 2.3 / 2,
                          height: 35,
                          child: Center(
                            child: Text(
                              'cheap',
                              style: TextStyle(
                                color: (selectedType == 2)
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
          ),
        ]));
  }
}
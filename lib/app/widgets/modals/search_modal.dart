import 'package:bus_app/const/app_colors.dart';
import 'package:bus_app/data/local_data.dart';
import 'package:flutter/material.dart';

class SearchModal extends StatefulWidget {
  const SearchModal({super.key});

  @override
  State<SearchModal> createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  late var filteredCities;
  @override
  void initState() {
    super.initState();
    filteredCities = LocalData.instance.locations!['cities'];
  }

  void _search(String query) {
    setState(() {
      print(query);
      print(LocalData.instance.locations!['cities']);
      filteredCities = LocalData.instance.locations!['cities']
          .where((city) =>
              (city as String).toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  void _sortCities() {
    setState(() {
      filteredCities.sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 90),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(border: InputBorder.none),
                        onChanged: (val) {
                          _search(val);
                        },
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.close_sharp)
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                (filteredCities.length != 0)
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15)),
                        child: ListView.builder(
                            itemCount: filteredCities.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(
                                          context, filteredCities[index]);
                                    },
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.place,
                                        color: AppColors.primary,
                                      ),
                                      title: Text(filteredCities[index]),
                                      subtitle: Text('Kazakhstan'),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.25,
                                      child: Container(
                                        width: 1,
                                        height: 1,
                                        color: Colors.black,
                                      ))
                                ],
                              );
                            }),
                      )
                    : Center(
                        child: Text('Not found'),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

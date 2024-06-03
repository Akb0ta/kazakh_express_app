import 'package:bus_app/app/screens/events/components/events_trending_card.dart';
import 'package:bus_app/app/widgets/modals/search_modal.dart';
import 'package:bus_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  TextEditingController search = TextEditingController();
  String searchText = '';
  String city = 'Almaty';
  void _onTextChanged() {
    setState(() {
      searchText = search.text;
    });
  }

  @override
  void initState() {
    super.initState();
    search.addListener(_onTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.primary),
              height: MediaQuery.of(context).size.height / 3.1,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 18,
                    ),
                    Text(
                      'Find\nTrending Events',
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
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
                            city = data;
                            setState(() {});
                          },
                          child: Text(
                            city,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'Search',
                      controller: search,
                      suffixIcon: Icons.search,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Events',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('events')
                        .where('city', isEqualTo: city)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Display a loading indicator while waiting for data
                      }
                      if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}'); // Display an error message if there's an error
                      }
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        return ListView(
                          padding: EdgeInsets.only(top: 10),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            if (searchText.isNotEmpty &&
                                !data['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchText.toLowerCase())) {
                              return SizedBox
                                  .shrink(); // Filter out the item if it doesn't match the search text
                            }
                            return EventsTrendingCard(data: data);
                          }).toList(),
                        );
                      } else {
                        return Text(
                            'No data'); // Handle case where there are no documents in the collection
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

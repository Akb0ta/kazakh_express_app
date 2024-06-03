import 'package:bus_app/api/local_storage.dart';
import 'package:bus_app/app/screens/profile/pages/profile_edit_page.dart';
import 'package:bus_app/app/screens/splash/splash_screen.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DocumentSnapshot? document;

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
        document = snapshot;

        setState(() {});
      } else {}
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: (document != null)
            ? Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.7,
                    decoration: BoxDecoration(color: AppColors.primary),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(68), // Image radius
                                child: Image.network(document!['image'],
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Text(
                              document!['name'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            Text('+7 ' + document!['phone'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileEditPage(
                                    data: document,
                                  )),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                            border: Border.all(color: Colors.black)),
                        child: ListTile(
                          leading: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          title: const Text(
                            'Edit profile',
                            style: TextStyle(color: Colors.black),
                            textScaleFactor: 1.2,
                          ),
                          trailing: const Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                          selected: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () async {
                      await SecureStorage().clearAll();
                      Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => SplashScreen(),
                        ),
                        (route) =>
                            false, //if you want to disable back feature set to false
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                            border: Border.all(color: Colors.black)),
                        child: ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          title: const Text(
                            'Log out',
                            style: TextStyle(color: Colors.black),
                            textScaleFactor: 1.2,
                          ),
                          selected: true,
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2.2),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ),
              ),
      ),
    );
  }
}

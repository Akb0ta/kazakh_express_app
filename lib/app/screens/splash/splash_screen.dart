import 'package:bus_app/api/local_storage.dart';
import 'package:bus_app/app/screens/login/login_screen.dart';
import 'package:bus_app/app/screens/navigator/main_navigator.dart';
import 'package:bus_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeState();
  }

  Future<void> _initializeState() async {
    bool isLogged = false;
    String userId = '';
    try {
      userId = await SecureStorage().read('userId') ?? '';
    } catch (e) {}
    if (userId != '') {
      isLogged = true;
    } else {
      isLogged = false;
    }

    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) =>
              (isLogged) ? CustomNavigationBar() : LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryGreen,
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.black),
                    left: BorderSide(width: 2.0, color: Colors.black),
                    right: BorderSide(width: 2.0, color: Colors.black),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 4, top: 50),
                child: Text(
                  'Welcome to',
                  style: TextStyle(fontSize: 34, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 6, top: 120),
                child: Image.asset(
                  'assets/images/bus.png',
                  width: 300,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 3.5, top: 300),
                child: Text(
                  'Kazakh\nExpress',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 38, color: Colors.white),
                ),
              ),
            ]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                height: MediaQuery.of(context).size.height / 17,
                child: CustomButton(text: "Let's Go")),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Text(
                'The best transfer program in whole Kazahstan! Stay with us!',
                style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:bus_app/api/api.dart';
import 'package:bus_app/api/local_storage.dart';
import 'package:bus_app/app/screens/create/create_screen.dart';
import 'package:bus_app/app/screens/navigator/main_navigator.dart';
import 'package:bus_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_app/app/widgets/custom_snackbar.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class VerifyCodePage extends StatelessWidget {
  final String email;
  final String pass;

  final String pin;

  const VerifyCodePage(
      {super.key, required this.email, required this.pass, required this.pin});

  @override
  Widget build(BuildContext context) {
    TextEditingController pinput = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.kPrimaryBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'by creating an account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3.2),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Verification',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Text(
                            'Please enter verification code , we send to your phone number $email',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Pinput(
                            onCompleted: (String? value) async {
                              if (value.toString() == pin) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateScreen(
                                            email: email,
                                            pass: pass,
                                          )),
                                );
                                // Navigator.of(context).pushAndRemoveUntil(
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           CustomNavigationBar()),
                                //   (Route<dynamic> route) => false,
                                // );
                              } else {
                                CustomSnackBar.show(
                                    context, 'Incorrect pin code!', false);
                              }
                            },
                            autofocus: false,
                            length: 5,
                            androidSmsAutofillMethod:
                                AndroidSmsAutofillMethod.smsUserConsentApi,
                            controller: pinput,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dont receive any code? ',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text(
                              'Resend Again',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 15, color: AppColors.primary),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(text: 'Continue')
                      ],
                    ),
                  ),
                )
              ],
            ),

            // Center(
            //   child: TextButton(
            //       onPressed: () {},
            //       child: Text(
            //         'Resend code',
            //         style: TextStyle(color: AppColors.kPrimaryGreen),
            //       )),
            // )
          ],
        ),
      ),
    );
  }
}

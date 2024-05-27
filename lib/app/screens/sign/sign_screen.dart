import 'package:bus_app/api/api.dart';
import 'package:bus_app/app/screens/login/login_screen.dart';
import 'package:bus_app/app/screens/sign/components/verify_screen.dart';
import 'package:bus_app/app/screens/sign/function/function.dart';
import 'package:bus_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_app/app/widgets/custom_snackbar.dart';
import 'package:bus_app/app/widgets/textfields/custom_phone_textfield.dart';
import 'package:bus_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  bool isShowPassword = true;
  bool isShowrPassword = true;
  bool isLoading = false;
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController rpass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enter your phone'),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 65,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.07),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/kz-flag.png',
                                    width: 24,
                                  ),
                                  Text(
                                    '+7',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 3),
                            Flexible(
                              child: TextFieldInput(
                                hintText: 'Номер телефона',
                                textInputType: TextInputType.phone,
                                textEditingController: phone,
                                isPhoneInput: true,
                                autoFocus: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Enter your password'),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: '*********',
                          controller: pass,
                          isPassword: true,
                          passwordShow: isShowPassword,
                          onTapIcon: () {
                            if (isShowPassword) {
                              isShowPassword = false;
                            } else {
                              isShowPassword = true;
                            }
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Confirm your password'),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: '*********',
                          controller: rpass,
                          isPassword: true,
                          passwordShow: isShowrPassword,
                          onTapIcon: () {
                            if (isShowrPassword) {
                              isShowrPassword = false;
                            } else {
                              isShowrPassword = true;
                            }
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          text: 'Sign Up',
                          isLoading: isLoading,
                          function: () async {
                            isLoading = true;
                            setState(() {});
                            String phoneNumber = phone.text
                                .replaceAll("-", "")
                                .replaceAll("(", "")
                                .replaceAll(")", "");
                            String id = await ApiClient()
                                .fieldExists('users', 'phone', phone.text);

                            if (id == '') {
                              if (phone.text.length != 0 &&
                                  pass.text == rpass.text) {
                                String pin = SignFunctions()
                                    .generateRandomPin()
                                    .toString();
                                bool isSuccess = await SignFunctions()
                                    .sendVerificationCode(
                                        phoneNumber: '7' + phoneNumber,
                                        generatedCode: pin);
                                if (isSuccess) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerifyCodePage(
                                              email: phone.text,
                                              pass: pass.text,
                                              pin: pin,
                                            )),
                                  );
                                } else {
                                  CustomSnackBar.show(context,
                                      'Phone number format error!', false);
                                }
                              } else {
                                CustomSnackBar.show(
                                    context, 'Please fill all fields!', false);
                              }
                            } else {
                              CustomSnackBar.show(context,
                                  'User with this number phone exists!', false);
                            }
                            isLoading = true;
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account? '),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: AppColors.primary, fontSize: 15),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

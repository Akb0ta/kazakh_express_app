import 'package:bus_app/api/api.dart';
import 'package:bus_app/api/local_storage.dart';
import 'package:bus_app/app/screens/navigator/main_navigator.dart';
import 'package:bus_app/app/screens/sign/sign_screen.dart';
import 'package:bus_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_app/app/widgets/custom_snackbar.dart';
import 'package:bus_app/app/widgets/textfields/custom_phone_textfield.dart';
import 'package:bus_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isShowPassword = true;
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isLoading = false;
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
                          'Welcome Back!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Sign In to continue',
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
                            setState(() {
                              if (isShowPassword) {
                                isShowPassword = false;
                              } else {
                                isShowPassword = true;
                              }
                              setState(() {});
                            });
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Forgot password?',
                                style: TextStyle(
                                    color: AppColors.primary, fontSize: 15)),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          text: 'Sign In',
                          isLoading: isLoading,
                          function: () async {
                            isLoading = true;
                            setState(() {});
                            String isLogin = await ApiClient()
                                .fieldExists('users', 'phone', phone.text);
                            String isPass = await ApiClient()
                                .fieldExists('users', 'pass', pass.text);
                            if (isLogin == isPass && isLogin != '') {
                              await SecureStorage().create('userId', isLogin);
                              print(isLogin);
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomNavigationBar()),
                                (Route<dynamic> route) => false,
                              );
                            } else {
                              CustomSnackBar.show(context,
                                  'Incorrect login or password!', false);
                            }
                            isLoading = false;
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Dont have an account? '),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => SignScreen()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Text(
                                'Sign Up',
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

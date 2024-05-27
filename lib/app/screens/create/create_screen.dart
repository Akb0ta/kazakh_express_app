import 'package:bus_app/api/api.dart';
import 'package:bus_app/api/local_storage.dart';
import 'package:bus_app/app/functions/global_functions.dart';
import 'package:bus_app/app/screens/navigator/main_navigator.dart';
import 'package:bus_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_app/app/widgets/custom_snackbar.dart';
import 'package:bus_app/app/widgets/modals/search_modal.dart';
import 'package:bus_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateScreen extends StatefulWidget {
  final String email;
  final String pass;
  const CreateScreen({super.key, required this.email, required this.pass});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String selectedDate = '';
  TextEditingController date = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('dd/MM/yyyy').format(picked);
        date.text = selectedDate;
      });
    }
  }

  TextEditingController username = TextEditingController();
  TextEditingController hobby = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController location = TextEditingController();
  String image = '';
  int gender = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryBackgroundColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.kPrimaryBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        image =
                            await GlobalFunctions().uploadImageToImgBB(context);
                        if (image != 'null') {
                          setState(() {});
                          print(image);
                        } else {
                          CustomSnackBar.show(
                              context, 'Error picking image', false);
                        }
                      },
                      child: Center(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.primary,
                                width: 2,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 4,
                            child: (image == '')
                                ? Center(
                                    child: Icon(
                                      Icons.add_photo_alternate,
                                      size: 100,
                                      color: AppColors.primary,
                                    ),
                                  )
                                : Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Username', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    CustomTextField(hintText: '', controller: username),
                    SizedBox(height: 10),
                    Text('Name', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    CustomTextField(hintText: '', controller: name),
                    SizedBox(height: 10),
                    Text('Surname', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    CustomTextField(hintText: '', controller: surname),
                    SizedBox(height: 10),
                    Text('Date of birthday', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        await _selectDate(context);
                      },
                      child: CustomTextField(
                        hintText: 'DD/MM/YYYY',
                        isEnabled: false,
                        controller: date,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Location', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
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
                          location.text = data;
                          setState(() {});
                        },
                        child: CustomTextField(
                          hintText: '',
                          controller: location,
                          isEnabled: false,
                        )),
                    SizedBox(height: 10),
                    Text('Gender', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              gender = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: (gender == 0)
                                        ? AppColors.primary
                                        : const Color.fromARGB(
                                            255, 158, 158, 158)),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, right: 20, left: 20),
                            child: Center(
                              child: Text('Male'),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              gender = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: (gender == 1)
                                        ? AppColors.primary
                                        : const Color.fromARGB(
                                            255, 158, 158, 158)),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, right: 20, left: 20),
                            child: Center(
                              child: Text('Female'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('Interests/Hobbies', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        minLines: 2,
                        maxLines: 5,
                        cursorColor: Colors.black,
                        controller: hobby,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: Colors.grey), // Default border color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color:
                                    Colors.grey), // Border color when focused
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                        height: 50,
                        child: CustomButton(
                          text: 'Create',
                          function: () async {
                            try {
                              String userId =
                                  await ApiClient().create('users', {
                                'phone': widget.email,
                                'pass': widget.pass,
                                'image': image,
                                'hobby': hobby.text,
                                'location': location.text,
                                'name': name.text,
                                'surname': surname.text,
                                'gender': gender.toString(),
                                'username': username.text,
                                'birthday': date.text,
                                'tickets': []
                              });
                              if (userId != '' && userId != 'null') {
                                await SecureStorage().create('userId', userId);
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CustomNavigationBar()),
                                  (Route<dynamic> route) => false,
                                );
                              } else {
                                CustomSnackBar.show(
                                    context, 'Please try again!', false);
                              }
                            } catch (e) {
                              CustomSnackBar.show(
                                  context, 'Please try again!', false);
                            }
                          },
                        )),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

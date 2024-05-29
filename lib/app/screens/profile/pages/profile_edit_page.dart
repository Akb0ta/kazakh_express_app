import 'package:bus_app/api/api.dart';
import 'package:bus_app/app/functions/global_functions.dart';
import 'package:bus_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_app/app/widgets/custom_snackbar.dart';
import 'package:bus_app/app/widgets/modals/search_modal.dart';
import 'package:bus_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  final data;
  const ProfileEditPage({super.key, required this.data});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController hobby = TextEditingController();
  String gender = '';
  String image = '';

  void initializeData() async {
    name.text = widget.data['name'] ?? '';
    userName.text = widget.data['username'] ?? '';
    phone.text = widget.data['phone'] ?? '';
    image = widget.data['image'] ?? "";
    location.text = widget.data['location'] ?? "";
    hobby.text = widget.data['hobby'] ?? "";
    birthday.text = widget.data['birthday'];
    gender = widget.data['gender'] ?? '0';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit profile')),
      backgroundColor: AppColors.kPrimaryBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  image = await GlobalFunctions().uploadImageToImgBB(context);
                  if (image != 'null') {
                    setState(() {});
                    print(image);
                  } else {
                    CustomSnackBar.show(context, 'Error picking image', false);
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
              CustomTextField(hintText: '', controller: userName),
              SizedBox(height: 10),
              Text('Name', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              CustomTextField(hintText: '', controller: name),
              SizedBox(height: 10),
              Text('Date of birthday', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  // await _selectDate(context);
                },
                child: CustomTextField(
                  hintText: 'DD/MM/YYYY',
                  isEnabled: false,
                  controller: birthday,
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
                        gender = '0';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: (gender == '0')
                                  ? AppColors.primary
                                  : const Color.fromARGB(255, 158, 158, 158)),
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
                        gender = '1';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: (gender == '1')
                                  ? AppColors.primary
                                  : const Color.fromARGB(255, 158, 158, 158)),
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
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                          color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                          color: Colors.grey), // Border color when focused
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                text: 'Update',
                function: () async {
                  var data = {
                    'phone': phone.text,
                    'pass': widget.data['pass'],
                    'image': image,
                    'hobby': hobby.text,
                    'location': location.text,
                    'name': name.text,
                    'surname': widget.data['surname'],
                    'gender': gender.toString(),
                    'username': userName.text,
                    'birthday': birthday.text,
                    'tickets': widget.data['tickets'],
                    'userId': widget.data['userId'],
                  };

                  await ApiClient()
                      .update('users', widget.data['userId'], data);
                  CustomSnackBar.show(context, 'Updated successfully!', true);
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

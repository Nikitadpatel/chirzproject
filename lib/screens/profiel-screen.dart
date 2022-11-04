import 'dart:convert';

import 'package:chirz/Model/user_model.dart';
import 'package:chirz/providers/auth-providers.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserModel? userDataModel;

  @override
  void initState() {
    getProfiles();
    super.initState();
  }

  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phone_number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        key: _scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        drawerScrimColor: Colors.transparent,
        drawer: drawerWidgets(context),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading:             GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 1.h),
              child: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.black,
              ),
            ),
          ),

          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            'Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                margin: EdgeInsets.only(right: 1.h),
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.h),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      style: textStyle,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Email';
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                        prefixIcon: Icons.email_outlined,
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    TextFormField(
                      controller: username,
                      style: textStyle,
                      readOnly: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Username';
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                        prefixIcon: Icons.person,
                        hintText: 'Username',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    TextFormField(
                      controller: phone_number,
                      style: textStyle,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Phone Number';
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                        prefixIcon: Icons.phone_android_sharp,
                        hintText: 'Phone Number',
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  alignment: Alignment.bottomCenter,
                  child: buttonWidget(
                    callback: () {
                      FocusScope.of(context).unfocus();
                      updateProfile();
                    },
                    text: 'Update Profile',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isLoading: isLoading,
    );
  }

  TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontSize: 10.sp,
  );

  InputDecoration inputDecoration(
      {required IconData prefixIcon, required String hintText}) {
    return InputDecoration(
      fillColor: Colors.white,
      hoverColor: Colors.white,
      focusColor: Colors.white,
      filled: true,
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.black,
      ),
      hintText: hintText,
      hintStyle: textStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.sp)),
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.sp)),
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
    );
  }

  getProfiles() {
    setState(() {
      isLoading = true;
    });

    checkInternet().then((internet) async {
      if (internet) {
        AuthProviders().getProfileDetails().then((Response response) async {
          userDataModel = UserModel.fromJson(json.decode(response.body));

          if (response.statusCode == 200 && userDataModel?.status == 1) {
            setState(() {
              isLoading = false;
            });
            email.text = userDataModel?.data?.email ?? '';
            phone_number.text = userDataModel?.data?.phoneNumber ?? '';
            username.text = userDataModel?.data?.username ?? '';
          } else {
            setState(() {
              isLoading = false;
            });
          }
        }).catchError((onError) {
          setState(() {
            isLoading = false;
          });
          buildErrorDialog(context, 'Error', 'Something went wrong');
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', 'Internet Required');
      }
    });
  }

  updateProfile() {
    setState(() {
      isLoading = true;
    });

    checkInternet().then((internet) async {
      if (internet) {
        AuthProviders()
            .updateDetails(email.text.trim(), phone_number.text.trim())
            .then((Response response) async {
          userDataModel = UserModel.fromJson(json.decode(response.body));

          if (response.statusCode == 200 && userDataModel?.status == 1) {
            setState(() {
              isLoading = false;
            });
            print(userDataModel?.toJson());
            userData = userDataModel;
            buildErrorDialog(
              context,
              '',
              'Profile Updated',
              callback: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
          } else {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(context, 'Error', userDataModel?.message ?? '');
          }
        }).catchError((onError) {
          setState(() {
            isLoading = false;
          });
          buildErrorDialog(context, 'Error', 'Something went wrong');
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', 'Internet Required');
      }
    });
  }
}

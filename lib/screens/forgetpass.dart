import 'dart:convert';
import 'dart:io';

import 'package:chirz/Model/user_model.dart';
import 'package:chirz/providers/auth-providers.dart';
import 'package:chirz/screens/login.dart';
import 'package:chirz/screens/restaurant.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';

class forgetpass extends StatefulWidget {
  const forgetpass({Key? key}) : super(key: key);

  @override
  State<forgetpass> createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading=false;
  TextEditingController _email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return commanScreen(
      isLoading: isLoading,
      scaffold: Scaffold(
          backgroundColor: whiteColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Forgot Password ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
            ),
          ),
          leading:GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoginScreen()));
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
           ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.h),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: _email,

                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                        validator: (value) {
                          String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                              "\\@" +
                              "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                              "(" +
                              "\\." +
                              "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                              ")+";
                          //Convert string p to a RegEx
                          RegExp regExp = RegExp(p);
                          if (value!.isEmpty) {
                            return 'Please enter Your Email';
                          } else {
                            //If email address matches pattern
                            if (regExp.hasMatch(value)) {
                              return null;
                            } else {
                              //If it doesn't match
                              return 'Email is not valid';
                            }
                          }
                        },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                        focusColor: Colors.white,
                        filled: true,
                        errorStyle: const TextStyle(
                          color: Colors.red,
                        ),
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      )
                    ),
                    SizedBox(height: 9.h,),
                    buttonWidget(
                        radius: 30.r,
                        color: backGroundColor,
                        callback:(){
                          getdata();
                        },
                        text: "submit")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  getdata(){
    print("hii");
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final Map<String, String> data = <String, String>{};
      data['email'] = _email.text.trim().toString();

      data['action'] = 'forget_password';

      checkInternet().then((internet) async {
        if (internet) {
          AuthProviders().forgetapi(data).then((Response response) async {
            userData = UserModel.fromJson(json.decode(response.body));
            print(userData?.status);

            if (response.statusCode == 200 && userData?.status == 1) {
              setState(() {
                isLoading = false;
              });
              BuildErrorDialog(context, "", userData?.message.toString() ?? "");
              //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
           //   await SaveDataLocal.saveLogInData(userData!);
            //  if (kDebugMode) {
             //   print(userData?.toJson().toString());
             // }

            }
            else {
              setState(() {
                isLoading = false;
              });
              buildErrorDialog(context, '', userData?.message.toString() ?? '');
            }
          }).catchError((onError) {
            setState(() {
              isLoading = false;
            });
            print('Eror ' + onError.toString());
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
  BuildErrorDialog(BuildContext context,String title, String contant,
      {VoidCallback? callback, String? buttonname}) {
    Widget okButton = TextButton(
      child: Container(
        height: 40.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20.0),
            color:Color(0xFFB41712)
        ),
        child: Center(
          child: Text(buttonname ?? 'OK',
              // textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.black,
                  fontFamily: 'poppins')),
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
      },
    );
    if (Platform.isAndroid) {
      AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        titlePadding: EdgeInsets.all(0.0),
        contentPadding: EdgeInsets.only(top: 0.0,bottom: 0.0,left: 20.0),
        title: Text(title,
            style: const TextStyle(
                color: Colors.black,
                decorationColor: Colors.black,
                fontFamily: 'poppins')),
        content: Text(contant,
            style: const TextStyle(
                color: Colors.black,
                decorationColor: Colors.black,
                fontFamily: 'poppins')),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    if (Platform.isIOS) {
      CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
        title: Text(title,
            style: const TextStyle(
                color: Colors.black,
                decorationColor: Colors.black,
                fontFamily: 'poppins')),
        content: Text(contant,
            style: const TextStyle(
                color: Colors.black,
                decorationColor: Colors.black,
                fontFamily: 'poppins')),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return cupertinoAlertDialog;
        },
      );
    }
    // show the dialog
  }
}

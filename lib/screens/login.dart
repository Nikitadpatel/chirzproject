import 'dart:convert';
import 'package:chirz/Model/user_model.dart';
import 'package:chirz/providers/auth-providers.dart';
import 'package:chirz/screens/forgetpass.dart';
import 'package:chirz/screens/registration.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/shared-preference.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:http/http.dart';
import 'restaurant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return commanScreen(
      isLoading: isLoading,
      scaffold: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Log in ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => const SplashScreenPage()));
          //   },
          //   child: const Icon(
          //     Icons.arrow_back_ios,
          //     color: Colors.black,
          //   ),
          // ),leading:
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.r),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    controller: email,
                    style: textStyle,
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
                    decoration: inputDecoration(hintText: 'Email'),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  TextFormField(
                    controller: password,
                    style: textStyle,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Password';
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>forgetpass()));
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: backGroundColor,
                          fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //           text: ' By continuing, you agree to our ',
                  //           style:
                  //           TextStyle(color: primaryBlack, fontSize: 12.sp)),
                  //       WidgetSpan(
                  //         child: GestureDetector(
                  //           child: Text(
                  //             'Terms of Service',
                  //             style: TextStyle(
                  //                 color: backGroundColor,
                  //                 fontSize: 12.sp,
                  //                 ),
                  //           ),
                  //           onTap: () async {
                  //             launchURL('https://www.chirz.co.uk/termsofuse');
                  //           },
                  //         ),
                  //       ),
                  //       TextSpan(
                  //           text: '\n and ',
                  //           style:
                  //           TextStyle(color: primaryBlack, fontSize: 12.sp)),
                  //       WidgetSpan(
                  //         child: GestureDetector(
                  //           child: Text(
                  //             'Privacy Policy',
                  //             style: TextStyle(
                  //                 color: backGroundColor,
                  //                 fontSize: 12.sp,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //           onTap: () async {
                  //             launchURL('https://www.chirz.co.uk/privacy-policy');
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'By continuing, you agree to our ',
                        style: TextStyle(
                          color: primaryBlack,
                          fontSize: 13.sp,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          'Terms of Service',
                          style: TextStyle(
                              color: backGroundColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () async {
                          launchURL('https://www.chirz.co.uk/termsofuse');
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'and ',
                        style: TextStyle(
                          color: primaryBlack,
                          fontSize: 13.sp,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                              color: backGroundColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () async {
                          launchURL('https://www.chirz.co.uk/privacy-policy');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    child: buttonWidget(
                      radius: 30.r,
                      color: backGroundColor,
                      callback: () {
                        FocusScope.of(context).unfocus();
                        loginApi();
                      },
                      text: 'Login',
                    ),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account  ',
                        style: TextStyle(
                          color: primaryBlack,
                          fontSize: 12.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Registration(),
                            )),
                        child: Text(
                          'Register Now !',
                          style: TextStyle(
                            color: backGroundColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontSize: 14.sp,
  );

  InputDecoration inputDecoration({required String hintText}) {
    return InputDecoration(
      fillColor: Colors.white,
      hoverColor: Colors.white,
      focusColor: Colors.white,
      filled: true,
      errorStyle: const TextStyle(
        color: Colors.red,
      ),
      hintText: hintText,
      hintStyle: textStyle,
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
    );
  }

  loginApi() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final Map<String, String> data = <String, String>{};
      data['email'] = email.text.trim().toString();
      data['password'] = password.text.trim().toString();
      data['action'] = 'login';

      checkInternet().then((internet) async {
        if (internet) {
          AuthProviders().loginApi(data).then((Response response) async {
            userData = UserModel.fromJson(json.decode(response.body));

            if (response.statusCode == 200 && userData?.status == 1) {
              setState(() {
                isLoading = false;
              });
              await SaveDataLocal.saveLogInData(userData!);
              if (kDebugMode) {
                print(userData?.toJson().toString());
              }
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantsScreen(),
                  ),
                      (route) => false);
            } else {
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
}

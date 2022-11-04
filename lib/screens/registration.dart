import 'dart:convert';
import 'dart:io';

import 'package:chirz/Model/user_model.dart';
import 'package:chirz/providers/auth-providers.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/shared-preference.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'restaurant.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController profileDescription = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKeyTwo = GlobalKey<FormState>();
  File? _pickedFile;

  @override
  Widget build(BuildContext context) {
    return commanScreen(
        isLoading: isLoading,
        scaffold: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Register ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.sp,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.r),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30.r)),
                      child: LinearProgressIndicator(
                        value: 0.2.w,
                        minHeight: 7.h,
                        valueColor:
                        const AlwaysStoppedAnimation<Color>(backGroundColor),
                        backgroundColor: Colors.grey.withOpacity(0.4),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Register Now',
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 5.0.h,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 4.0.h,
                            // ),
                            /*     GestureDetector(
                              onTap: () => _showSelectionDialog(context),
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                height: 80.0,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: _pickedFile != null
                                    ? Image.file(_pickedFile!)
                                    : userData == null ||
                                            (userData?.data?.image?.isEmpty ??
                                                false)
                                        ? Image.asset(
                                            Res.profile_pic_placeholder)
                                        : Image.network(
                                            userData?.data?.image ?? ''),
                              ),
                            ),
                            SizedBox(
                              height: 4.0.h,
                            ),*/
                            Text(
                              "A little bit about you.",
                              style: TextStyle(
                                  color: primaryBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            TextFormField(
                              controller: name,
                              style: textStyle,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Name';
                                }
                                return null;
                              },
                              decoration: inputDecoration(
                                hintText: 'Name',
                              ),
                            ),
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
                              decoration:
                              inputDecoration(hintText: 'Email Address'),
                            ),

                            // TextFormField(
                            //   controller: password,
                            //   style: textStyle,
                            //   obscureText: true,
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Please enter Password';
                            //     }
                            //     return null;
                            //   },
                            //   decoration: inputDecoration(
                            //     prefixIcon: Icons.lock_outline_rounded,
                            //     hintText: 'Password',
                            //   ),
                            // ),

                            // TextFormField(
                            //   controller: confirmPassword,
                            //   obscureText: true,
                            //   style: textStyle,
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Please enter Password';
                            //     }
                            //     return null;
                            //   },
                            //   decoration: inputDecoration(
                            //     prefixIcon: Icons.lock_outline_rounded,
                            //     hintText: 'Confirm Password',
                            //   ),
                            // ),
                            SizedBox(
                              height: 2.h,
                            ),
                            // TextFormField(
                            //   controller: phoneNumber,
                            //   style: textStyle,
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Please enter phoneNumber';
                            //     }
                            //     if (value.length < 10) {
                            //       return 'Please enter Valid phoneNumber';
                            //     }
                            //     return null;
                            //   },
                            //   decoration: inputDecoration(
                            //     prefixIcon: Icons.phone_android_sharp,
                            //     hintText: 'Phone Number',
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 2.h,
                            // ),

                            // SizedBox(
                            //   height: 2.h,
                            // ),
                            /* TextFormField(
                              controller: profileDescription,
                              style: textStyle,
                              decoration: inputDecoration(
                                prefixIcon: Icons.person,
                                hintText: 'Profile Description',
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            TextFormField(
                              controller: city,
                              style: textStyle,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter City';
                                }
                                return null;
                              },
                              decoration: inputDecoration(
                                prefixIcon: Icons.location_city,
                                hintText: 'City',
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            TextFormField(
                              controller: zipcode,
                              style: textStyle,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter ZipCode';
                                }
                                return null;
                              },
                              decoration: inputDecoration(
                                prefixIcon: Icons.code,
                                hintText: 'ZipCode',
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            TextFormField(
                              controller: state,
                              style: textStyle,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter state';
                                }
                                return null;
                              },
                              decoration: inputDecoration(
                                prefixIcon: Icons.real_estate_agent,
                                hintText: 'State',
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            TextFormField(
                              controller: country,
                              style: textStyle,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Country';
                                }
                                return null;
                              },
                              decoration: inputDecoration(
                                prefixIcon: Icons.lock_outline_rounded,
                                hintText: 'Country',
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Container(
                            child: buttonWidget(
                              radius: 30.r,
                              color: backGroundColor,
                              textColor: whiteColor,
                              callback: () {
                                // FocusScope.of(context).unfocus();
                                // registrationApi();
                                if (_formKey.currentState!.validate()) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RegistrationTwo(
                                          name: name.text, email: email.text)));
                                }
                              },
                              text: 'Continue',
                            ),
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       'Already have an account  ',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 11.sp,
                          //       ),
                          //     ),
                          //     GestureDetector(
                          //       onTap: () => Navigator.pop(context),
                          //       child: Text(
                          //         'Login here !',
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 12.sp,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  // second part of registration screen

  Widget RegistrationTwo({required String name, required String email}) {
    String userName = name;
    String userEmail = email;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Register ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.sp,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  child: LinearProgressIndicator(
                    value: 0.4.w,
                    minHeight: 7.h,
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(backGroundColor),
                    backgroundColor: Colors.grey.withOpacity(0.4),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "We need to make sure you're real.",
                style: TextStyle(
                    color: primaryBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp),
              ),
              IntlPhoneField(
                countries: const ['GB'],
                controller: phoneNumber,
                keyboardType: TextInputType.phone,
                flagsButtonPadding: EdgeInsets.symmetric(horizontal: 5.r),
                decoration: const InputDecoration(
                  counter: Offstage(),
                  hintText: 'Mobile Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'GB',
                showDropdownIcon: true,
                dropdownIconPosition: IconPosition.trailing,
              ),
              SizedBox(
                height: 200.h,
              ),
              Container(
                child: buttonWidget(
                  radius: 30.r,
                  color: backGroundColor,
                  callback: () {
                    FocusScope.of(context).unfocus();
                    if (phoneNumber.text.isNotEmpty) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegistrationThird(
                            username: userName,
                            email: userEmail,
                            phoneNum: phoneNumber.text,
                          )));
                    }
                  },
                  text: 'Continue',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // second part of registration screen

  Widget RegistrationThird(
      {required String username,
        required String email,
        required String phoneNum}) {
    return
      Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Register ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.r),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.r),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30.r)),
                    child: LinearProgressIndicator(
                      value: 0.7.w,
                      minHeight: 7.h,
                      valueColor:
                      const AlwaysStoppedAnimation<Color>(backGroundColor),
                      backgroundColor: Colors.grey.withOpacity(0.4),
                    ),
                  ),
                ),
                Text("Add a password",style: TextStyle(color: primaryBlack,fontWeight: FontWeight.bold,fontSize: 17.sp),),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKeyTwo,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          TextFormField(
                            controller: password,
                            style: textStyle,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Password';
                              }
                              return null;
                            },
                            decoration: inputDecoration(
                              hintText: 'Password',
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          TextFormField(
                            controller: confirmPassword,
                            obscureText: true,
                            style: textStyle,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Password';
                              }
                              return null;
                            },
                            decoration: inputDecoration(
                              hintText: 'Confirm Password',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      onTap: () async {
                        launchURL('https://www.chirz.co.uk/termsofuse');
                      },
                    ),
                  ],),
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
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      onTap: () async {
                        launchURL('https://www.chirz.co.uk/privacy-policy');
                      },
                    ),
                  ],),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          child: buttonWidget(
                            radius: 30.r,
                            color: backGroundColor,
                            callback: ()async  {
                              FocusScope.of(context).unfocus();
                              // loginApi();
                              if (_formKeyTwo.currentState!.validate()) {
                                registrationApi();
                              }
                            },
                            text: 'Register',
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      );
  }

  //functions for this screen

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Platform.isAndroid
            ? AlertDialog(
          title: const Text("From where do you want to take the photo?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Padding(padding:  EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop(false);
                    getImageByGallary();
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop(false);
                    getImage();
                  },
                )
              ],
            ),
          ),
        )
            : CupertinoAlertDialog(
          title: const Text("From where do you want to take the photo?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop(false);
                    getImageByGallary();
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop(false);
                    getImage();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 350,
        maxHeight: 350);

    if (pickedFile != null) {
      _pickedFile = File(pickedFile.path);

      _cropImage(_pickedFile);
    } else {
      print('No image selected.');
    }
  }

  Future getImageByGallary() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 350,
        maxHeight: 350);

    if (pickedFile != null) {
      _pickedFile = File(pickedFile.path);

      _cropImage(_pickedFile);
    } else {
      print('No image selected.');
    }
  }

  Future<Null> _cropImage(fileImage) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: fileImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 20, ratioY: 20),
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
        ]
            : [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Image Crop',
            toolbarWidgetColor: Colors.white,
            toolbarColor: backGroundColor,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Image Crop',
        ));
    if (croppedFile != null) {
      _pickedFile = croppedFile;
      setState(() {});
    }
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
      errorStyle: const TextStyle(color: backGroundColor),
      hintText: hintText,
      hintStyle: textStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.sp)),
        borderSide:const BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.sp)),
        borderSide:const BorderSide(
          color: Colors.black,
        ),
      ),
    );
  }

  registrationApi() {
    if (password.text.trim().toString() ==
        confirmPassword.text.trim().toString()) {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        final Map<String, String> data = <String, String>{};
        data['username'] = name.text.trim().toString();
        data['phone_number'] = phoneNumber.text.trim().toString();
        data['email'] = email.text.trim().toString();
        data['password'] = password.text.trim().toString();
        // data['profile_image'] = _pickedFile?.path ??'';
        // data['profile_description'] = profileDescription.text.trim().toString();
        // data['city'] = city.text.trim().toString();
        // data['zipcode'] = zipcode.text.trim().toString();
        // data['state'] = state.text.trim().toString();
        // data['country'] = country.text.trim().toString();
        data['action'] = 'standard_registration';

        checkInternet().then((internet) async {
          if (internet) {
            AuthProviders()
                .registrationApi(data)
                .then((Response response) async {
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
                      builder: (context) => const RestaurantsScreen(),
                    ),
                        (route) => false);
              } else {
                setState(() {
                  isLoading = false;
                });
                buildErrorDialog(
                    context, '', userData?.message.toString() ?? '');
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
    } else {
      buildErrorDialog(
          context, '', 'Passwrod and Confirm Password must be same');
    }
  }
}

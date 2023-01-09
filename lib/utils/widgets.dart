import 'dart:convert';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:chirz/Model/SettingModel.dart';
import 'package:chirz/providers/auth-providers.dart';
import 'package:chirz/screens/bookingDetails.dart';
import 'package:chirz/screens/cartScreen.dart';
import 'package:chirz/screens/favourites.dart';
import 'package:chirz/screens/login.dart';
import 'package:chirz/screens/profiel-screen.dart';
import 'package:chirz/screens/restaurant.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/shared-preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


Widget buttonWidget(
    {required VoidCallback callback,
      required String text,
      Color? textColor,
      double? radius,
      Color color = Colors.black}) {
  return TextButton(
    style: ButtonStyle(
      alignment: Alignment.center,
      backgroundColor: MaterialStateProperty.all(color),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(vertical: 2.h),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 12.sp),
          )),
    ),
    onPressed: () => callback(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            color:textColor ?? Colors.white,
            fontSize: 14.sp,
          ),
        ),
        // const Icon(
        //   Icons.navigate_next,
        //   color: Colors.white,
        // )
      ],
    ),
  );
}

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final Function onPressed;

  const RaisedGradientButton({
    Key? key,
    required this.child,
    required this.gradient,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
        gradient: gradient,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () => onPressed(),
            child: Center(
              child: child,
            )),
      ),
    );
  }
}

class NamedIcon extends StatelessWidget {
  final Widget iconData;
  final VoidCallback? onTap;

  const NamedIcon({
    Key? key,
    this.onTap,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Consumer<CartCounterNotifier>(
            builder: (context, cartCounter, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Badge(
                      position: BadgePosition.topEnd(end: 2),
                      animationDuration: const Duration(milliseconds: 300),
                      animationType: BadgeAnimationType.scale,
                      showBadge: Provider.of<CartCounterNotifier>(context)
                          .value
                          .toString() ==
                          '0'
                          ? false
                          : true,
                      badgeColor: Colors.red,
                      toAnimate: true,
                      badgeContent: Provider.of<CartCounterNotifier>(context)
                          .value
                          .toString() ==
                          '0'
                          ? Container()
                          : Consumer<CartCounterNotifier>(
                          builder: (context, cartCounter, child) {
                            return Text(
                              Provider.of<CartCounterNotifier>(context)
                                  .value
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            );
                          }),
                      child: iconData),
                ],
              );
            }),
      ),
    );
  }
}
//
buildErrorDialog(BuildContext context,String title, String contant,
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
      if (callback == null) {
        Navigator.pop(context);
      } else {
        callback();
      }
    },
  );

  if (Platform.isAndroid) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      titlePadding: EdgeInsets.all(10.0),
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

Widget spinKit = Container(
  decoration: const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.elliptical(15.0, 15.0)),
    gradient: LinearGradient(
      begin: Alignment(-1.0, 1.0),
      end: Alignment(1.0, -1.0),
      colors: <Color>[
        Colors.grey,
        Colors.grey,
      ],
    ),
    // color: buttonColor,
  ),
  width: 90.0,
  height: 90.0,
  child: const SpinKitChasingDots(
    color: Colors.white,
    size: 40.0,
  ),
);

String getFormattedDate(String date) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateTime dateTime = dateFormat.parse(date);
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');
  final String formatted = formatter.format(dateTime);
  return formatted;
}

Widget commanScreen({required Scaffold scaffold, required bool isLoading}) {
  return KeyboardDismisser(
      gestures: const [GestureType.onTap, GestureType.onPanUpdateDownDirection],
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: spinKit,
        child: scaffold,
      ));
}

class drawerWidgets extends StatefulWidget {
  final BuildContext context;

  const drawerWidgets(this.context, {Key? key}) : super(key: key);

  @override
  State<drawerWidgets> createState() => _drawerWidgetsState();
}

class _drawerWidgetsState extends State<drawerWidgets> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return drawerWidgets1(context);
  }

  Widget drawerWidgets1(context) {
    TextStyle textStyle = TextStyle(
      color: Colors.black,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: 2.h,
    );
    double widthDrawer = MediaQuery.of(context).size.width * 0.75;
    return isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : SizedBox(
      width: widthDrawer,
      child: Drawer(
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: Colors.white),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    if (userData != null) {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ));
                    }
                  },
                  child: userData == null
                      ? Container(
                    height: 120.0,
                    // color: Colors.black,
                    margin: EdgeInsets.only(top: 6.h, ),
                    child: Image.asset("assets/new_icon.png",height: 120.0,width: 120.0),
                  )
                      : (userData?.data?.username?.isEmpty ?? true)
                      ? Container(
                    margin: EdgeInsets.only(top: 6.h),
                    child: Image.asset("assets/new_icon.png",height: 120.0,width: 120.0),
                  )
                      :DrawerHeader(
                    child:Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment,
                          children: [
                            IconButton(onPressed: (){
                              Navigator.pop(context);
                            }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
                            SizedBox(width: 50.0,),
                            Center(child: Text("Profile",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // alignment: Alignment.bottomCenter,
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle
                              ),
                              // margin: EdgeInsets.only(right: 2.h),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Image.asset("assets/new_icon.png",height: 60.0,width: 60.0,),
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData?.data?.username.toString() ??
                                      '',
                                  style: const TextStyle(fontSize: 18.0,
                                      color: Colors.black,fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  userData?.data?.email.toString() ??
                                      '',
                                  style: const TextStyle(fontSize: 10.0,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5.0,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const  ProfileScreen()));
                                  },
                                  child: Container(
                                    height: 35.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Color(0xFFB41712),
                                    ), child: Center(child: Text("Edit Profile",style: TextStyle(
                                      fontSize: 12.0,color: Colors.white),),),
                                  ),
                                )
                              ],
                            )

                          ],
                        )
                      ],
                    ) ,
                  )
                // UserAccountsDrawerHeader(
                //   currentAccountPictureSize:
                //   Size(widthDrawer, 80),
                //   decoration: const BoxDecoration(
                //     color: Colors.transparent,
                //   ),
                //
                //   accountName: Container(
                //     margin: EdgeInsets.only(right: 2.h),
                //     width: widthDrawer,
                //     child: Row(
                //       mainAxisAlignment:
                //       MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           userData?.data?.username.toString() ??
                //               '',
                //           style: const TextStyle(
                //             color: Colors.black,
                //           ),
                //         ),
                //
                //set custom height
                // accountEmail: Container(
                //   margin: EdgeInsets.only(right: 2.h),
                //   width: widthDrawer,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment:
                //     MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         userData?.data?.email.toString() ??
                //             '',
                //         style: const TextStyle(
                //           color: Colors.black,
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: (){},
                //         child: Container(
                //           height: 30.0,
                //           width: 100.0,
                //           decoration: BoxDecoration(
                //             shape: BoxShape.rectangle,
                //             borderRadius: BorderRadius.circular(20.0),
                //             color: Color(0xFFB41712),
                //           ),
                //           child: Center(child: Text("Edit Profile",style: TextStyle(color: Colors.white),),),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // currentAccountPicture: Container(
                //   margin: EdgeInsets.only(right: 2.h),
                //   child: Center(
                //     child: Image.asset(Res.app_icon),
                //   ),
                // ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RestaurantsScreen(),
                      ));
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 17,
                    ),
                    const Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Restaurants",
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              userData == null
                  ? Container()
                  : const SizedBox(
                height: 20,
              ),
              userData == null
                  ? Container()
                  : GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ));
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 17,
                    ),
                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Basket",
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              userData == null
                  ? Container()
                  : const SizedBox(
                height: 20,
              ),
              userData == null
                  ? Container()
                  : GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const FavouritesScreen(),
                      ));
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 17,
                    ),
                    const Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Favourites",
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              userData == null
                  ? Container()
                  : const SizedBox(
                height: 20,
              ),
              userData == null
                  ? Container()
                  : GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const BookingDetails(),
                      ));
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 17,
                    ),
                    const Icon(
                      Icons.card_travel,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "My Bookings",
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              userData == null
                  ? Container()
                  : const SizedBox(
                height: 20,
              ),
              userData == null
                  ? Container()
                  : GestureDetector(
                onTap: () {
                  showDeleteDialog(context);
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 17,
                    ),
                    const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Delete Account",
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await SaveDataLocal.clearUserData();
                  userData = await SaveDataLocal.getDataFromLocal();
                  setState(() {});
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 17,
                    ),
                    const Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      userData == null ? 'Login' : "Logout",
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 17,
                  ),
                  Text(
                    'Help & Privacy',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 2.h,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  launchURL('https://www.chirz.co.uk/faq');
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 17,
                    ),
                    const Icon(
                      Icons.help_outline,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Help & FAQ",
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  launchURL('https://www.chirz.co.uk/privacy-policy');
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 17,
                    ),
                    const Icon(
                      Icons.privacy_tip_outlined,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Privacy Policy",
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  launchURL('https://www.chirz.co.uk/termsofuse');
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 17,
                    ),
                    const Icon(
                      Icons.privacy_tip_outlined,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Terms & Conditions",
                      style: textStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDeleteDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Are You Sure You Want to Delete your account?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 8.sp),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: const Text("No"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(20.w, 5.w),
                                  elevation: 0,
                                  primary: Colors.black)),
                          const SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () async {
                                await deleteAccount(context);
                              },
                              child: const Text("Yes"),
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  fixedSize: Size(20.w, 5.w),
                                  primary: const Color(0xFFB41712))),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  deleteAccount(context) {
    setState(() {
      isLoading = true;
    });
    checkInternet().then((internet) async {
      if (internet) {
        AuthProviders().deleteAccount().then((Response response) async {
          var jsonData = (json.decode(response.body));

          if (response.statusCode == 200 && jsonData['status'] == 1) {
            setState(() {
              isLoading = false;
            });
            Navigator.pop(context);
            await SaveDataLocal.clearUserData();
            userData = await SaveDataLocal.getDataFromLocal();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          } else {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(context, 'Error', jsonData['message'] ?? '');
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

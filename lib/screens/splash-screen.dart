// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:chirz/res.dart';
// import 'package:chirz/screens/explore.dart';
// import 'package:chirz/screens/video_screen.dart';
// import 'package:chirz/utils/const.dart';
// import 'package:chirz/utils/shared-preference.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
//
// class SplashScreenPage extends StatefulWidget {
//   const SplashScreenPage({Key? key}) : super(key: key);
//
//   @override
//   _SplashScreenPageState createState() => _SplashScreenPageState();
// }
//
// class _SplashScreenPageState extends State<SplashScreenPage> {
//   DateTime? selectedDay = DateTime.now();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     navigateToOtherScreen();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   navigateToOtherScreen() async {
//     startTimer();
//   }
//
//   Future<void> startTimer() async {
//     userData = await SaveDataLocal.getDataFromLocal();
//     navigateUser(); //It will redirect  after 3 seconds
//   }
//
//   navigateUser() async {
//     if (userData == null) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => VideoIntroScreen()));
//     } else {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => VideoIntroScreen()));
//     }
//   }
// }

// import 'package:chirz/screens/login.dart';
// import 'package:chirz/screens/registration.dart';
// import 'package:chirz/screens/restaurant.dart';
// import 'package:chirz/utils/const.dart';
// import 'package:chirz/utils/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/src/size_extension.dart';
//

import 'dart:async';

import 'package:chirz/screens/homescreen.dart';
import 'package:chirz/screens/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const RestaurantsScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity.h,
      width: double.infinity.w,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/Launch Screen.png"),
            fit: BoxFit.cover),
      ),
    );
  }
}

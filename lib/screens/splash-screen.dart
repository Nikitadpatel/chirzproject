

import 'dart:async';

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
            image: AssetImage("assets/images/chirz1.png"),
            fit: BoxFit.cover),
      ),
    );
  }
}

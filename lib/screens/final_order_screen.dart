
import 'package:chirz/res.dart';
import 'package:chirz/screens/explore.dart';
import 'package:chirz/screens/restaurant.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderSuccessFullyScreen extends StatefulWidget {
  const OrderSuccessFullyScreen({Key? key}) : super(key: key);

  @override
  _OrderSuccessFullyScreenState createState() =>
      _OrderSuccessFullyScreenState();
}

class _OrderSuccessFullyScreenState extends State<OrderSuccessFullyScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 30.h,
                  width: 30.h,
                  child: Image.asset(
                    Res.order_successfully,
                    fit: BoxFit.contain,
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.h),
                child: Text(
                  'Your Booking Confirmed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                child: Text(
                  'Thanks so much for your order! Thank you for being a valued customer.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                  child: buttonWidget(
                    callback: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>const ExplorerScreen(),
                            fullscreenDialog: true,
                          ),
                          (route) => false);
                    },
                    text: 'Back To Home',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>const RestaurantsScreen(),
          fullscreenDialog: true,
        ),
        (route) => false);

    // await showDialog or Show add banners or whatever
    // then
    return true; // return true if the route to be popped
  }
}

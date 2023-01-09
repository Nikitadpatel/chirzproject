import 'dart:convert';

import 'package:chirz/Model/cart_list_model.dart';
import 'package:chirz/Model/user_model.dart';
import 'package:chirz/providers/cart-provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

const String baseUrl = 'https://portal.chirz.co.uk/admin/api';

Map<String, String> headers = {
  'Authorization': 'hXuRUGsEGuhGf6KG',
};


void launchURL(_url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}

class CartCounterNotifier extends ChangeNotifier with DiagnosticableTreeMixin {
  int _value = 0;

  int get value => _value;

  CartCounterNotifier() {
    update();
  }

  // You can send send parameters to update method. No need in my case.
  //  Example:  void update(int newvalue) async { ...
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', _value));
  }

  void update() async {
    if (userData != null) {
      CartProviders().cartListAPi().then((value) {
        CartListModel cartListModel =
            CartListModel.fromJson(json.decode(value.body));
        if (cartListModel.status == 1) {
          {
            _value = cartListModel.data?.length ?? 0;
            notifyListeners();
          }
        }
      });
    }
  }
}

updateCartItems(context) {
  Provider.of<CartCounterNotifier>(context, listen: false).update();
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

String getDayOfMonthSuffix(int dayNum) {
  if (!(dayNum >= 1 && dayNum <= 31)) {
    throw Exception('Invalid day of month');
  }

  if (dayNum >= 11 && dayNum <= 13) {
    return 'th';
  }

  switch (dayNum % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

String date(tm) {
  String month = '';
  switch (tm) {
    case 1:
      month = "January";
      break;
    case 2:
      month = "February";
      break;
    case 3:
      month = "March";
      break;
    case 4:
      month = "April";
      break;
    case 5:
      month = "May";
      break;
    case 6:
      month = "June";
      break;
    case 7:
      month = "July";
      break;
    case 8:
      month = "August";
      break;
    case 9:
      month = "September";
      break;
    case 10:
      month = "October";
      break;
    case 11:
      month = "November";
      break;
    case 12:
      month = "December";
      break;
  }
  return month;
}

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

Future<bool> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = false;
    return false;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      serviceEnabled = false;
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    serviceEnabled = false;
    return false;
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return serviceEnabled;
}

String fontFamily = 'Lato';
UserModel? userData;
const Color whiteColor = Colors.white;
const Color blueColor = Colors.blueAccent;
const Color backGroundColor = Color(0xFFAC262C);
const Color primaryBlack = Colors.black;


import 'dart:io';
import 'package:chirz/Model/user_model.dart';
import 'package:chirz/utils/CustomException.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as https;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class RestaurantProviders {
  https.Client httpClient = https.Client();

  Future<https.Response> getRestaurantLocationWise({String? body}) async {
    Map bodyData = {
      'action': 'search_rest_location',
      'location': body,
    };
    const url = '$baseUrl/?action=search_rest_location';
    var responseJson;
    final response = await httpClient
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .timeout(const Duration(seconds: 5));
      return position;
    } catch (e) {
      return null;
    }
  }

  Future<https.Response> getNearestRestaurant() async {
    bool serviceEnabled = await determinePosition();
    Map bodyData;
    if (serviceEnabled) {
      // print(serviceEnabled);
      Position? position = await getLocation();
      print("1234");
      print(( position?.latitude));
      print(position?.longitude.toString(),);
      bodyData = {
        'action': 'get_popular_restaurant',
        'latitude': (position?.latitude == null)
            ? '51.5072'
            : position?.latitude.toString(),
        'longitude': (position?.longitude == null)
            ? '0.1276'
            : position?.longitude.toString(),
      };
    } else {
      bodyData = {
        'action': 'get_popular_restaurant',
        'latitude': '51.5072',
        'longitude': '0.1276',
      };
    }

    const url = '$baseUrl/?action=get_popular_restaurant';
    var responseJson;
    final response = await httpClient
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );

    responseJson = responses(response);
    return responseJson;
  }

  Future<https.Response> getPopularRestaurant() async {
    Map bodyData;

    bodyData = {
      'action': 'get_popular_restaurant',
    };

    const url = '$baseUrl/?action=get_popular_restaurant';
    var responseJson;
    final response = await httpClient
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<https.Response> getNewRestaurant() async {
    Map bodyData;
    bodyData = {
      'action': 'get_new_restaurant',
    };

    const url = '$baseUrl/?action=get_new_restaurant';
    var responseJson;
    final response = await httpClient
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<https.Response> getLocationsForRestaurants() async {
    const url = '$baseUrl/?action=get_location';
    var responseJson;

    final response =
        await httpClient.post(Uri.parse(url), headers: headers).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);

    return responseJson;
  }
}

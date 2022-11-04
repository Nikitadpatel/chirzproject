import 'dart:io';
import 'package:chirz/Model/user_model.dart';
import 'package:chirz/utils/CustomException.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as https;

class OrdersProviders {
  https.Client httpClient = https.Client();

  Future<https.Response> placeOrder(body) async {
    const url = '$baseUrl/?action=place_order';
    var responseJson;

    final response = await httpClient
        .post(Uri.parse(url), headers: headers, body: body)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);

    return responseJson;
  }

  Future<https.Response> orderBookingsList() async {
    const url = '$baseUrl/?action=order_booking';
    var responseJson;

    final response =
        await httpClient.post(Uri.parse(url), headers: headers, body: {
      'user_id': userData?.data?.uId ?? '',
    }).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);

    return responseJson;
  }
  Future<https.Response> orderDetailsList(orderId) async {
    const url = '$baseUrl/?action=booking_summary';
    var responseJson;

    final response =
        await httpClient.post(Uri.parse(url), headers: headers, body: {
      'user_id': userData?.data?.uId ?? '',
      'order_id':orderId,
    }).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);

    return responseJson;
  }
}

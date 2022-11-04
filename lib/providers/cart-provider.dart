import 'dart:io';

import 'package:chirz/Model/user_model.dart';
import 'package:chirz/utils/CustomException.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/response.dart';
import 'package:http/http.dart' as https;

class CartProviders {
  https.Client httpClient = https.Client();

  Future<https.Response> addToCartAPi(bodyData) async {
    const url = '$baseUrl/?action=add_cart';
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

  Future<https.Response> clearCartAPi() async {
    const url = '$baseUrl/?action=clear_cart';
    var responseJson;

    final response = await httpClient
        .post(Uri.parse(url),
            body: {'user_id': userData?.data?.uId ?? ''}, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);

    return responseJson;
  }Future<https.Response> checkoutAPi() async {
    const url = '$baseUrl/?action=checkout_list';
    var responseJson;

    final response = await httpClient
        .post(Uri.parse(url),
            body: {'user_id': userData?.data?.uId ?? ''}, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);

    return responseJson;
  }

  Future<https.Response> cartListAPi() async {
    const url = '$baseUrl/?action=cart_list';
    var responseJson;

    final response = await httpClient
        .post(Uri.parse(url),
            body: {
              'action': 'cart_list',
              'user_id': userData?.data?.uId ?? '',
            },
            headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);

    return responseJson;
  }
}

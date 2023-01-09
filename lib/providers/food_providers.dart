import 'dart:developer';
import 'dart:io';

import 'package:chirz/Model/user_model.dart';
import 'package:chirz/utils/CustomException.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/response.dart';
import 'package:http/http.dart' as https;

class FoodItemsProviders {
  https.Client httpClient = https.Client();

  Future<https.Response> foodListingAPi(bodyData) async {
    const url = '$baseUrl/?action=wine_pairing';
    var responseJson;
    print('object' + headers.toString());

    final response = await httpClient
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );

    return response;
  }

  Future<https.Response> wineListingAPi(bodyData) async {
    const url = '$baseUrl/?action=food_base_wine';
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

  Future<https.Response> itemDetailsAPi(bodyData) async {
    const url = '$baseUrl/?action=item_detail';
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

  Future<https.Response> getFavouritesWines(body) async {
    const url = '$baseUrl/?action=favourite_list';
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

  Future<https.Response> addFavouritesWines(body) async {
    const url = '$baseUrl/?action=add_favourite_item';
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

  Future<https.Response> addRating(body) async {
    const url = '$baseUrl/?action=add_rating';
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

  Future<https.Response> getRatings(body) async {
    const url = '$baseUrl/?action=rating';
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

  Future<https.Response> getWinesOrCockTails(isCocktail, restaurantId) async {
    const url = baseUrl;
    var responseJson;

    final response =
        await httpClient.post(Uri.parse(url), headers: headers, body: {
      'is_cocktail': isCocktail ? '1' : '0',
      'restaurant_id': restaurantId,
      'action': 'get_wines_cocktails',
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

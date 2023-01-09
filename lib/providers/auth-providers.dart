import 'dart:io';

import 'package:chirz/Model/user_model.dart';
import 'package:chirz/utils/CustomException.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/response.dart';
import 'package:http/http.dart' as https;

class AuthProviders {
  https.Client httpClient = https.Client();

  Future<https.Response> registrationApi(Map<String, String> bodyData) async {
    const url = '$baseUrl/?action=standard_registration';
    var responseJson;
    try {
      final imageUploadRequest = https.MultipartRequest('POST', Uri.parse(url));

      imageUploadRequest.headers.addAll(headers);

      if (bodyData['profile_image']?.isNotEmpty ?? false) {
        final file = await https.MultipartFile.fromPath(
            'profile_image', bodyData['profile_image'] ?? '');
        imageUploadRequest.files.add(file);
      }
      imageUploadRequest.fields.addAll(bodyData);

      final streamResponse = await imageUploadRequest.send();
      responseJson = responses(await https.Response.fromStream(streamResponse));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<https.Response> loginApi(bodyData) async {
    const url = '$baseUrl/?action=login';
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

  Future<https.Response> getProfileDetails() async {
    const url = '$baseUrl/?action=view_profile';
    var responseJson;

    final response = await httpClient
        .post(Uri.parse(url),
            body: {
              'action': 'view_profile',
              'user_id': userData?.data?.uId ?? '',
            },
            headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    print(response.body);
    responseJson = responses(response);

    return responseJson;
  }

  Future<https.Response> updateDetails(email, phoneNumber) async {
    const url = '$baseUrl/?action=edit_profile';
    var responseJson;
    Map map = {
      'action': 'edit_profile',
      'user_id': userData?.data?.uId ?? '',
      'username': userData?.data?.username ?? '',
      'email': email ?? '',
      'phone_number': phoneNumber ?? '',
    };
    final response = await httpClient
        .post(Uri.parse(url), body: map, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);

    return responseJson;
  }
  Future<https.Response> getDetails() async {
    const url = '$baseUrl/?action=get_setting_detail';
    var responseJson;
    Map map = {
      'action': 'get_setting_detail',
    };
    final response = await httpClient
        .post(Uri.parse(url), body: map, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);

    return responseJson;
  }
  Future<https.Response> deleteAccount() async {
    const url = '$baseUrl/?action=delete_acount';
    var responseJson;
    Map map = {
      'action': 'delete_acount',
      'user_id': userData?.data?.uId ?? '',
    };
    final response = await httpClient
        .post(Uri.parse(url), body: map, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);

    return responseJson;
  }
  Future<https.Response> review(rid,device) async {
    const url = '$baseUrl/?action=widget_restaurant';
    var responseJson;
    final response = await httpClient
        .post(Uri.parse(url),
        body: {
          'action': 'widget_restaurant',
          'r_id': rid ?? "" ,
          'clicks':"1",
          'device_id' : device ?? "" ,
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
  Future<https.Response> reviewwine(rid,device,wid) async {
    const url = '$baseUrl/?action=widget_wine';
    var responseJson;
    final response = await httpClient
        .post(Uri.parse(url),
        body: {
          'action': 'widget_wine',
          'r_id':rid ,
          'clicks':"1",
          'device_id': device,
          'w_id': wid,
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
  Future<https.Response> reviewcocktail(rid,device,cid) async {
    const url = '$baseUrl/?action=widget_cocktail';
    var responseJson;

    final response = await httpClient
        .post(Uri.parse(url),
        body: {
          'action': 'widget_cocktail',
          'r_id':rid ,
          'clicks':"1",
          'device_id': device,
          'c_id': cid,
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

  Future<https.Response> forgetapi(body) async {
    const url = '$baseUrl/?action=forget_password';
    var responseJson;

    final response = await httpClient
        .post(Uri.parse(url),
        body: body,
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

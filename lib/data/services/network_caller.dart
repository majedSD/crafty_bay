import 'dart:convert';
import 'dart:developer';

import 'package:crafty_bay/data/models/response_data.dart';
import 'package:http/http.dart';

class NetworkCaller {
  static Future<ResponseData> getRequest(String url, {String? token}) async {
    log(url);
    log(token.toString());
    final response = await get(Uri.parse(url), headers: {
      'token': token.toString(),
      'Content-Type': 'application/json',
    });
    log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 200) {
      final decodeResponse = jsonDecode(response.body);
      if (decodeResponse["msg"] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodeResponse,
          errorMessage: 'Something went wrong!',
        );
      }
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }

  static Future<ResponseData> postRequest(String url,
      {Map<String, dynamic>? body, String? token}) async {
    log(url);
    log(body.toString());
    log('token check');
    log(token.toString());
    final response = await post(Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'token': token.toString(),
          'Content-type': 'application/json'
        });
    log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 200) {
      final decodeResponse = jsonDecode(response.body);
      if (decodeResponse["msg"] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodeResponse,
        );
      }
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }
}
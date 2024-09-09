import 'dart:convert';
import 'package:crafty_bay/data/model/response_data.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:http/http.dart';

class NetworkCaller {
  Future<ResponseData> getRequest(String url, {String? token}) async {
    final Response response = await get(Uri.parse(url), headers: {
      'token': token.toString(),
      'Content-type': 'application/json'
    });
    if (response.statusCode == 200) {
      dynamic decodeResponse = jsonDecode(response.body);
      if (decodeResponse['msg'] == 'success') {
        return ResponseData(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodeResponse,
            errorMessage: '');
      } else {
        return ResponseData(
            statusCode: response.statusCode,
            isSuccess: false,
            responseData: decodeResponse,
            errorMessage: decodeResponse['data'] ?? 'Something went wrong');
      }
    }
    else if (response.statusCode ==401) {
      AuthController.backToLogin();
        return ResponseData(
            statusCode: response.statusCode,
            isSuccess: false,
            responseData:'',
            errorMessage: 'Token is not work Properly');
      }
    else {
      return ResponseData(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: '',
          errorMessage: 'Api request is not successful');
    }
  }

  Future<ResponseData> postRequest(String url,
      {String? token, Map<String, dynamic>? body}) async {
    final Response response = await post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        'token': token ?? '',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      dynamic decodedResponse = jsonDecode(response.body);
      if (decodedResponse['msg'] == 'success') {
        return ResponseData(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodedResponse,
          errorMessage: '',
        );
      } else {
        return ResponseData(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: decodedResponse,
          errorMessage: decodedResponse['data'] ?? 'Something went wrong',
        );
      }
    }
    else if (response.statusCode ==401) {
      AuthController.backToLogin();
      return ResponseData(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData:'',
          errorMessage: 'Token is not work Properly');
    }
    else {
      return ResponseData(
        statusCode: response.statusCode,
        isSuccess: false,
        responseData: '',
        errorMessage: 'API request was not successful',
      );
    }
  }
}

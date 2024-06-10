import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/utilities/const.dart';


class VerifyEmailApi {
  final Dio client;

  VerifyEmailApi({required this.client});

  Future<bool> verifyRememberApi({Map<String, dynamic>? data}) async {
    Response response;
    try {
      response = await client.post(
        verifyEmailUrl,
        data: data,
      );
     // log('user change: ${response.data.toString()}');
      return true;
    } on DioError catch (e) {
      //log('error code: ${e.response.statusCode}');
      //log('error is: ${e.response.data}');
      return false;
    }
  }
}

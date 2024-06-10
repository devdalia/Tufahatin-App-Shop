
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/utilities/const.dart';

class ResendVerificationCodeApi {
  final Dio client;

  ResendVerificationCodeApi({required this.client});

  Future<bool> resendVerificationCodeApi({Map<String, dynamic> ?data}) async {
    Response response;
    try {
      print(data);
      response = await client.post(
     resendVerificationCodeUrl,
        data: data,
      );
   //  log('verificationCodeApi: ${response.data.toString()}');
      return true;
    } on DioError catch (e) {
     // log('error code: ${e.response.statusCode}');
      //log('error is: ${e.response.data}');
      return false;
    }
  }
}

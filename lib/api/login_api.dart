import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/model/login_model.dart';
import 'package:ecommerce/utilities/const.dart';

class LoginApi {
  final Dio client;

  LoginApi({required this.client});

  Future<LoginModel> login({Map<String, dynamic> ?data}) async {
    Response response;
    try {
      response = await client.post(
        loginUrl,
        data: data,
      );
      log('user: ${response.data.toString()}');
      return LoginModel.fromJson(response.data);

    } on DioError catch (e) {
     // log('error is: ${e.response.data.toString()}');
    //  log('error is: ${e.error}');
      return e.error;

    }
  }
}

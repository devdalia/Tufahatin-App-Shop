
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/model/login_model.dart';
import 'package:ecommerce/utilities/const.dart';


class ChangePasswordApi {
  final Dio client;

  ChangePasswordApi({required this.client});

  Future<LoginModel> changePasswordApi({Map<String, dynamic> ?data}) async {
    Response response;
    log('user: ${data}');
    try {
      response = await client.post(
        changePasswordUrl,
          data: data
     );
     log('changepassword: ${response.data.toString()}');
      return LoginModel.fromJson(response.data);

    } on DioError catch (e) {
     // log('error code: ${e.response.statusCode}');
     // log('error is: ${e.response.data}');
      return e.error;
    }
  }
}


import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/model/register_model.dart';
import 'package:ecommerce/utilities/const.dart';

class RegisterApi {
  final Dio client;

  RegisterApi({required this.client});

  Future<RegisterModel> registerApi({Map<String, dynamic>? data}) async {
    Response response;
    try {
      response = await client.post(
        registerUrl,
        data: data,
      );
   //   log('user: ${response.data.toString()}');
      return RegisterModel.fromJson(response.data);
    } on DioError catch (e) {
     // log('error code: ${e.response.statusCode}');
    //  log('error is: ${e.response.data}');
      return RegisterModel(
        status: false,
        message:  e.response!.data['errors']['email'] != null
            ? e.response!.data['errors']['email'][0]
            : '',
      );
    }
  }
}
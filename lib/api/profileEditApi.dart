import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/utilities/const.dart';

class ProfileEditApi {
  final Dio client;

  ProfileEditApi({required this.client});

  Future<bool> editprofile({FormData ?data}) async {
    try {
      var res = await client.post(changeProfile, data: data);
  //    log('res=>${res.data}');
      return true;
    } on DioError catch (e) {
   //   print("statuscode:${e.response.statusCode}");
     // print("data22:${e.response.data}");
      return false;
    }
  }
}

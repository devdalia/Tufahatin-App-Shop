import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/model/profile_model.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';

class ProfileApi {
  final Dio client;

  ProfileApi({required this.client});
  Future<ProfileModel> getProfileData() async {
    String token = await getPrefString(token_pref);
    String id = await getPrefString(id_pref);
    client.options.headers = {"Authorization": "Bearer $token"};
    log('$token');
    Response response;
    try {
      response = await client.post(profile,data: {
        "user_id":"$id",
        "token": "$token"
      });
      //log('ProfileApi2 => ${response.data.toString()}');
      ProfileModel profileModel = ProfileModel.fromJson(response.data);
      return profileModel;

    } on DioError catch (e) {
     // log('satuscode:${e.response.statusCode}');
//      log('data:${e.response.data}');

      return e.error;
    }

  }
}

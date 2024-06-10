import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/utilities/const.dart';
class ReviewAddApi{
  final Dio client;

  ReviewAddApi({required this.client});
  Future<bool> ReviewData({Map<String,dynamic> ?data}) async {
    client.options.queryParameters ={
      'consumer_key': 'ck_23129b745a10c8a46a75c186596104351566cb78',
      'consumer_secret': 'cs_d624488a855f1a891bea08e9b9d963a89cc51dfe',
    };
 //   print("queryParametersadd=>"+ client.options.queryParameters.toString());

    Response response;
    try {
      response = await client.post(review, data: data);

    //  log('ReviewApis => ${response.data.toString()}');
      return true;
    } on DioError catch (e) {
    //  print("statuscode11:${e.response.statusCode}");
     // print("data22:${e.response.data}");
      return false;
    }
  }
}
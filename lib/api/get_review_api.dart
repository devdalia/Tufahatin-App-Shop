import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/model/review_model.dart';
import 'package:ecommerce/utilities/const.dart';

class AllReviewApi {
  final Dio client;

  AllReviewApi({ required this.client});

  Future<ReviewModel> getReviewData(int id) async {
    client.options.queryParameters = {
      'consumer_key': 'ck_23129b745a10c8a46a75c186596104351566cb78',
      'consumer_secret': 'cs_d624488a855f1a891bea08e9b9d963a89cc51dfe',
      "product": "$id",
    };
    print(
        "queryParametersgetget=>" + client.options.queryParameters.toString());
    Response response;
    try {
      response = await client.get(review);
      log('ReviewApidata => ${response.data}');
      ReviewModel reviewModel = ReviewModel.fromJson(response.data);
      log('Review => ${reviewModel.review}');
      return reviewModel;
    } on DioError catch (e) {
     // print("statuscode13:${e.response.statusCode}");
      //print("data33:${e.response.data}");
      return e.error;
    }
  }
}

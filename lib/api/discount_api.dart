
import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:ecommerce/model/category_products_model.dart';
import 'package:ecommerce/utilities/const.dart';

class DiscountCodeApi {
   final Dio client;

  DiscountCodeApi({ required this.client});

  Future<CategoryProductModel> discountCodeApi() async {

    client.options.queryParameters ={
      'consumer_key': 'ck_23129b745a10c8a46a75c186596104351566cb78',
      'consumer_secret': 'cs_d624488a855f1a891bea08e9b9d963a89cc51dfe',
      "on_sale":"true"
    };
   // print("queryParameters=>"+ client.options.queryParameters.toString());
    Response response;

    try {

      response = await client.get(showProductsUrl);
     // log('disssssss: ${response.data}');
      return CategoryProductModel.fromJson(response.data);

    } on DioError catch (e) {
     // log('error code: ${e.response.statusCode}');
      //log('error is: ${e.response.data}');
      return e.error;
    }
  }
}

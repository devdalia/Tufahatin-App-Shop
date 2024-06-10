import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/model/all_search_model.dart';
import 'package:ecommerce/utilities/const.dart';

class SearchForAllApi{

  final Dio client;

  SearchForAllApi({required this.client});

  Future<AllSearchModel> getProductsSearch({String? filter}) async {
if (filter !=null){
  client.options.queryParameters ={
    'consumer_key': 'ck_23129b745a10c8a46a75c186596104351566cb78',
    'consumer_secret': 'cs_d624488a855f1a891bea08e9b9d963a89cc51dfe',
    "search": "${filter}"
  };
}

  //  print("queryParameters=>"+ client.options.queryParameters.toString());

    Response response;
    try {
      response = await client.get(searchProducts);

      AllSearchModel model =
      AllSearchModel.fromJson(response.data);
    //  log('responseList' + response.data.toString());
      return model;
    } on DioError catch (e) {
      print('e: $e');
      return e.error;
    }
  }
}
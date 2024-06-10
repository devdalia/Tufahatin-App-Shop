

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/model/create_order_model.dart';
import 'package:ecommerce/utilities/const.dart';

class CreateOrderApi {
  final Dio client;

  CreateOrderApi({ required this.client});

  Future<CreateOrderModel> creataOrderApi({Map<String,dynamic>? data}) async {

    print("dataa:$data");
    client.options.queryParameters ={
      'consumer_key': 'ck_23129b745a10c8a46a75c186596104351566cb78',
      'consumer_secret': 'cs_d624488a855f1a891bea08e9b9d963a89cc51dfe',
    };
    print("queryParametersgetget3532=>"+ client.options.queryParameters.toString());
    try {
      var res = await client.post(order, data: data);
    //  log('res create order=>${res.data}');
      CreateOrderModel creataModel = CreateOrderModel.fromJson(res.data);
      log('Review => ${creataModel}');
      return creataModel;
    } on DioError catch (e) {
     // print("statuscode order:${e.response.statusCode}");
      //print("data order:${e.response.data}");
      return e.error;
    }
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/model/payment_model.dart';
import 'package:ecommerce/utilities/const.dart';

class GetPaymentApi {
  final Dio client;

  GetPaymentApi({ required this.client});

  Future<PaymentModelList> getPaymentApi() async {
    print("welcome");
    client.options.queryParameters = {
      'consumer_key': 'ck_23129b745a10c8a46a75c186596104351566cb78',
      'consumer_secret': 'cs_d624488a855f1a891bea08e9b9d963a89cc51dfe',

    };
 //   print("queryParametersgetpayment=>" +
     //   client.options.queryParameters.toString());
    try {
      var res = await client.get(payment);
      //log('res get payment=>${res.data}');
      PaymentModelList getpaymentModel = PaymentModelList.fromJson(res.data);
   //   log('payment => ${getpaymentModel}');
      return getpaymentModel;
    } on DioError catch (e) {
      //print("statuscode payment:${e.response.statusCode}");
      //print("data payment:${e.response.data}");
      return e.error;
    }
  }
}

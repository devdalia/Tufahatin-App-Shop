import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';
import 'package:ecommerce/model/get_totals_cart_model.dart';


class   GetTotalsApi{
  final Dio client;

  GetTotalsApi({ required this.client});
  Future<GetTotalsCartModel> getTotalsApi({Map<String,dynamic>? data}) async {


    Response response;
    try {
      String _cart_key = await getPrefString(cart_key);
      String request_cart_key = _cart_key.isNotEmpty ? '?cart_key=${_cart_key}' : '';
      String url = getproductstocart+'cocart/v1/totals'+request_cart_key;
    //  log('The Url Is get totals: ${url}');

      response = await Dio(). get(
        url,
        options: Options(
          contentType: 'application/json',
          headers: {"Accept": "application/json",
            // "Cookie":"wordpress_logged_in_3f8dc0a5403816b7cc65fa45824fc48e=daliaelsharif5%40gmail.com%7C1619855577%7C1KWMRoFfgoOiOZ2P1c3MJLhP0QIkWJYvYv5Hr2uxTQ7%7Cc1bb2b4fc763d7f71517ac81ceeaa276c5f62b4a1aa5f5bed56f71a48131b8f4;${cookie}; __cfduid=d56ad34b1b09ec55b17ae5272a85cd1121619614220"
          },
        ),
      );

     // log('get totals cart=> ${response.data.toString()}');
      GetTotalsCartModel getTotalsCartModel=GetTotalsCartModel.fromJson(response.data);

      return getTotalsCartModel;
    } on DioError catch (e) {
      //print("statuscode get cart:${e.response.statusCode}");
     // print("data22 get cart:${e.response.data}");
      return e.error;
    }
  }
}
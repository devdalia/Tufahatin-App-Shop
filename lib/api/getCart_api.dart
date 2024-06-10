import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/model/add_products_to_cart_model.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';


class GetCartApi{

 Future<List<AddProductsToCartModel>> getCartApi() async {
   int i=0;
List<AddProductsToCartModel>list=[];

   String cookie =await getPrefString(cookie_pref);
  // String _cart_key = await getPrefString(cart_key);
   String _cart_key = await getPrefString(cart_key);
   String request_cart_key = _cart_key.isNotEmpty ? '?cart_key=${_cart_key}' : '';
   String url = getproductstocart+'cocart/v1/get-cart'+request_cart_key+'&thumb=true';
   //log('The Url Is get: ${url}');

    Response response;

   response = await Dio(). get(
     url,
     options: Options(
       contentType: 'application/json',
       headers: {"Accept": "application/json",
         // "Cookie":"wordpress_logged_in_3f8dc0a5403816b7cc65fa45824fc48e=daliaelsharif5%40gmail.com%7C1619855577%7C1KWMRoFfgoOiOZ2P1c3MJLhP0QIkWJYvYv5Hr2uxTQ7%7Cc1bb2b4fc763d7f71517ac81ceeaa276c5f62b4a1aa5f5bed56f71a48131b8f4;${cookie}; __cfduid=d56ad34b1b09ec55b17ae5272a85cd1121619614220"
       },
     ),
   );

    try {
   //   log('get cart: ${response.data.toString()}');
      response.data.forEach((key, value) {
     //   print('valuess');
       // print("get cart${value}");
        list.add(AddProductsToCartModel.fromJson(value));
      });
    //  AddProductsToCartModel  addtoapi  = AddProductsToCartModel.fromJson(response.data);
    //  log('get to api: ${list.toString()}');
      return list;
    } on DioError catch (e) {
     // log('error code geee: ${e.response.statusCode}');
     // log('error is geet: ${e.response.statusMessage}');
      return e.error;

    }
  }
}
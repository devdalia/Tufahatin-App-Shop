import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/model/add_products_to_cart_model.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';


class UpdataCartApi{

 Future<bool>  updataCartApi({Map? data}) async {
   String _cart_key = await getPrefString(cart_key);
   String request_cart_key = _cart_key.isNotEmpty ? '?cart_key=${_cart_key}' : '';
   String url = getproductstocart+'cocart/v1/item'+request_cart_key;
  // log('Url_cart : ${url}');

    Response response;

   response = await Dio(). post(
     url,
     data:data,
     options: Options(
       contentType: 'application/json',
       headers: {"Accept": "application/json",
         "Cookie":"woocommerce_cart_hash=5bd67b308e75b50254a15f3f24ffdbb5; woocommerce_items_in_cart=1; wp-wpml_current_admin_language_d41d8cd98f00b204e9800998ecf8427e=ar; wp_cocart_session_db6cdf350ab4795d6da29b38eae02da0=a51e715e7e04531f0cde8393679ed674%7C%7C1620728824%7C%7C1620642424%7C%7C2fadcd7b570c29c35e46fa3cfcc78ee6; __cfduid=dd43fd44b574a5c1285320853a6bd0ca01619687479"
       },
     ),
   );

    try {
    //  log('get cart updata: ${response.data.toString()}');
    //  AddProductsToCartModel  addtoapi  = AddProductsToCartModel.fromJson(response.data);
     // log('get to api updata: ${addtoapi}');
      return true;
    } on DioError catch (e) {
    //  log('error code updata cart: ${e.response.data}');
     // log('error is geet updata cart: ${e.response.statusMessage}');
      return false;

    }
  }
}
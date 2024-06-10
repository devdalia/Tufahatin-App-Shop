import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/model/add_products_to_cart_model.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';

class AddProductCartApi {
  Future<AddProductsToCartModel> addProductCartApi({Map? data}) async {
    Response response;

    try {
      String _cart_key = await getPrefString(cart_key);
      String request_cart_key = _cart_key.isNotEmpty ? '?cart_key=${_cart_key}' : '';
      String url = addproductstocart+'cocart/v1/add-item'+request_cart_key;
   //   log('The Url Is add: ${url}');

      response =  await Dio().post(
          url,
          data:data,
        options: Options(
          contentType: 'application/json',
          headers: {"Accept": "application/json"},
        ),
      );
   //   log('console is here');

      String cart_api_id = response.headers['X-CoCart-API'] != null ? response.headers['X-CoCart-API']![0] : '';


      if(cart_api_id != '' && _cart_key == '') {
        await savePrefString(cart_key, cart_api_id);
      }

     // log('cart response header: ${response.headers}');
    //  log('cart  tto api: $cart_api_id');
      return AddProductsToCartModel.fromJson(response.data);
    } on DioError catch (e) {
      //log('error code cart12: ${e.response.statusMessage}');
     // log('error is cartss: ${e.response.data}');

      return e.error;
    }
  }
}

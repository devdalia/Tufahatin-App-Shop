import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/model/categories_model.dart';

class CategoriesApi {

  Dio client = Dio(
    BaseOptions(
        baseUrl: 'https://tufahatin.net/wp-json/wc/v3',
        contentType: 'application/json',
        queryParameters: {
          'consumer_key': 'ck_23129b745a10c8a46a75c186596104351566cb78',
          'consumer_secret': 'cs_d624488a855f1a891bea08e9b9d963a89cc51dfe',
        //  "per_page":"100"
        },
        headers: {
          "Accept": "*/*",
          "Authorization":
              "Basic Y2tfMjMxMjliNzQ1YTEwYzhhNDZhNzVjMTg2NTk2MTA0MzUxNTY2Y2I3ODpjc19kNjI0NDg4YTg1NWYxYTg5MWJlYTA4ZTliOWQ5NjNhODljYzUxZGZl",
          "Cookie":"wp-wpml_current_admin_language_d41d8cd98f00b204e9800998ecf8427e=ar; __cfduid=dd43fd44b574a5c1285320853a6bd0ca01619687479"
        }),
  );

  Future<ReceiveProductDetailsModel> categoriesApi() async {
    Response response;
    try {
      response = await client.get('/products/categories');
      print(response.data);
    //  log('category: ${response.data}');
      return ReceiveProductDetailsModel.fromJson(response.data);
    } on DioError catch (e) {
    //  log('error code: ${e.response.statusCode}');
   //   log('error is: ${e.response.data}');
      return e.error;
    }
  }
}

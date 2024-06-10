import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/model/location_model.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';

class LocationApi {
  final Dio client;

  LocationApi({required this.client});

  Future<LocationModel> getAllLocation({Map<String, dynamic> ?data}) async {
  // String cookie= await getPrefString(cookie_pref);
 //   client.options.headers = {'Authorization': 'Bearer ' + '${token}'};

    String id = await getPrefString(id_pref);

    client.options.headers = {
      'Authorization': 'Bearer ',
 //'Cookie':'wp-wpml_current_admin_language_d41d8cd98f00b204e9800998ecf8427e=ar; wp_cocart_session_db6cdf350ab4795d6da29b38eae02da0=2%7C%7C1620728824%7C%7C1620642424%7C%7C32af5a179c8a9f89e2c244f1df708e10; __cfduid=dd43fd44b574a5c1285320853a6bd0ca01619687479'
    };
    Response response;
    try {
      response = await client.get('/list_all_address?customer_id=${id}');

      log(' locationsss232 response: ${response.data}');
      LocationModel model=LocationModel.fromJson(response.data);
     // log(' locationsss get data: ${model.data}');
     // log(' locationsss get header model: ${response.headers}');
      //log(' locationsss get request model: ${response.request}');
      return model;

    } on DioError catch (e) {
     // log('error is get location: ${e.message}');
     // log('error is get location22: ${response.data}');
      return e.error;
    }
  }
}

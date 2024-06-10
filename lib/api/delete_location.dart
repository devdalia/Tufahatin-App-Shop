import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/utilities/const.dart';

class DeleteLocationApi {
  final Dio client;

  DeleteLocationApi(  this.client);

  Future<bool> deleteLocationApi({Map ?data}) async {
    Response response;

    response = await client.delete(
      deletelocation,
      data: data,
    );

    try {
      log('get location delete: ${response.data.toString()}');
      return true;
    } on DioError catch (e) {
      //log('error code delet location: ${e.response.data}');
     // log('error is geet delete location: ${e.response.statusMessage}');
      return false;
    }
  }
}

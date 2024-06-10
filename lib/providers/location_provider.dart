import 'package:ecommerce/api/delete_location.dart';
import 'package:ecommerce/helpers/internet_helper.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utilities/custom_dialog.dart';
import 'package:ecommerce/api/add_new_address_api.dart';
import 'package:ecommerce/api/location_api.dart';
import 'package:ecommerce/model/location_model.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';
import '../get_it.dart';

class LocationProvider with ChangeNotifier {
  GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController ?addressController = TextEditingController();

  String ?lat;
  String? log;
  String ?address;

  LocationModel ?_locationModel;

  LocationModel? get locationModel => _locationModel;

  bool loading = false;
  bool deleteloading = false;
  bool? error;
  List<LocationModel> list=[];
  void getLocations() async{

    loading = true;
    print('getLocations');
    notifyListeners();
    getIt<LocationApi>().getAllLocation().then((value) {
      if (value != null) {
        loading = false;
        error = false;
        notifyListeners();
        _locationModel = value;
        notifyListeners();
      } else {
        loading = false;
        error = true;
        notifyListeners();
      }
    });
  }

  void addNewAddress() async{
    String id = await getPrefString(id_pref);
    if (addressController!.text.isEmpty) {
      print('message ${addressController!.text}');
      errorDialog(
          message: "Please enter all data",
          context: scaffoldKey!.currentContext!);
    } else {
      loading = true;
      print('start add location');
      notifyListeners();
      getIt<AddNewAddressApi>().addAddress(data: {
        'customer_id': id,
        'full_address': addressController!.text,
        'location_latitude': '${lat}',
        'location_longtitude': '${log}',
        "type" : "Work"
      }).then((value) async {
        if (value != null) {
          loading = false;
          print('finish add location22');
          _locationModel=value;
        getLocations();
          notifyListeners();
         // Navigator.pop(scaffoldKey.currentContext);
          print('finish add location');
          notifyListeners();
        } else {
          errorDialog(
              message: ('The address was not added'),
              context: scaffoldKey!.currentContext!);
          loading = false;
          notifyListeners();
        }
      });
    }
  }

  void deletelocation(String id ) async {

    bool isinternet = await isInternet;
    if (isinternet) {
      deleteloading = true;
      print('start delete product to cart');

      getIt<DeleteLocationApi>().deleteLocationApi(
          data: {
            "address_id" : id,
          }).then((value) {
        if (value == true) {
          deleteloading = false;
          error=false;
          getLocations();
          notifyListeners();
            successfulDialog(
            message: 'successful delete Location',
            context: scaffoldKey!.currentContext!,
           // functionOk: () => Navigator.pop(scaffoldKey.currentContext),
          );
        } else {
          deleteloading = false;
          print('error');
          notifyListeners();
          errorDialog(
              message: 'There_no_internet_connection',
              context: scaffoldKey!.currentContext!);
        }
      });
    }
  }

}

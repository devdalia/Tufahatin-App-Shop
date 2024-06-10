import 'package:ecommerce/api/category_product_api.dart';

import 'package:ecommerce/api/category_product_api.dart';

import 'package:ecommerce/helpers/internet_helper.dart';
import 'package:ecommerce/model/category_products_model.dart';

import 'package:flutter/material.dart';

import '../get_it.dart';

class DetailsProductsProvider with ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  CategoryProductModel ?_categoryProductModel;

  CategoryProduct? _categoryProduct;

  CategoryProductModel? get categoryProductModel => _categoryProductModel;

  CategoryProduct? get categoryProduct => _categoryProduct;

  bool loading = false;
  bool getproductLoading = false;
  bool error = false;
  bool noInternet = false;

  void getProductsEstate(int id) async {
    getproductLoading = true;
    bool connectInternet = await isInternet;
    if (connectInternet) {
      print('start getProductsEstate');
    } else {
      getproductLoading = false;
      noInternet = true;
      notifyListeners();
    }
  }

  void getDatailsProducts(int id) async {
    loading = true;
    bool connectInternet = await isInternet;
    if (connectInternet) {
      print('start getProductsEstate');
      getIt<DetailsProductApi>().detailsProductApi(id).then((value) {
        if (value != null) {
          _categoryProduct = value;
          loading = false;
          error = false;
          noInternet = false;
          notifyListeners();
        } else {
          loading = false;
          noInternet = false;
          error = true;
          notifyListeners();
        }
      });
    } else {
      loading = false;
      noInternet = true;
      notifyListeners();
    }
  }
}

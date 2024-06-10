import 'package:ecommerce/api/get_totals_cart_api.dart';
import 'package:ecommerce/api/add_products_to_cart_api.dart';
import 'package:ecommerce/api/getCart_api.dart';
import 'package:ecommerce/api/updataCart_api.dart';
import 'package:ecommerce/api/delet_cart.dart';
import 'package:ecommerce/get_it.dart';
import 'package:ecommerce/helpers/internet_helper.dart';
import 'package:ecommerce/model/add_products_to_cart_model.dart';
import 'package:ecommerce/utilities/custom_dialog.dart';
import 'package:ecommerce/model/get_totals_cart_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddCartProvider extends ChangeNotifier {
  GlobalKey<ScaffoldState> addCart = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> getCartproduct = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> gettotal = GlobalKey<ScaffoldState>();

  List<AddProductsToCartModel> list = [];
  bool cartloading = false;
  bool deleteloading = false;
  bool totalsloading = false;
  bool updataloading = false;
  bool error = false;
  bool noInternet = false;

  AddProductsToCartModel ?_addProductsToCartModel;

  AddProductsToCartModel ?get addProductsToCartModel => _addProductsToCartModel;

  AddProductsToCartModel? _updataCartModel;

  AddProductsToCartModel? get updataCartModel => _updataCartModel;

  GetTotalsCartModel ?_getTotalsCartModel;

  GetTotalsCartModel ?get getTotalsCartModel => _getTotalsCartModel;
  int ?quantity;

  void getCart() async {
    cartloading = true;
    bool isinternet = await isInternet;
    if (isinternet) {
      print('start getting cart');
      getIt<GetCartApi>().getCartApi().then((value) {
        if (value != null) {
          error = false;
          noInternet = false;
          cartloading = false;
          notifyListeners();
          list = value;
          print('done getting cart');
        } else {
          error = true;
          noInternet = false;
          cartloading = false;
          notifyListeners();
        }
      });
    }
  }

  void AddCart(String idpro, int quan) async {
    bool isinternet = await isInternet;
    if (isinternet) {
      cartloading = true;
      print('start add product to cart');

      getIt<AddProductCartApi>().addProductCartApi(
          data: {"product_id": "$idpro", "quantity": quan}).then((value) {
        if (value != null) {
          cartloading = false;
          error = false;
          getCart();
          notifyListeners();
        } else {
          cartloading = false;
          print('error');
          notifyListeners();
      /*    errorDialog(
              message: 'There_no_internet_connection',
              context: addCart.currentContext);*/
        }
      });
    } else {}
  }

  void updataCart(String keycartss, int quan) async {
    bool isinternet = await isInternet;
    if (isinternet) {
      updataloading = true;
      print('start updata product to cart');

      getIt<UpdataCartApi>().updataCartApi(data: {
        "cart_item_key": "$keycartss",
        "quantity": quan
      }).then((value) {
        if (value == true) {
          updataloading = false;
          error = false;
          getTotals();
          notifyListeners();
        } else {
          updataloading = false;
          print('error');
          notifyListeners();
          errorDialog(
              message: 'There_no_internet_connection',
              context: addCart.currentContext!);
        }
      });
    } else {}
  }

  void deleteCart(String keycartss) async {
    bool isinternet = await isInternet;
    if (isinternet) {
      deleteloading = true;
      print('start delete product to cart');

      getIt<DeleteCartApi>().deleteCartApi(data: {
        "cart_item_key": "$keycartss",
      }).then((value) {
        if (value == true) {
          deleteloading = false;
          error = false;
          getCart();
          getTotals();
          notifyListeners();
        } else {
          deleteloading = false;
          print('error');
          notifyListeners();
          errorDialog(
              message: 'There_no_internet_connection',
              context: addCart.currentContext!);
        }
      });
    } else {}
  }

  void getTotals() async {
    bool isinternet = await isInternet;
    if (isinternet) {
      totalsloading = true;
      getIt<GetTotalsApi>().getTotalsApi().then((value) {
        if (value != null) {
          totalsloading = false;
          _getTotalsCartModel = value;
          notifyListeners();
        } else {
          totalsloading = false;
          print('error');
          notifyListeners();
        }
      });
    }
  }
}

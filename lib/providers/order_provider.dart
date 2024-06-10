
import 'package:ecommerce/api/Create_order_api.dart';
import 'package:ecommerce/api/get_payment_api.dart';
import 'package:ecommerce/api/update_order_api.dart';
import 'package:ecommerce/helpers/internet_helper.dart';
import 'package:ecommerce/model/add_products_to_cart_model.dart';
import 'package:ecommerce/model/create_order_model.dart';
import 'package:ecommerce/model/location_model.dart';
import 'package:ecommerce/model/payment_model.dart';
import 'package:ecommerce/model/update_order_model.dart';
import 'package:ecommerce/providers/add_cart_provider.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../get_it.dart';
import '../get_it.dart';
import '../model/create_order_model.dart';
import 'add_cart_provider.dart';

class CreateOrderProvider extends ChangeNotifier {
  GlobalKey<ScaffoldState> order = GlobalKey<ScaffoldState>();

  TextEditingController editcustomerNote = TextEditingController();
  TextEditingController editingPaymentMothod = TextEditingController();
  TextEditingController editingPaymentMothodTitle = TextEditingController();
  TextEditingController editingFirstName = TextEditingController();
  TextEditingController editinglistName = TextEditingController();
  TextEditingController editingaddress = TextEditingController();
  TextEditingController editingaddress2 = TextEditingController();
  TextEditingController editingcity = TextEditingController();
  TextEditingController editingpostcode = TextEditingController();
  TextEditingController editingcountry = TextEditingController();
  TextEditingController editingstate = TextEditingController();

  bool orderloading = false;
  bool paymentloading = false;
  bool updateloading = false;
  bool getupdateloading = false;
  bool error = false;
  bool noInternet = false;

  CreateOrderModel? _createOrderModel;

  CreateOrderModel ?get createOrderModel => _createOrderModel;

  PaymentModelList? _paymentModel;

  PaymentModelList? get paymentModel => _paymentModel;
  PaymentModel ?itemSelected;
  UpdateOrderModel? _updateOrderModel;

  UpdateOrderModel? get updateOrderModel => _updateOrderModel;

  Datass? userAddress;

  void creataOrder() async {
    String id = await getPrefString(id_pref);
    String ss = await getPrefString('cart');
    var cart = getIt<AddCartProvider>().getCart();
    List<AddProductsToCartModel>? listCart = <AddProductsToCartModel>[];

    //List<CategoryProduct> listCart = CartModel.fromJson(json.decode(ss)).productsDetails;
    CreateOrderModel model = CreateOrderModel();
    List<LineItems> list = [];
    List<MetaDataa> listloc = [];

    model.customerId = int.parse(id);
    //model.paymentMethod = (itemSelected.id.toString());
    //model.paymentMethodTitle = (itemSelected.description);
    for (var item in listCart) {
      list.add(LineItems(productId: item.productId, quantity: item.quantity));
    }
    //model.lineItems = list;


    /*for (var itemlocation in getIt<LocationProvider>().locationModel.data) {
      listloc.add(MetaDataa(key: 'order_latitude',
          value: itemlocation.locationLongtitude +
              ',' +
              itemlocation.locationLatitude));
    }*/
    model.metaData = [
      MetaDataa(
          key: 'order_latitude',
          value: userAddress!.locationLatitude
      ),
      MetaDataa(
          key: 'order_longtitude',
          value: userAddress!.locationLongtitude
      ),
    ];

    //  model.customerNote=(editcustomerNote.text);
    for(var item in getIt<AddCartProvider>().list){
      list.add(LineItems(productId: item.productId,quantity:item.quantity));
    }
  //  model.lineItems=list;
    print(model.toJson());

    bool isinternet = await isInternet;

    if (isinternet) {
      orderloading = true;
      getIt<CreateOrderApi>()
          .creataOrderApi(data: model.toJson())
          .then((value) {
        if (value != null) {
          orderloading = false;
          _createOrderModel = value;
          notifyListeners();
        } else {
          orderloading = false;
          print('error');
          notifyListeners();
        }
      });
    }
  }

  void getPayment() async {
    paymentloading = true;
    bool connectInternet = await isInternet;

    if (connectInternet) {
      print('start get payment');
      getIt<GetPaymentApi>().getPaymentApi().then((value) {
        if (value != null) {
          paymentloading = false;
          error = false;
          noInternet = false;
          _paymentModel = value;
          notifyListeners();
        } else {
          paymentloading = false;
          noInternet = false;
          error = true;
          notifyListeners();
        }
      });
    } else {
      paymentloading = false;
      noInternet = true;
      notifyListeners();
    }
  }

  void updateOrder(int ids) async {
    String id = await getPrefString(id_pref);
    String token = await getPrefString(token_pref);

    updateloading = true;
    bool connectInternet = await isInternet;

    if (connectInternet) {
      print('start update order');
      getIt<UpdateOrderApi>().updateOrderApi(data: {
        "user_id": "${id}",
        "token": "$token",
        "order_id": ids,
      }).then((value) {
        if (value != null) {
          updateloading = false;
          error = false;
          noInternet = false;
          _updateOrderModel = value;
          notifyListeners();
        } else {
          updateloading = false;
          noInternet = false;
          error = true;
          notifyListeners();
        }
      });
    } else {
      updateloading = false;
      noInternet = true;
      notifyListeners();
    }
  }
}

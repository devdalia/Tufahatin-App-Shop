
import 'package:ecommerce/ui/Screen/home_application.dart';
import 'package:ecommerce/model/category_products_model.dart';
import 'package:ecommerce/providers/add_cart_provider.dart';
import 'package:ecommerce/ui/Screen/login_screen.dart';
import 'package:ecommerce/ui/widget/connection_error_widget.dart';
import 'package:ecommerce/ui/widget/loading_widget.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/custom_dialog.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:developer';
import '../../get_it.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


import 'package:auto_size_text/auto_size_text.dart';

import 'Cash_on_delivery_screen.dart';

class MyCartScreen extends StatefulWidget {
  static const String id = 'MyCartScreen';
  int ?CartProdectId;

  MyCartScreen({CartProdectId});

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  List<CategoryProduct>? listCart = <CategoryProduct>[];
  String ?token;

  @override
  void initState() {
    getPrefValues();
    getIt<AddCartProvider>().getCart();
    getIt<AddCartProvider>().getTotals();
    super.initState();
  }

  bool persistent = true;
  EdgeInsets margin = EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddCartProvider>(
      builder: (context, value, child) {
        if (value.list.isNotEmpty) {
          if (value.cartloading) {
            return LoadingWidget(color: kPrimaryColor);
          }
          if (value.error || value.noInternet) {
            return ConnectionErrorWidget(onClick: () {
              getIt<AddCartProvider>().getTotals();
            });
          }
          log("getcart=>${value.list[0].productName}");

          return Scaffold(
            backgroundColor: kPrimaryColor,
            key: getIt<AddCartProvider>().addCart,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              elevation: 0,
              title: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "السلة",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 18.0.sp,
                ),
                onPressed: () {
                  Navigator.pop(context, HomeApplication.id);
                },
              ),
            ),
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    //  margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: value.list.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding:
                                EdgeInsets.only(left: 5, right: 5, top: 30),
                                // height: 17.0.h,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      actionExtentRatio: 0.25,
                                      key: UniqueKey(),
                                      secondaryActions: <Widget>[
                                        IconSlideAction(
                                          //  caption: 'Delete',
                                          color: kPrimaryColor,

                                          iconWidget: Icon(Icons.delete_forever,
                                              color: Colors.white,
                                              size: 35.0.sp),
                                          onTap: () {
                                            getIt<AddCartProvider>().deleteCart(
                                                value.list[index].key!);
                                            /*       if(value.list.isNotEmpty)
                                             getIt<AddCartProvider>().getCart();*/
                                          },
                                        )
                                      ],
                                      child: Card(
                                        margin: EdgeInsets.only(bottom: 1),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                          children: [

                                            SizedBox(width: 1),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [

                                                AutoSizeText(
                                                  '${value.list[index].productName}',
                                                  minFontSize: 10,
                                                  stepGranularity: 5,
                                                  softWrap: true,
                                                  maxLines: 15,
                                                  overflow:
                                                  TextOverflow.visible,
                                                  style: TextStyle(
                                                      color: kTextLightColor,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(height: 3.5.h),
                                                Row(
                                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [


                                                    Consumer<AddCartProvider>(
                                                      builder: (context, val,
                                                          child) {
                                                        if (val.error ||
                                                            val.noInternet) {
                                                          return ConnectionErrorWidget(
                                                              onClick: () {
                                                                getIt<AddCartProvider>().updataCart(value.list[index].key!, value.list[index].quantity!);
                                                              });
                                                        }
                                                        log("updatacart=>${value.list[index].key!}");
                                                        return Row(
                                                          children: [
                                                            Container(
                                                              height: 4.5.h,
                                                              width: 8.0.w,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: kBlueColor,
                                                                borderRadius: BorderRadius.circular(5),
                                                              ),
                                                              child:
                                                              OutlineButton(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    right: 5, left: 5),
                                                                color: Colors.white.withOpacity(0.7),
                                                                borderSide: BorderSide.none,
                                                                child: Icon(
                                                                    Icons.remove,
                                                                    color: Colors.white),
                                                                onPressed: () {
                                                                  if (value.list[index].quantity! > 1)
                                                                    setState(
                                                                            () {
                                                                          val.list[index].quantity! -1;
                                                                        });
                                                                  getIt<AddCartProvider>().updataCart(value.list[index].key!, value.list[index].quantity!);
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 2.5.w),
                                                            Text(
                                                                '${value.list[index].quantity}',
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                                style: TextStyle(
                                                                    color:
                                                                    kTextColor,
                                                                    fontSize:
                                                                    14.0.sp,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                            SizedBox(
                                                                width: 2.5.w),
                                                            Container(
                                                              height: 4.5.h,
                                                              width: 8.0.w,
                                                              decoration:
                                                              BoxDecoration(
                                                                color:
                                                                kPrimaryColor,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    5),
                                                              ),
                                                              child:
                                                              OutlineButton(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    right:
                                                                    5,
                                                                    left:
                                                                    5),
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                    0.7),
                                                                borderSide:
                                                                BorderSide
                                                                    .none,
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    value.list[index].quantity!+1;
                                                                  });
                                                                  getIt<AddCartProvider>().updataCart(value.list[index].key!, value.list[index].quantity!);
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                    SizedBox(width: 10.0.w),
                                                    Text(
                                                      '  ${value.list[index].productPrice}',
                                                      style: TextStyle(
                                                          color: kPrimaryColor,
                                                          fontSize: 15.0.sp,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              child: Container(
                                                width: 32.0.w,
                                                height: 15.0.h,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.fitWidth,
                                                    image: NetworkImage(
                                                        "${value.list[index].productImage}"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 1.5.h),
                          Container(
                            height: 6.0.h,
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 15),
                            color: Colors.black26.withOpacity(0.05),
                            child: Text(
                              "كود الخصم",
                              style: TextStyle(
                                  color: kTextLightColor,
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 1.0.h),
                          Container(
                            height: 12.0.h,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(" * كود واحد لكل طلب",
                                    style: TextStyle(
                                        color: kBlueColor,
                                        fontSize: 12.0.sp,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 1.0.h),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 5.0.h,
                                      width: 25.0.w,
                                      decoration: BoxDecoration(
                                        color: kBlueColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "تفعيل",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.0.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      width: 60.0.w,
                                      padding: EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                        color: kBlueColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextField(
                                        keyboardType:
                                        TextInputType.numberWithOptions(),
                                        decoration: InputDecoration(
                                          hintText: "استخدم كوبون / رمز الخصم ",
                                          hintStyle: TextStyle(
                                              fontSize: 12, color: kColorfont2),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 1.5.h),
                          Container(
                            height: 6.0.h,
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 35),
                            color: Colors.black26.withOpacity(0.05),
                            child: Text(
                              "ملخص الطلب",
                              style: TextStyle(
                                  color: kTextLightColor,
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 1.5.h),

                          Consumer<AddCartProvider>(
                            builder: (context, val, child) {
                              //log("totals=> ");
                              if (val.totalsloading) {
                                return LoadingWidget(color: kPrimaryColor);
                              }
                              log("totals=> ${val.error}");
                              if (val.error || val.noInternet) {
                                return ConnectionErrorWidget(onClick: () {
                                  getIt<AddCartProvider>().getTotals();
                                });
                              }
                              log("totals=>${val.getTotalsCartModel!.subtotal!}");
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                    EdgeInsets.only(left: 15, right: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [


                                            Text(
                                              '\$\ ${val.getTotalsCartModel!.subtotal!}',
                                              style: TextStyle(
                                                  color: kTextLightColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Text(
                                              "السعر الجزئي",
                                              style: (TextStyle(
                                                  color: kBlueColor,
                                                  fontSize: 12.0.sp)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 0.7.h),
                                        Row(
                                          children: [
                                            Text(
                                              '\$\ ${val.getTotalsCartModel!.discountTax!}',
                                              style: TextStyle(
                                                  color: kTextLightColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Text(
                                              "الخصم",
                                              style: (TextStyle(
                                                  color: kBlueColor,
                                                  fontSize: 12.0.sp)),
                                            ),


                                          ],
                                        ),
                                        SizedBox(height: 0.7.h),
                                        Row(
                                          children: [


                                            Text(
                                              '\$\ ${val.getTotalsCartModel!.totalTax!}',
                                              style: TextStyle(
                                                  color: kTextLightColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Text(
                                              "مجموع الضريبة",
                                              style: (TextStyle(
                                                  color: kBlueColor,
                                                  fontSize: 12.0.sp)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 0.7.h),
                                        Row(
                                          children: [


                                            Text(
                                              '\$\ ${val.getTotalsCartModel!.subtotal!}',
                                              style: TextStyle(
                                                  color: kTextLightColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Text(
                                              "الضريبة المضافة (٪ 15)",
                                              style: (TextStyle(
                                                  color: kBlueColor,
                                                  fontSize: 12.0.sp)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 1.5.h),
                                  Container(
                                    margin:
                                    EdgeInsets.only(left: 19, right: 19),
                                    height: 0.8,
                                    width: double.infinity,
                                    color: kTextLightColor,
                                  ),
                                  SizedBox(height: 2.5.h),
                                  Container(
                                    padding:
                                    EdgeInsets.only(left: 15, right: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [


                                            Text(
                                              '\$\ ${val.getTotalsCartModel!.total!}',
                                              style: (TextStyle(
                                                  color: kTextLightColor,
                                                  fontSize: 14.0.sp,
                                                  fontWeight: FontWeight.bold)),
                                            ),
                                            Spacer(),
                                            Text(
                                              "المجموع",
                                              style: (TextStyle(
                                                  color: kTextLightColor,
                                                  fontSize: 14.0.sp,
                                                  fontWeight: FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2.5.h),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 6.0.h,
                                          width: 80.0.w,
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius:
                                            BorderRadius.circular(20),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              if (token == '') {
                                                errorDialog(
                                                  context: context,
                                                  message:
                                                  ('الرجاء تسجيل الدخول لاكمال الطلب'),
                                                  functionOk: () =>
                                                      Navigator.pushNamed(
                                                          context,
                                                          LoginScreen.id),
                                                );
                                              } else {
                                                Navigator.pushNamed(context,
                                                    CashOnDeliveryScreeen.id);
                                              }
                                            },
                                            child: Text(
                                              "اكمل عملية الشراء ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.0.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          );
        }
        return  Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.cart,
                  color: kPrimaryColor,
                  size:80.0.sp,
                ),
                SizedBox(height: 2.0.h),
                Text(
                  "السلة فارغة",
                  style: TextStyle(color:kPrimaryColor, fontSize: 25.0.sp),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  getPrefValues() async {
    String tokenPref = await getPrefString(token_pref);
    setState(() {
      token = tokenPref;
      print(tokenPref);
      // log('token => ${tokenPref}');
    });
  }



}



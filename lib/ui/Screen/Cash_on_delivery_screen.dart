import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce/model/category_products_model.dart';
import 'package:ecommerce/model/location_model.dart';
import 'package:ecommerce/model/payment_model.dart';
import 'package:ecommerce/providers/add_cart_provider.dart';
import 'package:ecommerce/providers/location_provider.dart';
import 'package:ecommerce/providers/order_provider.dart';
import 'package:ecommerce/ui/Screen/add_location_screen.dart';
import 'package:ecommerce/ui/Screen/home_application.dart';
import 'package:ecommerce/ui/widget/connection_error_widget.dart';
import 'package:ecommerce/ui/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:cool_alert/cool_alert.dart';
import '../../get_it.dart';


class CashOnDeliveryScreeen extends StatefulWidget {
  static const String id = "CashOnDeliveryScreeen";

  @override
  _CashOnDeliveryScreeenState createState() => _CashOnDeliveryScreeenState();
}

class _CashOnDeliveryScreeenState extends State<CashOnDeliveryScreeen> {
  List<CategoryProduct> ?listCart = <CategoryProduct>[];

  @override
  void initState() {
    getIt<AddCartProvider>().getCart();
    getIt<AddCartProvider>().getTotals();
    //getIt<CreateOrderProvider>().getPayment();
    getIt<LocationProvider>().getLocations();
    super.initState();
  }

  PaymentModel? itemSelected;
  Datass ?userAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "تفاصيل الطلب",
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
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 2, right: 2, top: 5),
              //  margin: EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //  SizedBox(height: 5.0.h),
                    Container(
                      height: 6.0.h,
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      color: Colors.black26.withOpacity(0.05),
                      child: Text(
                        "تفاصيل التسليم",
                        style: TextStyle(
                            color: kTextLightColor,
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 1.0.h),
                          Text(
                            "موقع التسليم",
                            style: TextStyle(
                                color: kTextLightColor,
                                fontSize: 13.0.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AddLocationScreen.id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "حدد الموقع ",
                                  style: TextStyle(
                                      color: kTextLightColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0.sp

                                  ),
                                ),
                                Icon(
                                  Icons.add_location_alt_outlined,
                                  color: kPrimaryColor,
                                  size: 15.0.sp,
                                ),
                              ],
                            ),
                          ),
                          Consumer<LocationProvider>(
                            builder: (context, valueee, child) {
                              if (valueee.loading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              return Container(
                                padding: EdgeInsets.only(left: 10, right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          hint: new Text('اختار العنوان',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: kTextLightColor,
                                                  fontSize: 12.0.sp,
                                                  fontWeight: FontWeight.w500)),
                                          iconEnabledColor: kPrimaryColor,
                                          iconDisabledColor: kPrimaryColor,
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          dropdownColor: Colors.white,
                                          items: valueee.locationModel!.data!
                                              .map((Datass item) {
                                            print(
                                                "dsssssa${valueee.locationModel!.data}");
                                            return DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item.fullAddress!,
                                                  style: TextStyle(
                                                      color: kTextLightColor,
                                                      fontSize: 12.0.sp,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ));
                                          }).toList(),
                                          isExpanded: true,
                                          value: userAddress,
                                          onChanged: (value) {
                                            setState(() {
                                              userAddress = value as Datass?;

                                              getIt<CreateOrderProvider>()
                                                  .userAddress = value;
                                            });
                                          }),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 2.0.h),
                    Container(
                      height: 6.0.h,
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 15),
                      color: Colors.black26.withOpacity(0.05),
                      child: Text(
                        "طرق الدفع",
                        style: TextStyle(
                            color: kTextLightColor,
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "الدفع نقدا عند الاستلام",
                        style: TextStyle(
                            color: kTextColor,
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    /*  Consumer<CreateOrderProvider>(
                      builder: (context, value, child) {
                        if (value.paymentloading) {
                          return LoadingWidget(color: kPrimaryColor);
                        }
                        return Container(
                          padding: EdgeInsets.only(left: 10, right: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    hint: new Text('طرق الدفع',
                                        style: TextStyle(
                                            color: kTextLightColor,
                                            fontSize: 12.0.sp,
                                            fontWeight: FontWeight.w500)),
                                    iconEnabledColor: kPrimaryColor,
                                    iconDisabledColor: kPrimaryColor,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    dropdownColor: Colors.white,
                                    items: value.paymentModel.paymentDetails
                                        .map((PaymentModel item) {
                                      return DropdownMenuItem(
                                          value: item,
                                          child: Text(item.id,
                                              style: TextStyle(
                                                  color: kTextLightColor,
                                                  fontSize: 12.0.sp,
                                                  fontWeight:
                                                      FontWeight.w500)));
                                    }).toList(),
                                    isExpanded: true,
                                    value: itemSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        itemSelected = value;
                                        getIt<CreateOrderProvider>()
                                            .itemSelected = value;
                                      });
                                    }),
                              ),
                              if (itemSelected != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      ":الوصف ",
                                      style: TextStyle(
                                          color: kTextLightColor,
                                          fontSize: 12.0.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 3.0.w),
                                    Text(
                                      itemSelected == null
                                          ? '  '
                                          : itemSelected.description,
                                      style: TextStyle(
                                          color: kTextLightColor,
                                          fontSize: 12.0.sp),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        );
                      },
                    ),*/
                    SizedBox(height: 2.0.h),
                    Container(
                      height: 6.0.h,
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      color: Colors.black26.withOpacity(0.05),
                      child: Text(
                        "التحقق من الطلب",
                        style: TextStyle(
                            color: kTextLightColor,
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Consumer<AddCartProvider>(builder: (context, value, child) {
                      if (value.cartloading) {
                        return LoadingWidget(color: kPrimaryColor);
                      }
                      if (value.error || value.noInternet) {
                        return ConnectionErrorWidget(onClick: () {
                          getIt<AddCartProvider>().getCart();
                        });
                      }
                      return ListView.builder(
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
                                Card(
                                  margin: EdgeInsets.only(bottom: 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width:0.25),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
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
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Quantity:",
                                                    style: TextStyle(
                                                        color: kTextLightColor,
                                                        fontSize: 12.0.sp,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 1.0.w),
                                                  Text(
                                                    '${value.list[index].quantity}X',
                                                    style: TextStyle(
                                                        color: kBlueColor,
                                                        fontSize: 14.0.sp,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
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
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  "${value.list[index].productImage}"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }),
                    SizedBox(height: 2.0.h),

                    Container(
                      height: 6.0.h,
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
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
                        if (val.totalsloading) {
                          return LoadingWidget(color: kPrimaryColor);
                        }
                        if (val.error || val.noInternet) {
                          return ConnectionErrorWidget(onClick: () {
                            getIt<AddCartProvider>().getTotals();
                          });
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '\$\ ${val.getTotalsCartModel!.subtotal}',
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
                                        '\$\ ${val.getTotalsCartModel!.discountTax}',
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
                                        '\$\ ${val.getTotalsCartModel!.totalTax}',
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
                                        '\$\ ${val.getTotalsCartModel!.subtotal}',
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
                              margin: EdgeInsets.only(left: 19, right: 19),
                              height: 0.8,
                              width: double.infinity,
                              color: kTextLightColor,
                            ),
                            SizedBox(height: 2.5.h),
                            Consumer<AddCartProvider>(
                              builder: (context, value, child) {
                                if (value.error || value.noInternet) {
                                  return ConnectionErrorWidget(onClick: () {
                                    getIt<AddCartProvider>().getCart();
                                  });
                                }
                                return Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '\$\ ${val.getTotalsCartModel!.total}',
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
                                      Consumer<CreateOrderProvider>(
                                        builder: (ctx, valass, child) =>
                                            InkWell(
                                              onTap: () {
                                                CoolAlert.show(
                                                  context: context,
                                                  type: CoolAlertType.warning,
                                                  animType:
                                                  CoolAlertAnimType.slideInUp,
                                                  title: " الحد الادنى لطلب...",
                                                  text:
                                                  "هل انت متاكد من اتمام الطلب؟؟ ${val.getTotalsCartModel!.total}\n ",
                                                  backgroundColor: kPrimaryColor,
                                                  //   flareAsset: "dalia",
                                                  confirmBtnColor: kBlueColor,
                                                  showCancelBtn: true,

                                                  onConfirmBtnTap: () {
                                                    valass.creataOrder();
                                                    CoolAlert.show(
                                                      context: context,
                                                      type: CoolAlertType.success,
                                                      animType: CoolAlertAnimType
                                                          .slideInUp,
                                                      title: " ثم الطلب بنجاح",

                                                      backgroundColor:
                                                      kPrimaryColor,
                                                      //   flareAsset: "dalia",
                                                      confirmBtnColor: kBlueColor,
                                                      showCancelBtn: false,
                                                      onConfirmBtnTap: () {
                                                        Navigator
                                                            .pushNamedAndRemoveUntil(
                                                            context,
                                                            HomeApplication.id,
                                                                (route) => false);
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 6.0.h,
                                                width: 80.0.w,
                                                margin: EdgeInsets.only(bottom: 20),
                                                decoration: BoxDecoration(
                                                  color: kPrimaryColor,
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  "تاكيد الطلب",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.0.sp,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                );
                              },
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
}

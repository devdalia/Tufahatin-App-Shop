import 'package:ecommerce/providers/home_provider.dart';
import 'package:ecommerce/ui/Screen/home_application.dart';
import 'package:ecommerce/ui/widget/connection_error_widget.dart';
import 'package:ecommerce/ui/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:move_to_background/move_to_background.dart';

import '../../get_it.dart';
import 'home_screen.dart';

class InformationScreen extends StatefulWidget {

  static const String id="InformationScreen";
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {


  int selected  = 0;
  int ?selectedIndex;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        //  MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            alignment: Alignment.center,
            child:    Text(
              "الأقسام",

              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // leading: IconButton(
          //   icon: Icon(
          //     CupertinoIcons.arrow_left,
          //     color: kPrimaryColor,
          //     size: 18.0.sp,
          //   ),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),

        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.only(left: 10, right: 10),
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),

              ),
              Consumer<HomeProvider>(
                builder: (context, value, child){
                  if (value.categoryLoading) {
                    return LoadingWidget(color: Colors.white.withOpacity(0.4));
                  }
                  if (value.error || value.noInternet) {
                    return ConnectionErrorWidget(onClick: () {
                      getIt<HomeProvider>().getCategories();
                    });
                  }
                  return   GridView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            getIt<HomeProvider>().selectCategoryId = value.categoriesModel.productsDetails![index].id!;
                            getIt<HomeProvider>().getProductsEstate(value.categoriesModel.productsDetails![index].id!);
                            Navigator.popAndPushNamed(context, HomeApplication.id);
                            selected = value.categoriesModel.productsDetails![index].id!;
                            print("selectt category:${selected}");
                          });
                        },
                        child: Container(
                          height: 25.0.h,
                          width: double.infinity,
                          alignment: Alignment.center,


                          // margin: EdgeInsets.only(
                          //   right: index == value.categoriesModel.productsDetails.length - 1 ? kDefaultPadding : 0,
                          // ),

                          padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          decoration: BoxDecoration(
                            // color: index == selectedIndex
                            //     ? Colors.white.withOpacity(0.4)
                            //     : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            color: kPrimaryColor,
                          ),
                          child: Text(
                            value.categoriesModel.productsDetails![index].name!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.bold,

                                fontSize: 16.5.sp),
                          ),
                        ),
                      );
                    },
                    itemCount:value.categoriesModel.productsDetails!.length,
                    addSemanticIndexes: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(top:10,left: 15,right: 15),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                  );
                },

              ),

            ],
          ),
        ),

      ),
    );
  }
}


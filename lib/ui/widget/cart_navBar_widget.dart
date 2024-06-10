import 'package:ecommerce/get_it.dart';
import 'package:ecommerce/providers/add_cart_provider.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ecommerce/model/category_products_model.dart';


class CartNavBarWidget extends StatefulWidget {
  @override
  _CartNavBarWidgetState createState() => _CartNavBarWidgetState();
}

class _CartNavBarWidgetState extends State<CartNavBarWidget> {
  @override
  void initState() {
    getIt<AddCartProvider>().getCart();
    super.initState();
  }
  List<CategoryProduct>? listCart=<CategoryProduct>[];
  List<int> listca  =[];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(Icons.shopping_cart, color: kBlueColor,size: 23.0.sp),
        Positioned(
          top: 0,
          right: 0,
          child: ClipOval(
            child: Material(
              color:Colors.white,
              child: Consumer<AddCartProvider>(
                builder: (context,value,child) {
                  return Container(
                    alignment: Alignment.center,
                    height: 15,
                    width: 15,
                    child: Text(
                      value.list.length == null
                          ? '0'
                          : value.list.length.toString(),
                      style: TextStyle(color: kTextColor, fontSize: 8.0.sp),

                    ),
                  );

                },
              ),
            ),
          ),
        ),
      ],
    );
  }

}

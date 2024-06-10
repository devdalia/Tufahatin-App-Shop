import 'dart:convert';

import 'package:ecommerce/model/category_products_model.dart';
import 'package:ecommerce/model/favourites_model.dart';
import 'package:ecommerce/providers/add_cart_provider.dart';
import 'package:ecommerce/ui/Screen/details_product_sreen.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../get_it.dart';

class BodyHome extends StatefulWidget {
  CategoryProduct model;

  BodyHome({required this.model});

  @override
  _BodyHomeState createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  // List<Favorites> _saved = List<Favorites>();
  List<Favorites>? listFavorite = <Favorites>[];

  List<int> list = [];
  int selectedIndex = 0;

  @override
  void initState() {
    //getIt<HomeProvider>().getProductsEstate(widget.model.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33.0.h,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 2, top: 2),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, DetailsPreoductScreen.id,
              arguments: widget.model.id);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    list.contains(widget.model.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: list.contains(widget.model.id)
                        ? kPrimaryColor
                        : kBlueColor,
                    size: 20.0.sp,
                  ),
                  onPressed: () async {
                    bool alreadySaved = false;
                    listFavorite!.forEach((element) {
                      if (element.id == widget.model.id) {
                        setState(() {
                          alreadySaved = true;
                        });
                      } else {
                        setState(() {
                          alreadySaved = false;
                        });
                      }
                    });
                    if (listFavorite == [] || listFavorite == null) {
                      print('empty');
                      setState(() {
                        alreadySaved = false;
                      });
                    }
                    if (alreadySaved) {
                      print('no');
                      list.remove(widget.model.id);
                      listFavorite!.removeWhere((item) => item.id == widget.model.id);
                      await savePrefString('favorite', json.encode(listFavorite!.map((e) => e.toJson()).toList()));
                      getPrefString('favorite').then((value) => print(value));
                    } else {
                      print('yes');
                      list.add(widget.model.id!);
                      listFavorite!.add(Favorites(
                          id: widget.model.id,
                          name: widget.model.name,
                          price: widget.model.price,
                          ratingCount: widget.model.ratingCount,
                          averageRating: widget.model.averageRating,
                          images: widget.model.images![0].src.toString()));
                      await savePrefString('favorite', json.encode(listFavorite!.map((e) => e.toJson()).toList()));
                      getPrefString('favorite').then((value) => print(value));
                    }
                    setState(() {

                    });
                  },
                ),
                Consumer<AddCartProvider>(
                  builder: (context, val, child) {
                    return IconButton(
                      icon: Icon(
                        CupertinoIcons.cart_fill_badge_plus,
                        color: kPrimaryColor,
                        size: 20.0.sp,
                      ),
                      onPressed: () async {
                        //      val.AddCart(value.id.toString(), value.quntity.toInt());
                        val.AddCart(widget.model.id.toString(),
                            widget.model.quntity.toInt());
                        _showCenterFlash("  Add To Cart Successfully");
                      },
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (widget.model.images!.isNotEmpty)
                  Container(
                    alignment: Alignment.topLeft,
                    // padding: EdgeInsets.only(bottom: 0, right: 3),
                    height: 19.0.h,
                    width: 44.5.w,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(30),
                      //   topRight: Radius.circular(30),
                      // ),
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage("${widget.model.images![0].src}"),
                      ),
                    ),
                  ),
                if (widget.model.images!.isEmpty)
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(bottom: 0, right: 3),
                    height: 16.0.h,
                    width: 30.5.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage('assets/images/sho2.jpg'),
                      ),
                    ),
                  ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 3),
              alignment: Alignment.centerLeft,
              //     width: size.width - 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpandableText(
                    '${widget.model.name}',
                    expandText: ' ',
                    collapseText: 'show less',
                    maxLines: 1,
                    expanded: false,
                    linkColor: Colors.blue,
                    style: TextStyle(fontSize: 9.5.sp, color: kTextColor),
                  ),
                  // Text('${widget.model.name}',
                  //     maxLines: 3,
                  //     textAlign: TextAlign.left,
                  //     style: TextStyle(
                  //       color: kTextColor,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 10.0.sp,
                  //     )),
                  //      SizedBox(height: 1.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$\ ${widget.model.price.toString()}',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      //   Spacer(),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 3.2.h,
                            width: 8.0.w,
                            // padding: EdgeInsets.only(right: 15,left: 0),
                            decoration: BoxDecoration(
                              color: kBlueColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: OutlineButton(
                                padding: EdgeInsets.only(right: 5, left: 5),
                                color: Colors.white.withOpacity(0.7),
                                borderSide: BorderSide.none,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  if (widget.model.quntity > 1)
                                    setState(() {
                                      widget.model.quntity--;
                                    });
                                }),
                          ),
                          SizedBox(width: 1.5.w),
                          Text(widget.model.quntity.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: 1.5.w),
                          Container(
                            alignment: Alignment.center,
                            height: 3.2.h,
                            width: 8.0.w,
                            //    padding: EdgeInsets.only(right: 15,left: 0),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: OutlineButton(
                                padding: EdgeInsets.only(right: 5, left: 5),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.model.quntity++;
                                  });

                                  print(
                                      "dddddddddddddddddddddddddddddddd${widget.model.quntity}");
                                }),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCenterFlash(String txxt) {
    showFlash(
      context: context,
      duration: Duration(seconds: 1),
      builder: (_, controller) {
        return Flash.dialog(
          controller: controller,
          backgroundColor: kColorfont,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: Colors.blue,
          alignment: Alignment.center,
          //  enableDrag: false,
          onTap: () => controller.dismiss(),
          child: Container(
            height: 8.0.h,
            width: 70.0.w,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.white),
              child: Text(txxt,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 12.0.sp)),
            ),
          ),
        );
      },
    ).then((_) {
      if (_ != null) {
        _showMessage(_.toString());
      }
    });
  }

  void _showMessage(String message) {
    if (!mounted) return;
    showFlash(
        context: context,
        duration: Duration(seconds: 3),
        builder: (_, controller) {
          return Flash(
            controller: controller,
            position: FlashPosition.top,
            //  style: FlashStyle.grounded,
            child: FlashBar(
              icon: Icon(
                CupertinoIcons.delete,
                size: 36.0,
                color: Colors.black,
              ),title: Text(message), content: Container(),

            ),
          );
        });
  }

// Widget buildStaggeredGridView(CategoryProduct value) {
//   bool fav = false;
//   for (var item in _saved) {
//     if (item.id == value.id.toString()) {
//       fav = true;
//     }
//   }
//   int qun = 1;
//   return Container(
//     height: 33.0.h,
//     width: double.infinity,
//     decoration: BoxDecoration(
//         color: Colors.white, borderRadius: BorderRadius.circular(15)),
//     child: InkWell(
//       onTap: () {
//         Navigator.pushNamed(context, DetailsPreoductScreen.id,
//             arguments: value.id);
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: Icon(
//                   list.contains(value.id)
//                       ? Icons.favorite
//                       : Icons.favorite_border,
//                   color: list.contains(value.id) ? kPrimaryColor : kBlueColor,
//                   size: 20.0.sp,
//                 ),
//                 onPressed: () async {
//                   bool alreadySaved = false;
//                   listFavorite.forEach((element) {
//                     if (element.id == value.id) {
//                       setState(() {
//                         alreadySaved = true;
//                       });
//                     } else {
//                       setState(() {
//                         alreadySaved = false;
//                       });
//                     }
//                   });
//                   if (listFavorite == [] || listFavorite == null) {
//                     print('empty');
//                     setState(() {
//                       alreadySaved = false;
//                     });
//                   }
//                   if (alreadySaved) {
//                     print('no');
//                     list.remove(value.id);
//
//                     listFavorite.removeWhere((item) => item.id == value.id);
//                     await savePrefString(
//                         'favorite',
//                         json.encode(
//                             listFavorite.map((e) => e.toJson()).toList()));
//                     getPrefString('favorite').then((value) => print(value));
//                   } else {
//                     print('yes');
//                     list.add(value.id);
//                     listFavorite.add(Favorites(
//                         id: value.id,
//                         name: value.name,
//                         price: value.price,
//                         ratingCount: value.ratingCount,
//                         averageRating: value.averageRating,
//                         images: value.images[0].src));
//                     await savePrefString(
//                         'favorite',
//                         json.encode(
//                             listFavorite.map((e) => e.toJson()).toList()));
//                     getPrefString('favorite').then((value) => print(value));
//                   }
//                 },
//               ),
//               SizedBox(height: 3.5.w),
//               Consumer<AddCartProvider>(
//                 builder: (context, val, child) {
//                   return IconButton(
//                     icon: Icon(
//                       CupertinoIcons.cart_fill_badge_plus,
//                       color: kPrimaryColor,
//                       size: 20.0.sp,
//                     ),
//                     onPressed: () async {
//                       val.AddCart(value.id.toString(), value.quntity.toInt());
//                       _showCenterFlash("  Add To Cart Successfully");
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               if (value.images.isNotEmpty)
//                 Container(
//                   alignment: Alignment.topLeft,
//                   // padding: EdgeInsets.only(bottom: 0, right: 3),
//                   height: 15.0.h,
//                   width: 44.5.w,
//                   decoration: BoxDecoration(
//                     // borderRadius: BorderRadius.only(
//                     //   topLeft: Radius.circular(30),
//                     //   topRight: Radius.circular(30),
//                     // ),
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: NetworkImage("${value.images[0].src}"),
//                     ),
//                   ),
//                 ),
//               if (value.images.isEmpty)
//                 Container(
//                   alignment: Alignment.topLeft,
//                   padding: EdgeInsets.only(bottom: 0, right: 3),
//                   height: 15.0.h,
//                   width: 30.5.w,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30),
//                     ),
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: AssetImage('assets/images/sho2.jpg'),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           Container(
//             padding: EdgeInsets.only(left: 10, right: 10, top: 12),
//             alignment: Alignment.centerLeft,
//             //     width: size.width - 30,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('${value.name}',
//                     maxLines: 3,
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: kTextColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 10.0.sp,
//                     )),
//                 SizedBox(height: 1.0.h),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '\$\ ${value.price.toString()}',
//                       style: TextStyle(
//                           color: kPrimaryColor,
//                           fontSize: 14.0.sp,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     //   Spacer(),
//                     Row(
//                       children: [
//                         Container(
//                           alignment: Alignment.center,
//                           height: 3.2.h,
//                           width: 8.0.w,
//                           // padding: EdgeInsets.only(right: 15,left: 0),
//                           decoration: BoxDecoration(
//                             color: kBlueColor,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: OutlineButton(
//                               padding: EdgeInsets.only(right: 5, left: 5),
//                               color: Colors.white.withOpacity(0.7),
//                               borderSide: BorderSide.none,
//                               child: Icon(
//                                 Icons.remove,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () async {
//                                 if (value.quntity > 1)
//                                   setState(() {
//                                     value.quntity--;
//                                   });
//                               }),
//                         ),
//                         SizedBox(width: 1.5.w),
//                         Text(value.quntity.toString(),
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: kTextColor,
//                                 fontSize: 12.0.sp,
//                                 fontWeight: FontWeight.bold)),
//                         SizedBox(width: 1.5.w),
//                         Container(
//                           alignment: Alignment.center,
//                           height: 3.2.h,
//                           width: 8.0.w,
//                           //    padding: EdgeInsets.only(right: 15,left: 0),
//                           decoration: BoxDecoration(
//                             color: kPrimaryColor,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: OutlineButton(
//                               padding: EdgeInsets.only(right: 5, left: 5),
//                               child: Icon(
//                                 Icons.add,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   value.quntity++;
//                                 });
//
//                                 print(
//                                     "dddddddddddddddddddddddddddddddd${value.quntity}");
//                               }),
//                         ),
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}

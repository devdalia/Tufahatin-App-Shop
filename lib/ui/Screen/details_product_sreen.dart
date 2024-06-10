import 'package:ecommerce/model/category_products_model.dart';
import 'package:ecommerce/model/review_model.dart';
import 'package:ecommerce/providers/add_cart_provider.dart';
import 'package:ecommerce/providers/details_realestate_provider.dart';
import 'package:ecommerce/providers/review_provider.dart';
import 'package:ecommerce/ui/Screen/home_application.dart';
import 'package:ecommerce/ui/Screen/mycart_screen.dart';
import 'package:ecommerce/ui/widget/cart_navBar_widget.dart';
import 'package:ecommerce/ui/widget/connection_error_widget.dart';
import 'package:ecommerce/ui/widget/footer_widget.dart';
import 'package:ecommerce/ui/widget/loading_widget.dart';
import 'package:ecommerce/ui/widget/tabBar_details_widget.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:expandable_text/expandable_text.dart';
import '../../get_it.dart';
import 'package:flash/flash.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsPreoductScreen extends StatefulWidget {
  static const String id = 'DetailsPreoductScreen';
  var ProdectId;

  DetailsPreoductScreen({required this.ProdectId});

  @override
  _DetailsPreoductScreenState createState() => _DetailsPreoductScreenState();
}

class _DetailsPreoductScreenState extends State<DetailsPreoductScreen> {
  int _tabClick = 0;
  int Page_indix = 0;
  PageController? _controller;

  final double height = 60;
  double elasticHeight = 0;
  final GlobalKey _tabBarHeight = GlobalKey();
  final GlobalKey _mainContainer = GlobalKey();
  final GlobalKey _columnContainer = GlobalKey();

  @override
  int _quantity = 1;

  calculateHeight() {
    try {
      final RenderBox? renderBoxRed =
      _mainContainer.currentContext!.findRenderObject() as RenderBox?;
      final RenderBox? tabBarRenderBoxRed =
      _tabBarHeight.currentContext!.findRenderObject() as RenderBox?;
      final RenderBox? columnRenderBoxRed =
      _columnContainer.currentContext!.findRenderObject() as RenderBox?;
      double _height = MediaQuery.of(context).size.height -
          renderBoxRed!.size.height -
          tabBarRenderBoxRed!.size.height -
          columnRenderBoxRed!.size.height;

      if (_height > 0) {
        setState(() {
          elasticHeight = _height;
        });
      } else {
        setState(() {
          elasticHeight = 0;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      calculateHeight();
    });
    getIt<ReviewProvider>().id = widget.ProdectId;
    getIt<ReviewProvider>().getReviewdata();
    getIt<DetailsProductsProvider>().getDatailsProducts(widget.ProdectId!);
    getIt<AddCartProvider>().getCart();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DetailsPreoductScreen oldWidget) {
    calculateHeight();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.ProdectId);

    return Consumer<DetailsProductsProvider>(
      builder: (context, value, child) {
        if (value.loading) {
          return LoadingWidget(color: kPrimaryColor);
        }
        if (value.error || value.noInternet) {
          return ConnectionErrorWidget(onClick: () {
            getIt<DetailsProductsProvider>()
                .getDatailsProducts(widget.ProdectId!);
          });
        }
        return Scaffold(
          key: getIt<ReviewProvider>().review,
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text(value.categoryProduct!.name!),
            elevation: 3.7,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 0),
              child: IconButton(
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white.withOpacity(0.7),
                  size: 18.0.sp,
                ),
                onPressed: () {
                  Navigator.pop(context, HomeApplication.id);
                },
              ),
            ),
            actions: [
              Container(
                padding: EdgeInsets.only(right: 10, top: 8),
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, MyCartScreen.id);
                    },
                    child: CartNavBarWidget()),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height:45.0.h,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: PageView(
                    onPageChanged: (page) {
                      setState(() {
                        Page_indix = page;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    children: [
                      Slidar(value.categoryProduct!),
                      Slidar(value.categoryProduct!),
                      Slidar(value.categoryProduct!),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i <= 2; i++)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7.0),
                            child: Container(
                                alignment: Alignment.center,
                                height: 10,
                                width: Page_indix == i ? 20 : 10,
                                color: Page_indix == i
                                    ? kPrimaryColor
                                    : Color.fromRGBO(173, 173, 173, 1)),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        key: _tabBarHeight,
                        child: TabBarDetailsWidget(
                          onChange: (value) {
                            setState(() {
                              _tabClick = value;
                            });
                          },
                        ),
                      ),
                      if (_tabClick == 0)
                        Container(
                          key: _columnContainer,
                          child: Column(
                            children: [
                              buildContainerSilder(value.categoryProduct!),
                            ],
                          ),
                        )
                      else if (_tabClick == 1)
                        Column(
                          children: [
                            FooterWidget(id: value.categoryProduct!),
                            buildRating(value.categoryProduct!),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: Consumer<AddCartProvider>(
            builder: (context, val, child) {
              return Container(
                width: double.infinity,
                height: 7.5.h,
                padding: EdgeInsets.only(right: 15, left: 15, bottom: 5),
                margin: EdgeInsets.only(top: 2),
                alignment: Alignment.center,
                //  margin: EdgeInsets.symmetric(horizontal:25),

                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  title: Text('اضف الى السلة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0.sp)),
                  onTap: () {
                    val.AddCart(value.categoryProduct!.id.toString(),
                        value.categoryProduct!.quntity.toInt());
                    _showCenterFlash("  تمت الاضافة بنجاح");
                    val.getCart();
                    //    print("dddddddddd${value.quntity}");
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildRating(CategoryProduct value) {
    return Consumer<ReviewProvider>(
      builder: (context, value, child) {
        if (value.reviewloading) {
          return LoadingWidget(color: kPrimaryColor);
        }
        if (value.error || value.noInternet) {
          return ConnectionErrorWidget(onClick: () {
            getIt<ReviewProvider>().getReviewdata();
          });
        }
        return Container(
          padding:
          const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: value.reviewModel!.review!
                  .map((e) => buildReviews(e))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Widget buildReviews(Review value) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 15, left: 10),
      margin: EdgeInsets.only(
        bottom: 10,
        top: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    '${value.reviewer}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 13.0.sp,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 0.3.h),
                  Text(
                    '${value.reviewerEmail}',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 8.0.sp, color: kColorfont2),
                  ),
                  SizedBox(height: 0.3.h),
                ],
              ),
              Expanded(child: Container()),
              RatingBar.builder(
                ignoreGestures: true,
                itemSize: 12.0.sp,
                initialRating:
                value.rating == null ? 0.0 : value.rating!.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Color(0xffFFBF18),
                ),
                onRatingUpdate: (double value) {},
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          ExpandableText(
            '${value.review}',
            expandText: 'more',
            collapseText: 'show less',
            maxLines: 2,
            expanded: false,
            linkColor: Colors.blue,
            style: TextStyle(fontSize: 9.0.sp, color: Color(0xff514944)),
          ),
        ],
      ),
    );
  }

  Container buildContainerSilder(CategoryProduct value) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 25, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 4.5.w),
          ExpandableText(
            '${value.name}',
            expandText: "more",
            collapseText: 'show less',
            maxLines: 3,
            expanded: false,
            linkColor: Colors.blue,style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.5.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$\ ${value.price.toString()}',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0.sp),
              ),
              Row(
                children: [
                  RatingBar.builder(
                    ignoreGestures: true,
                    itemSize: 10.0.sp,
                    initialRating: value.ratingCount == null
                        ? 0.0
                        : value.ratingCount!.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Color(0xffFFBF18),
                    ),
                    onRatingUpdate: (rating) {
                      //  print(rating);
                    },
                  ),
                  SizedBox(width: 1.8.w),
                  Text(
                    "${value.averageRating}",
                    style: TextStyle(
                      color: Color(0xff777777),
                      fontSize: 10.0.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4.5.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (value.quntity > 1) {
                        setState(() {
                          value.quntity --;
                          print(value.quntity);
                        });
                      };
                    },
                    child: Container(
                      height: 4.5.h,
                      width: 12.0.w,
                      padding: EdgeInsets.only(right: 5, left: 5),
                      decoration: BoxDecoration(
                        color: kBlueColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  /*OutlinedButton(

                     //   padding: EdgeInsets.only(right: 5, left: 5),
                       // color: Colors.white.withOpacity(0.7),
                      //  borderSide: BorderSide.none,
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (value.quntity > 1) {
                            setState(() {
                              value.quntity -1;
                              //   print(value.quntity);
                            });
                          }
                        }),*/
                  SizedBox(width: 3.0.w),
                  Text(value.quntity.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff57636F),
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 3.0.w),
                  InkWell(
                    onTap: (){
                      setState(() {
                        value.quntity ++;
                        print(value.quntity);
                      });

                    },
                    child: Container(
                      height: 4.5.h,
                      width: 12.0.w,padding: EdgeInsets.only(right: 5, left: 5),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Text(':حدد الكمية',
                  style: TextStyle(color: kTextLightColor, fontSize: 12.0.sp)),
            ],
          ),
          SizedBox(height: 2.5.w),
          value.description!.isNotEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                ':الوصف',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: kTextLightColor,
                  fontSize: 12.0.sp,
                ),
              ),
           //   SizedBox(height: 1.5.h),
              Html(
                data: value.description,
              ),
              /* Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${value.description}',
                      ),
                    ),*/
            ],
          ) : Container(),
          SizedBox(height: 5.5.w),
        ],
      ),
    );
  }

  Widget Slidar(CategoryProduct value) {
    return SafeArea(
      child: Column(
        children: [
          if (value.images!.isNotEmpty)
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45.0.h,
              padding: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("${value.images![0].src}"),
                    fit: BoxFit.fitHeight),
              ),
            ),
          if (value.images!.isEmpty)
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45.0.h,
              padding: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/sho2.jpg'),
                ),
              ),
            ),

        ],
      ),
    );
  }

  /*subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        print(_quantity);
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
      print(_quantity);
    });
  }*/

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
          //enableDrag: false,
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
                Icons.face,
                size: 36.0,
                color: Colors.black,
              ),
              title: Text(message),
              content: Container(),
            ),
          );
        });
  }
}


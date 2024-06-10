import 'package:ecommerce/model/category_products_model.dart';
import 'package:ecommerce/providers/home_provider.dart';
import 'package:ecommerce/ui/Screen/data_search.dart';
import 'package:ecommerce/ui/Screen/mycart_screen.dart';
import 'package:ecommerce/ui/widget/cart_navBar_widget.dart';
import 'package:ecommerce/ui/widget/connection_error_widget.dart';
import 'package:ecommerce/ui/widget/loading_widget.dart';
import 'package:ecommerce/ui/widget/search_box.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../get_it.dart';
import 'package:ecommerce/model/favourites_model.dart';
import 'package:ecommerce/ui/widget/body_home_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

//  int realProdectId;

  //HomeScreen({this.realProdectId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  List<Favorites> _saved = List<Favorites>();
  List<Favorites>? listFavorite = <Favorites>[];

  List<int> list = [];

 // int indexSelected =0;

  @override
  void initState() {
    super.initState();
  }

  List<CategoryProduct> ?listCart = <CategoryProduct>[];

  @override
  Widget build(BuildContext context) {
   // final    id_v1 = ModalRoute.of(context).settings.arguments;


     print('categoryId=> ${getIt<HomeProvider>().selectCategoryId}');
    return Scaffold(
      backgroundColor: kPrimaryColor,
      key: getIt<HomeProvider>().scaffoldKey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        // titleSpacing: 5,
        toolbarHeight: 8.0.h,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 5.8.h,
                  width: 13.0.w,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: Image.asset(
                    "assets/images/logoo.png",
                    color: kPrimaryColor,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 3.0.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.0.h),
                    Text('TOFAHTEEN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 11.5.sp)),
                    Container(
                      width: 19.5.w,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text('تفاحتين',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0.sp)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
      ),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) {
          if (value.categoryLoading) {
            return LoadingWidget(color: Colors.white.withOpacity(0.4));
          }
          if (value.error || value.noInternet) {
            return ConnectionErrorWidget(onClick: () {
              getIt<HomeProvider>().getCategories();
            });
          }
          return SafeArea(
              bottom: false,
              child: Column(
                children: [
                  SearchBox(onChanged: (value) {
                    showSearch(context: context, delegate: DataSearch());
                  }),
                  Container(
                    height: 7.0.h,
                    padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                    child: ListView.builder(
                      addSemanticIndexes: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(top: 0),
                      itemCount: value.categoriesModel.productsDetails!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              getIt<HomeProvider>().selectCategoryId = value.categoriesModel.productsDetails![index].id!;
                              getIt<HomeProvider>().getProductsEstate(value.categoriesModel.productsDetails![index].id!);
                              //indexSelected = index;
                              print("selectt:${index}");
                            });
                          },
                          child: Container(
                            height: 10.0.h,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              right: getIt<HomeProvider>().selectCategoryId == value.categoriesModel.productsDetails![index].id! ? kDefaultPadding : 0,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            decoration: BoxDecoration(
                              color: getIt<HomeProvider>().selectCategoryId ==
                                  value.categoriesModel.productsDetails![index].id!
                                  ? Colors.white.withOpacity(0.4)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              value.categoriesModel.productsDetails![index].name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0.sp),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          padding: EdgeInsets.only(
                              bottom: 5, left: 5, right: 5, top: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Consumer<HomeProvider>(
                            builder: (context, valueee, child) {
                              if (valueee.getproductLoading) {
                                return LoadingWidget(color: kPrimaryColor);
                              }
                              //getIt<HomeProvider>().getProductsEstate(value.categoriesModel.productsDetails![getIt<HomeProvider>().selectCategoryId].id!);

                              return StaggeredGridView.countBuilder(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  itemCount: valueee.modelcategory!.productsDetails!.length,
                                  itemBuilder: (context, index) {
                                    return Card(child: BodyHome(model: valueee.modelcategory!.productsDetails![index],
                                    ));
                                  },
                                  staggeredTileBuilder: (index) {
                                    return StaggeredTile.count(
                                        1, index.isEven ? 1.5 : 1.5);
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}

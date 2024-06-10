import 'dart:convert';
import 'package:ecommerce/model/favourites_model.dart';
import 'package:ecommerce/providers/details_realestate_provider.dart';
import 'package:ecommerce/ui/Screen/details_product_sreen.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../get_it.dart';

class FavoriteScreen extends StatefulWidget {
  static const String id = 'FavoriteScreen';
  int ?realProdectId;

  bool isLiked = true;

  FavoriteScreen({this.realProdectId});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<FavoriteeModel>? lists;
  List<Favorites> ?listFavorite = <Favorites>[];
  List<int> list = [];

  @override
  Widget build(BuildContext context) {
    print(widget.realProdectId);

    return Scaffold(
      key: getIt<DetailsProductsProvider>().scaffoldKey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "المفضلة",
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.0.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 3),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Container(
                  width: double.infinity,
                  height: 80.0.h,
                  color: Color(0xffF6F6F7),
                  padding: EdgeInsets.only(right: 25, left: 25, top: 20),
                  child: FutureBuilder(
                    future: getFavoritePref(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Favorites>? list = snapshot.data as List<Favorites>?;
                        return StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            itemCount: list!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DetailsPreoductScreen.id,
                                      arguments: listFavorite![index].id);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(
                                              bottom: 5, right: 10),
                                          height: 20.0.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "${listFavorite![index].images}"),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  icon: Icon(
                                                      list.contains(
                                                          list[index].id)
                                                          ? Icons
                                                          .favorite_border
                                                          : Icons.favorite,
                                                      color: list.contains(
                                                          list[index].id)
                                                          ? Colors.black
                                                          : Colors.red),
                                                  onPressed: () async {
                                                    bool alreadySaved = false;
                                                    listFavorite
                                                    !.forEach((element) {
                                                      if (element.id ==
                                                          list[index].id) {
                                                        setState(() {
                                                          alreadySaved = true;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          alreadySaved = false;
                                                        });
                                                      }
                                                    });

                                                    if (alreadySaved) {
                                                      print('no');
                                                      list.remove(
                                                          list[index].id);
                                                      listFavorite!.removeWhere(
                                                              (item) =>
                                                          item.id ==
                                                              list[index].id);
                                                      await savePrefString(
                                                          'favorite',
                                                          json.encode(
                                                              listFavorite
                                                              ! .map((e) => e
                                                                  .toJson())
                                                                  .toList()));
                                                      getPrefString('favorite')
                                                          .then((value) =>
                                                          print(value));
                                                    }
                                                  }),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 1.5.h),
                                        ExpandableText(
                                          '${listFavorite![index].name}',
                                          expandText: ' ',textAlign: TextAlign.left,
                                          collapseText: 'show less',
                                          maxLines: 2,
                                          expanded: false,
                                          linkColor: Colors.blue,
                                          style: TextStyle(fontSize: 10.0.sp, color: kTextColor),
                                        ),
                                        SizedBox(height: 1.5.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                RatingBar.builder(
                                                  ignoreGestures: true,
                                                  itemSize: 10.0.sp,
                                                  initialRating: 1.0,
                                                  minRating: 1,
                                                  direction:
                                                  Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemBuilder:
                                                      (context, _) => Icon(
                                                    Icons.star,
                                                    color:
                                                    Color(0xffFFBF18),
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                SizedBox(width: 1.8.w),
                                                Text(
                                                  "${listFavorite![index].averageRating}",
                                                  style: TextStyle(
                                                    color:
                                                    Color(0xff777777),
                                                    fontSize: 10.0.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '\$\ ${listFavorite![index].price}',
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontSize: 11.0.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (index) {
                              return StaggeredTile.count(
                                  1, index.isEven ? 1.5 : 1.6);
                            });
                      }
                      return Container(
                          child: Center(
                              child: Text(
                                "قائمة المفضلة فارغة",
                                style: TextStyle(fontSize: 20.0.sp),
                              )));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Favorites>> getFavoritePref() async {
    String ss = await getPrefString('favorite');
    print('valueee =>$ss');
    listFavorite = FavoriteeModel.fromJson(json.decode(ss)).productsFavorite;
    return listFavorite!;
  }

}

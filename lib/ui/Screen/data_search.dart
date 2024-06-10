 
import 'package:ecommerce/api/all_searh_api.dart';
import 'package:ecommerce/get_it.dart';
import 'package:ecommerce/model/all_search_model.dart';
import 'package:ecommerce/ui/Screen/details_product_sreen.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Action for AppBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon Leading
    return IconButton(
      onPressed: () {
        //close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // result search
    return FutureBuilder(
      future: getIt<SearchForAllApi>().getProductsSearch(filter: query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AllSearchModel? model = snapshot.data as AllSearchModel?;
          return  StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              padding: EdgeInsets.all(10),
              itemCount: model!.productsSearch!.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, DetailsPreoductScreen.id,arguments: model.productsSearch![index].id);
                      },
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.bottomRight,
                            padding: EdgeInsets.only(bottom: 10, right: 10),
                            height: 15.0.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage("${model.productsSearch![index].images![0].src}"),
                              ),
                            ),

                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 2.5.w),
                                  Text('${model.productsSearch![index].name.toString()}',
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: Color(0xff7A8D9C),
                                        fontSize: 8.0.sp,
                                      )),
                                  SizedBox(height: 1.5.w),
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        ignoreGestures: true,
                                        itemSize: 10.0.sp,
                                        initialRating: model.productsSearch![index].ratingCount!.toDouble() == null ? 0.0 :   model.productsSearch![index].ratingCount!.toDouble(),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Color(0xffFFBF18),
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      SizedBox(width:1.8.w),
                                      Text("${ model.productsSearch![index].averageRating.toString()}",style:TextStyle(color: Color(0xff777777),  fontSize: 10.0.sp,),),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                '\$\ ${ model.productsSearch![index].price.toString()}',
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
                    1, index.isFinite ? 1.0 : 1.6);
              }
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}


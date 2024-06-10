  import 'package:ecommerce/get_it.dart';
import 'package:ecommerce/model/category_products_model.dart';
import 'package:ecommerce/providers/review_provider.dart';
import 'package:ecommerce/ui/widget/custom_button_widget.dart';
import 'package:ecommerce/ui/widget/custom_text_field.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'loading_widget.dart';
class FooterWidget extends StatefulWidget {
  CategoryProduct? id;
  FooterWidget({this.id});
  @override
  _FooterWidgetState createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      color: Colors.white,
      padding:EdgeInsets.only(right: 20),
      child: IconButton(
        color:  kPrimaryColor,
        icon: Icon(Icons.add_comment,size: 20.0.sp,),
        onPressed: (){
          _onbuttonpressedBuy(widget.id);
        },
      ),
    );
  }
  void _onbuttonpressedBuy(id) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(25),
              topRight: const Radius.circular(25),
            )),
        context: context,
        builder: (context) {
          return Consumer<ReviewProvider>(
            builder: (context, value, child) {
              if (value.reviewloading) {
                return LoadingWidget(color: kPrimaryColor);
              }
              return Container(
                color: Colors.transparent,
                height: 52.0.h,
                padding: EdgeInsets.only(left: 20, right: 20, top: 20,bottom: 10),
                child: Column(
                  children: [
                    Text('Add Reviews',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 2.0.h),
                    //  SizedBox(height: 25),
                    RatingBar.builder(
                      ignoreGestures: false,
                      itemSize: 19.0.sp,
                      initialRating: getIt<ReviewProvider>().rating == null ? 0.0 :getIt<ReviewProvider>().rating!.toDouble(),
                      minRating: 1,
                      updateOnDrag: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Color(0xffFFBF18),
                      ),
                      onRatingUpdate: (ratingss) {
                        getIt<ReviewProvider>().rating =ratingss.toInt();
                        print(ratingss);//  double.parse(rating.toStringAsFixed(2))
                      },
                    ),
                    SizedBox(height: 1.0.h),
                    CustomTextField(
                      keyboardType: TextInputType.name,
                      hintText: 'Name',
                      textEditingController: getIt<ReviewProvider>().nameReview,
                    ),
                    SizedBox(height: 0.2.h),
                    CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email..',
                      textEditingController:
                      getIt<ReviewProvider>().emailReview,
                    ),
                    SizedBox(height: 0.2.h),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      hintText: 'Add Comment',
                      textEditingController:
                      getIt<ReviewProvider>().addReviewController,
                    ),

                  Expanded(child: Container()),
                    CustomButtonWidget(
                        title: 'Send',
                        color: kPrimaryColor,
                        loading: value.reviewloading,
                        onClick: () async {
                          value.addReview();
                          print("ratinggg:${getIt<ReviewProvider>().rating}");
                        }),
                  ],
                ),
              );
            },
          );
        });
  }
}


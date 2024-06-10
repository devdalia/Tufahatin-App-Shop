import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'custom_text_widget.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:sizer/sizer.dart';


class CustomRadio extends StatelessWidget {
  final String? title;
  final Function?click;
  final String ?value;
  final String? selected;

  CustomRadio({this.title, this.click, this.value, this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>click,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          selected == value
              ? Container(
            width: 4.0.w,
            height: 4.0.w,
            padding: EdgeInsets.only(left: 5, right:5),
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(50),
              //  border: Border.all(color: kBlueColor)
            ),
          )
              : Container(
            width: 4.0.w,
            height: 4.0.w,
            padding: EdgeInsets.only(left:5, right: 5),
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: kPrimaryColor)),
          ),
          //   SizedBox(width: 2),
          Container(
            padding: EdgeInsets.only(left: 5, right:5),
            margin: EdgeInsets.only(top: 20),
            child: CustomTextWidget(
              title: title!,
              fontWeight: FontWeight.bold ,
              size: 12.0.sp,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}


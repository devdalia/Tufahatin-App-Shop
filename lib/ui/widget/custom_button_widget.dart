import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class CustomButtonWidget extends StatelessWidget {
  final String? title;
  final VoidCallback? onClick;
  final bool ?loading;
  final Color ?color;

  CustomButtonWidget({this.title, this.onClick, this.loading, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.0.h,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.symmetric(horizontal: 30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: onClick,
        child: loading != null && loading == true
            ? CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)
            : Text(
          title!,
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14.0.sp),
        ),
      ),
    );
  }
}
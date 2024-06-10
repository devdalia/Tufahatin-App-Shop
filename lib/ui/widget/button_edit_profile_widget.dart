import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ButtonEditProfileWidget extends StatelessWidget {
  final String? title;
  final VoidCallback? onClick;
  final bool? loading;
  final Color? color;

  ButtonEditProfileWidget({this.title, this.onClick, this.loading, this.color});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 4.5.h,
        width: 30.0.w,
        child: ElevatedButton(
          //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          style: ElevatedButton.styleFrom(
            primary: color,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: onClick,
          child: loading != null && loading == true
              ? CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.pencil_outline,
                color: Colors.white,
                size: 13.0.sp,
              ),
              SizedBox(width: 8),
              Text(
                title!,
                style: TextStyle(color: Colors.white, fontSize: 11.0.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


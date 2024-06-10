import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String ?title;
  final Color? color;
  final double ?size;
  final double ?paddingLeft;
  final double? paddingRight;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  CustomTextWidget(
      {this.title,
        this.color,
        this.size,
        this.fontWeight,
        this.paddingLeft,
        this.paddingRight,
        this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(
      //     left: paddingLeft == null ? 25 : paddingLeft,
      //     right: paddingRight == null ? 25 : paddingRight),
      child: Text(
        title!,
        textAlign: textAlign ?? null,
        style: TextStyle(
          color: Color(0xffACBAC3),
          fontWeight: fontWeight ?? null,
          fontSize: size,
        ),
      ),
    );
  }
}

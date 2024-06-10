import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class EditTextFieldWidget extends StatelessWidget {
  final bool ?withIcon;
  final String? hint;
  final String? icon;
  final TextEditingController ?textEditingController;

  EditTextFieldWidget(
      {this.withIcon = false,
        this.hint,
        this.icon,
        this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 12.0.sp),
          prefixIcon: withIcon == true
              ? Container(
            width: 15,
            child: Align(
              alignment: Alignment.center,
              child: ImageIcon(
                AssetImage(icon!),
                size: 15.0.sp,
                color: kPrimaryColor,
              ),
            ),
          )
              : null),
      cursorColor: kPrimaryColor,
    );
  }
}


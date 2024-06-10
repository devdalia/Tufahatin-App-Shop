import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';


class CustomTextField extends StatefulWidget {
  TextEditingController? textEditingController;
  String ?hintText;
  IconData ?prefixIcon;
  TextInputType ?keyboardType;
  bool ?password;
  //Function value;
  Function ?onsaved;

  CustomTextField(
      {this.textEditingController,
        this.hintText,
        this.prefixIcon,
        this.keyboardType,
        this.onsaved,
        this.password});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.0.h,
      alignment: Alignment.centerLeft,

      margin: EdgeInsets.only(top: 10, right:10, left:10),
      child: new TextFormField(

        inputFormatters: [
          widget.keyboardType == TextInputType.phone ? LengthLimitingTextInputFormatter(10) : LengthLimitingTextInputFormatter(50)
        ],
        controller: widget.textEditingController,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.zero,
          suffixIcon: widget.password == true
              ? GestureDetector(
              onTap: _toggle, child: Icon(Icons.visibility_off))
              : null,
          hintText: widget.hintText,
          prefixIcon: Icon(widget.prefixIcon),
          hintStyle:  new TextStyle(fontSize: 12,color:kColorfont),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color:kColorfont),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color:kPrimaryColor),
          ),
        ),
        showCursor: true,
        // validator: widget.value,
        onSaved:(newValue) =>widget.onsaved ,
        keyboardType: widget.keyboardType,
        obscureText: widget.password == true ? _obscureText : false,

      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}


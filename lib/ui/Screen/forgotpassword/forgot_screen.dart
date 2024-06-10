import 'package:ecommerce/providers/verification_code_provider.dart';
import 'package:ecommerce/ui/Screen/forgotpassword/new_password_screen.dart';

import 'package:ecommerce/ui/widget/custom_button_widget.dart';
import 'package:ecommerce/ui/widget/otp_field.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../get_it.dart';

class ForgetpasswordScreen extends StatefulWidget {
  static const String id = 'ForgetpasswordScreen';

  @override
  _ForgetpasswordScreenState createState() => _ForgetpasswordScreenState();
}

class _ForgetpasswordScreenState extends State<ForgetpasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getIt<VerificationCodeProvider>().otpScreenScaffoldKey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        toolbarHeight: 5.0.h,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 0),
          child: IconButton(
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: Colors.white,
              size: 18.0.sp,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 12.0.h,
                padding:
                    EdgeInsets.only(right: 15, left: 10, top: 20, bottom: 5),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: const Radius.circular(35),
                    bottomLeft: const Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 15),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'التحقق من الرمز',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2.0.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0.h),
              SizedBox(height: 5.0.h),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Align(
                    alignment: Alignment.center,
                    child: OTPTextField(
                      length: 4,
                      width: 200,
                      onChanged: (value) {
                        print(value);
                        getIt<VerificationCodeProvider>().code = value;
                      },
                    )),
              ),
              SizedBox(height: 1.0.h),
              SizedBox(height: 6.0.h),
              Text('تم إرسال رمز الى البريد الإلكتروني الخاص بك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff7A8D9C),
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp)),
              SizedBox(height: 7.0.h),
              Container(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'ستنتهي صلاحية هذا الرمز بعد',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(text: ' '),
                  TextSpan(text: ' '),
                  TextSpan(
                      text: '5 دقائق', style: TextStyle(color: kPrimaryColor)),
                ])),
              ),
              SizedBox(height: 3.0.h),
              Container(
                height: 8.0.h,
                width: double.infinity,
                padding: EdgeInsets.only(right: 15, left: 15),
                margin: EdgeInsets.symmetric(horizontal: 25),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  title: Text('التحقق من كود',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.pushNamed(context, NewPasswordScreen.id);
                  },
                ),
              ),
              SizedBox(height: 3.0.h),
              Consumer<VerificationCodeProvider>(
                builder: (context, value, child) {
                  return CustomButtonWidget(
                    title: ('أعد إرسال الرمز'),
                    loading: value.verifyEmailLoading,
                    onClick: () {
                      value.verifyEmail();
                    },
                    color: kSecondaryColor,
                  );
                },
              ),
              SizedBox(height: 5.0.h),
            ],
          ),
        ),
      ),
    );
  }
}

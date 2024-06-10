import 'package:ecommerce/providers/register_provider.dart';

import 'package:ecommerce/ui/Screen/login_screen.dart';
import 'package:ecommerce/ui/widget/custom_button_widget.dart';
import 'package:ecommerce/ui/widget/custom_text_field.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../get_it.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "RegisterScreen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

enum AuthMode { SignUp, Login }

class _RegisterScreenState extends State<RegisterScreen> {
  Map<String, String> _authData = {
    'password': ' ',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getIt<RegisterProvider>().rescaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //SizedBox(height:5.0.h),
              Container(
                height: 40.0.h,
                width: 60.0.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage(
                      'assets/images/logoo.png',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.0.h),
              buildForm(),
              SizedBox(height: 5.0.h),
              buildContainerButton1(context),
              SizedBox(height: 3.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(' هل لديك حساب',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kTextLightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0.sp)),
                  Text('  /  ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff7A8D9C),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0.sp)),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      ' سجل دخول',
                      style: TextStyle(
                          color: kBlueColor,
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainerButton1(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, value, child) {
        return CustomButtonWidget(
          title: ('انشاء حساب'),
          color: kPrimaryColor,
          loading: value.registerLoading,
          onClick: () {
            value.register();
          },
        );
      },
    );
  }

  Form buildForm() {
    return Form(
      child: Column(
        children: [
          CustomTextField(
            keyboardType: TextInputType.emailAddress,
            hintText: 'ادخل اسمك',
            textEditingController:
                getIt<RegisterProvider>().registerNameController,
          ),
          CustomTextField(
            keyboardType: TextInputType.emailAddress,
            hintText: 'ادخل الايميل',
            textEditingController:
                getIt<RegisterProvider>().registerEmailController,
          ),
          CustomTextField(
            keyboardType: TextInputType.visiblePassword,
            hintText: 'كلمة السر',
            password: true,
            textEditingController:
                getIt<RegisterProvider>().registerPasswordController,
            onsaved: (val) {
              _authData['password'] = val;
              print(_authData['password']);
            },
          ),
          CustomTextField(
            keyboardType: TextInputType.visiblePassword,
            hintText: 'تاكيد كلمة السر',
            password: true,
            textEditingController:
                getIt<RegisterProvider>().registerConfirmPassword,
          ),
        ],
      ),
    );
  }
}

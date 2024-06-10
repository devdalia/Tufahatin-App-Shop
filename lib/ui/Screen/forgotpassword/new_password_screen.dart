import 'package:ecommerce/providers/verification_code_provider.dart';

import 'package:ecommerce/ui/widget/custom_button_widget.dart';
import 'package:ecommerce/ui/widget/custom_text_field.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../get_it.dart';

class NewPasswordScreen extends StatefulWidget {
  static const String id = 'NewPasswordScreen';

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController _passwordController = TextEditingController();

  Map<String, String> _authData = {
    'password': ' ',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getIt<VerificationCodeProvider>().newPasswordScaffoldKey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        toolbarHeight: 5.0.h,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 12.0.h,
              padding: EdgeInsets.only(right: 15, left: 10, top: 20, bottom: 5),
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
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'كلمة سر جديدة',
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
            SizedBox(height: 8.0.h),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'كلمة السر',
                    password: true,
                    textEditingController:
                        getIt<VerificationCodeProvider>().newPasswordController,
                  ),
                ],
              ),
            ),
            Spacer(),
            Consumer<VerificationCodeProvider>(
              builder: (context, value, child) => CustomButtonWidget(
                title: ('استمر'),
                loading: value.resendLoading,
                onClick: () {
                  value.resendPassword();
                },
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: 2.0.h),
          ],
        ),
      ),
    );
  }
}

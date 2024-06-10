import 'package:ecommerce/providers/verification_code_provider.dart';
import 'package:ecommerce/ui/widget/custom_button_widget.dart';
import 'package:ecommerce/ui/widget/custom_text_field.dart';
import 'package:ecommerce/ui/widget/custom_text_widget.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../get_it.dart';

class RestPassword extends StatelessWidget {
  static const String id = 'RestPassword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getIt<VerificationCodeProvider>().newPasswordScaffoldKey,
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 120),
        children: [
          // Image.asset('assets/images/rest_password.png', height: 30.0.h),
          SizedBox(height: 60),
          CustomTextWidget(
              title: ('إعادة تعيين كلمة المرور'),
              size: 14.0.sp,
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center),
          SizedBox(height: 30),
          CustomTextField(
            textEditingController:
                getIt<VerificationCodeProvider>().oldPasswordController,
            hintText: ('كلمة السر'),
            prefixIcon: CupertinoIcons.lock,
            keyboardType: TextInputType.text,
            password: true,
          ),
          CustomTextField(
            textEditingController: getIt<VerificationCodeProvider>().confirmNewPassController,
            hintText: ('تعديل كلمة السر'),
            prefixIcon: CupertinoIcons.lock,
            keyboardType: TextInputType.text,
            password: true,
          ),
          SizedBox(height: 12.0.h),
          Consumer<VerificationCodeProvider>(
            builder: (context, value, child) => CustomButtonWidget(
              title: ('استمر'),
              loading: value.resendPasswordLoading,
              onClick: () {
                value.changePassword(); 
              },
              color: kPrimaryColor,
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

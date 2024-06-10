import 'package:cool_alert/cool_alert.dart';
import 'package:ecommerce/providers/verification_code_provider.dart';
import 'package:ecommerce/ui/Screen/forgotpassword/forgot_screen.dart';
import 'package:ecommerce/ui/Screen/registers_screen.dart';
import 'package:ecommerce/ui/widget/custom_button_widget.dart';
import 'package:ecommerce/ui/widget/custom_text_field.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../get_it.dart';

class EnterEmailScreen extends StatefulWidget {
  static const String id = 'EnterEmailScreen';

  @override
  _EnterEmailScreenState createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getIt<VerificationCodeProvider>().forgotPasswordScaffoldKey,
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
              Navigator.pop(context, RegisterScreen.id);
            },
          ),
        ),
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
                    padding: EdgeInsets.only(right: 15),
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'نسيت كلمة السر',
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
            SizedBox(height: 4.0.h),
            CustomTextField(
              keyboardType: TextInputType.emailAddress,
              hintText: 'ادخل الايميل الخاص بك',
              textEditingController:
                  getIt<VerificationCodeProvider>().emailController,
            ),
            Spacer(),
            Consumer<VerificationCodeProvider>(
              builder: (context, value, child) {
                return CustomButtonWidget(
                  title: ('حفظ  البريد الإلكتروني'),
                  loading: value.verifyEmailLoading,
                  onClick: () {
                    value.verifyEmail();
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.success,
                      animType: CoolAlertAnimType.slideInUp,
                      title: "تم إرسال رمز الى البريد الإلكتروني الخاص بك",

                      //backgroundColor: kPrimaryColor,
                      //   flareAsset: "dalia",
                      confirmBtnColor: kBlueColor,
                      showCancelBtn: false,
                      onConfirmBtnTap: () {
                        Navigator.pushNamed(context, ForgetpasswordScreen.id);
                      },
                    );
                  },
                  color: kPrimaryColor,
                );
              },
            ),
            SizedBox(height: 2.0.h),
          ],
        ),
      ),
    );
  }
}

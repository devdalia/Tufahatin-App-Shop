import 'package:ecommerce/api/change_password_api.dart';
import 'package:ecommerce/api/resend_verification_code_api.dart';
import 'package:ecommerce/api/verify_email_api.dart';
import 'package:ecommerce/helpers/internet_helper.dart';
import 'package:ecommerce/model/resend_password_model.dart';
import 'package:ecommerce/ui/Screen/login_screen.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/custom_dialog.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';
import 'profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../get_it.dart';

class VerificationCodeProvider with ChangeNotifier {
  ResendPasswordModel? _resendPasswordModel;

  ResendPasswordModel? get resendPasswordModel => _resendPasswordModel;

  GlobalKey<ScaffoldState> ?otpScreenScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> forgotPasswordScaffoldKey =
      GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> newPasswordScaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController confirmNewPassController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  String code = '';

  bool loading = false;
  bool verifyRemember = false;
  bool ?verificationCode;
  bool verificationLoading = false;
  bool verifyEmailLoading = false;
  bool resendLoading = false;
  bool resendPasswordLoading = false;

  void changePassword() async {
    bool connectInternet = await isInternet;
    if (connectInternet) {
      resendPasswordLoading = true;
      print('start changePassword');
      notifyListeners();
      String token = await getPrefString(token_pref);
      String id = await getPrefString(id_pref);
      getIt<ChangePasswordApi>().changePasswordApi(data: {
        'user_id': '$id',
        'token': '$token',
        'old_password': oldPasswordController.text,
        'new_password': confirmNewPassController.text,
      }).then((value) async {
        if (value != null) {
          resendPasswordLoading = false;
          notifyListeners();
          await savePrefString(token_pref, value.data!.token!);
          Navigator.pop(getIt<ProfileProvider>().profile!.currentContext!);
          print('finish changePassword');
        } else {
          errorDialog(
              message: 'Error', context: otpScreenScaffoldKey!.currentContext!);
          resendPasswordLoading = false;
          notifyListeners();
        }
      });
    } else {
      errorDialog(
          message: ('There_no_internet_connection'),
          context: otpScreenScaffoldKey!.currentContext!);
    }
  }

  void verifyEmail() async {
    bool connectInternet = await isInternet;
    if (connectInternet) {
      verifyEmailLoading = true;
      print('start send code');
      notifyListeners();
      getIt<VerifyEmailApi>().verifyRememberApi(
          data: {'email': '${emailController.text}'}).then((value) async {
        if (value == true) {
          verifyEmailLoading = false;
          notifyListeners();

          print('finish changePassword');
        } else {
          errorDialog(
              message: 'Error',
              context: forgotPasswordScaffoldKey.currentContext!);
          verifyEmailLoading = false;
          notifyListeners();
        }
      });
    } else {
      errorDialog(
          message: ('There_no_internet_connection'),
          context: forgotPasswordScaffoldKey.currentContext!);
    }
  }

  void resendPassword() async {
    String id = await getPrefString(id_pref);
    bool connectInternet = await isInternet;
    if (connectInternet) {
      if (code == '') {
        errorDialog(
            message: ('Please_enter_verification_code'),
            context: otpScreenScaffoldKey!.currentContext!);
      }
      resendLoading = true;
      print('start new password');
      notifyListeners();
      getIt<ResendVerificationCodeApi>().resendVerificationCodeApi(data: {
        "user_id": "${id}",
        'verification_code': code,
        'new_password': newPasswordController.text,
      }).then((value) async {
        if (value == true) {
          resendLoading = false;
          verificationCode = value;
          notifyListeners();
          Navigator.pushNamedAndRemoveUntil(otpScreenScaffoldKey!.currentContext!, LoginScreen.id, (route) => false);
          print('finish verification');
        } else {
          errorDialog(
              message: 'verification_code_invalid',
              context: newPasswordScaffoldKey.currentContext!);
          resendLoading = false;
          notifyListeners();
        }
      });
    } else {
      errorDialog(
          message: ('There_no_internet_connection'),
          context: newPasswordScaffoldKey.currentContext!);
    }
  }
}

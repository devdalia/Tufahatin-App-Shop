import 'package:ecommerce/api/login_api.dart';
import 'package:ecommerce/api/register_api.dart';
import 'package:ecommerce/helpers/internet_helper.dart';
import 'package:ecommerce/model/login_model.dart';
import 'package:ecommerce/model/register_model.dart';
import 'package:ecommerce/ui/Screen/home_application.dart';
import 'package:ecommerce/ui/Screen/login_screen.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/custom_dialog.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../get_it.dart';

class RegisterProvider with ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> rescaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> resetPasswordScaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController = TextEditingController();
  final TextEditingController registerConfirmPassword = TextEditingController();
  final TextEditingController emailForgotController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
//  final TextEditingController confirmNewPasswordController = TextEditingController();

  LoginModel ?_loginModel;
  RegisterModel? _registerModel;

  RegisterModel ?get registerModel => _registerModel;

  LoginModel? get loginModel => _loginModel;

  bool selectTerms = true;

  //Loading
  bool logInLoading = false;
  bool registerLoading = false;
  bool forgotLoading = false;
  bool resetLoading = false;

  void login() async {
    bool connectInternet = await isInternet;
    if (connectInternet) {
      if (emailController.text.isEmpty) {
        errorDialog(
            message:('email_required'),
            context: scaffoldKey.currentContext!);
      } else if (passwordController.text.isEmpty) {
        errorDialog(
            message: ('password_number_required'),
            context: scaffoldKey.currentContext!);
      } else {
        logInLoading = true;
        print('start login');
        notifyListeners();
        getIt<LoginApi>().login(data: {
          'email': emailController.text,
          'password': passwordController.text,
        }).then((value) async {
          if (value != null) {
            logInLoading = false;
            notifyListeners();
            if(value.status == false){
              errorDialog(
                  message: value.message, context: scaffoldKey.currentContext!);
            }
            // else if(value.data.email!=emailController){
            //   errorDialog(
            //       message:  "تحقق مرة أخرى أو حاول عنوان بريدك الإلكتروني", context: scaffoldKey.currentContext);
            //
            // }

            else{

              _loginModel = value;
              await savePrefString(token_pref, value.data!.token!);
              await savePrefString(id_pref, value.data!.id.toString());
            //  await savePrefString(cookie_pref, value.data.cookie);

              Navigator.pushNamedAndRemoveUntil(
                  scaffoldKey.currentContext!, HomeApplication.id, (route) => false);
              print('finish login');
              notifyListeners();
            }
          } else {
            errorDialog(
                message: value.message!, context: scaffoldKey.currentContext!);
            logInLoading = false;
            notifyListeners();
          }
        });
      }
    } else {
      errorDialog(
          message:( 'There_no_internet_connection'),
          context: scaffoldKey.currentContext!);
    }
  }

  void register() async {
    bool connectInternet = await isInternet;
    if (connectInternet) {
      if (registerEmailController.text.isEmpty) {
        errorDialog(
            message: ('Please_enter_all_data'),
            context: rescaffoldKey.currentContext!);
      } else if (registerNameController.text.isEmpty) {
        errorDialog(
            message:( 'Please_enter_all_data'),
            context: rescaffoldKey.currentContext!);
      } else if (registerPasswordController.text.isEmpty) {
        errorDialog(
            message:( 'Please_enter_all_data'),
            context: rescaffoldKey.currentContext!);
      }   else {
        registerLoading = true;
        print('start registerLoading');
        notifyListeners();
        getIt<RegisterApi>().registerApi(data: {
          'name': registerNameController.text,
          'email': registerEmailController.text,
          'password': registerPasswordController.text,
         // 're_password': registerConfirmPassword.text,
        //  'is_agreed_to_conditions': selectTerms ? '1' : '0'
        })
        .then((value) async {
          if (value.status == true) {
            registerLoading = false;
            _registerModel = value;
            Navigator.pushNamed(rescaffoldKey.currentContext!, LoginScreen.id,
                arguments: [
                  value.data!.email.toString(),
               // value.data.manager.verficationCode.toString(),
                  'register',
                ]);
            print('finish registerLoading');
            notifyListeners();
          } else {
            errorDialog(
                message: value.message!, context: rescaffoldKey.currentContext!);
            registerLoading = false;
            notifyListeners();
          }
        });
      }
    } else {
      errorDialog(
          message:  'There_no_internet_connection',
          context: rescaffoldKey.currentContext!);
    }
  }
}
 import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/api/ProfileApi.dart';
import 'package:ecommerce/api/profileEditApi.dart';
import 'package:ecommerce/get_it.dart';
import 'package:ecommerce/helpers/internet_helper.dart';
import 'package:ecommerce/model/profile_model.dart';
import 'package:ecommerce/utilities/custom_dialog.dart';

class ProfileProvider extends ChangeNotifier{

  GlobalKey<ScaffoldState> ?profile = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> ?editprofilekey = GlobalKey<ScaffoldState>();


  File? profileImage;
  TextEditingController editname = TextEditingController();
  TextEditingController editemail = TextEditingController();

  bool editprofileloading = false;
  bool error = false;
  bool noInternet = false;

  ProfileModel ?_profileModel;
  ProfileModel ?get profileModel => _profileModel;



  void getProfiledata() async {
    editprofileloading = true;
    bool isinternet = await isInternet;
    if (isinternet) {
      print('start getting');
      getIt<ProfileApi>().getProfileData().then((value) {
        if (value != null) {
          error = false;
          noInternet = false;
          editprofileloading = false;
          notifyListeners();
          _profileModel = value;
          print('done getting');
        } else {
          error = true;
          noInternet = false;
          editprofileloading = false;
          notifyListeners();
        }
      });
    } else {
      errorDialog(
          message:  ('There_no_internet_connection'),
          context: profile!.currentContext!);
    }
  }


  void editProfile() async {
    String id = await getPrefString(id_pref);
    String token = await getPrefString(token_pref);
    FormData data;

    if(profileImage == null){
      data = FormData.fromMap({
        "user_id":"${id}",
      "token": "$token",
      "new_name":"${editname.text}"
      });
    }else{
      // List<int> imageBytes = profileImage.readAsBytesSync();
      // String base64Image = base64Encode(imageBytes);
      // print(base64Image);
      final bytes = File(profileImage!.path).readAsBytesSync();

      String img64 = base64Encode(bytes);
      log('image => $img64');
      data = FormData.fromMap({
        "user_id":"${id}",
      "token": "$token",
        "new_name":"${editname.text}",
       "image_profile":img64,
      });
    }
    bool isinternet = await isInternet;
    if (isinternet) {
      editprofileloading = true;
      getIt<ProfileEditApi>().editprofile(data: data).then((value) {
        if (value != null) {
          editprofileloading = false;
          getProfiledata();
          notifyListeners();
          successfulDialog(
            message: 'edit Done',
            context: editprofilekey!.currentContext!,
            functionOk: () => Navigator.pop(editprofilekey!.currentContext!),
          );
        } else {
          editprofileloading = false;
          print('error');
          notifyListeners();
          errorDialog(
              message: (
                  'There_no_internet_connection'),
              context: editprofilekey!.currentContext!);
        }
      });
    } else {
      errorDialog(
          message:  (  'There_no_internet_connection'),
          context: editprofilekey!.currentContext!);
    }
  }
}
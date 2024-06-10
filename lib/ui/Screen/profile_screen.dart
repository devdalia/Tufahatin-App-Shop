import 'dart:developer';

import 'package:ecommerce/providers/profile_provider.dart';
import 'package:ecommerce/ui/Screen/home_application.dart';
import 'package:ecommerce/ui/Screen/login_screen.dart';
import 'package:ecommerce/ui/widget/button_edit_profile_widget.dart';
import 'package:ecommerce/ui/widget/custom_text_widget.dart';
import 'package:ecommerce/ui/widget/image_profile_widget.dart';
import 'package:ecommerce/ui/widget/loading_widget.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:ecommerce/utilities/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../get_it.dart';
import 'location_screen.dart';
import 'edit_profile_screen.dart';
import 'favorite_screen.dart';
import 'mycart_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = "ProfileScreen";
  int ?idprofile;

  ProfileScreen({  this.idprofile});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String ?token;

  void initState() {
    getIt<ProfileProvider>().getProfiledata();
    getToken();
    super.initState();
  }
  bool shouldPop = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        key: getIt<ProfileProvider>().profile,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 25, left: 25),
                  child: Column(
                    children: [
                      if (token != '')
                        Consumer<ProfileProvider>(
                          builder: (context, value, child) {
                            if (value.editprofileloading) {
                              return LoadingWidget(color: kPrimaryColor);
                            }
                            return Column(
                              children: [
                                SizedBox(height: 1.0.h),
                                ImageProfileWidget(editImage: false),
                                SizedBox(height: 2.0.h),
                                CustomTextWidget(
                                    title:
                                        '${value.profileModel!.data!.displayName}',
                                    size: 14.0.sp,
                                    color: kPrimaryColor),
                                CustomTextWidget(
                                    title: '${value.profileModel!.data!.email}',
                                    size: 13.0.sp,
                                    color: kPrimaryColor),
                                SizedBox(height: 1.0.h),
                                ButtonEditProfileWidget(
                                    title: 'تعديل',
                                    color: kPrimaryColor,
                                    onClick: () {
                                      Navigator.pushNamed(
                                          context, EditProfileScreen.id);
                                    }),
                                SizedBox(height: 3.0.h),
                              ],
                            );
                          },
                        ),
                      if (token == '')
                        Container(
                          padding: EdgeInsets.only(top: 60),
                        ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, locationScreen.id);
                        },
                        child: buildContainerpro(
                            "موقعي", "assets/images/Location_Icon.png"),
                      ),
                      SizedBox(height: 2.5.h),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, MyCartScreen.id);
                        },
                        child: buildContainerpro(
                            "السلة", "assets/images/icon_cart.png"),
                      ),
                      SizedBox(height: 2.5.h),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, FavoriteScreen.id);
                        },
                        child: buildContainerpro(
                            "المفضلة", "assets/images/Love_Icon 3_2.png"),
                      ),
                      /*   SizedBox(height: 2.5.h),
                      InkWell(
                          onTap: (){
                            Navigator.pop(context, PaymentScreen.id);
                          },
                          child: buildContainerpro("Payment", "assets/images/Card_icon.png")),*/
                      SizedBox(height: 2.5.h),
                      InkWell(
                          onTap: () async {
                            await savePrefString(token_pref, '');
                            Navigator.pushNamedAndRemoveUntil(
                                context, LoginScreen.id, (route) => false);
                          },
                          child: buildContainerpro(
                              "تسجيل خروج", "assets/images/logout.png")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildContainerpro(String name, String img) {
    return Container(
      padding: EdgeInsets.only(right: 40, left: 10),
      alignment: Alignment.center,
      width: double.infinity,
      height: 9.0.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(.2)),
          ]),
      child: ListTile(
        title: Text('$name',
            style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 12.0.sp)),
        leading: ImageIcon(
          AssetImage("$img"),
          size: 18.0.sp,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  void getToken() async {
    String accessToken = await getPrefString('token');
    setState(() {
      token = accessToken;
      log('token => ${accessToken}');
    });
  }
}

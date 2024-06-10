import 'dart:io';

import 'package:ecommerce/providers/profile_provider.dart';
import 'package:ecommerce/ui/Screen/rest_password.dart';
import 'package:ecommerce/ui/widget/custom_button_widget.dart';
import 'package:ecommerce/ui/widget/edit_text_field_widget.dart';
import 'package:ecommerce/ui/widget/image_profile_widget.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../get_it.dart';

class EditProfileScreen extends StatefulWidget {
  static const String id = 'EditProfileScreen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}


class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getIt<ProfileProvider>().editprofilekey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'تعديل الملف الشخصي',
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight,
                  maxHeight: double.infinity,
                ), //arguments: value.profileModel.data.user
                child: IntrinsicHeight(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Consumer<ProfileProvider>(
                      builder: (context, value, child) {
                        return Column(
                          children: <Widget>[
                            SizedBox(height: 3.0.h),
                            ImageProfileWidget(
                              editImage: true,
                            ),
                            SizedBox(height: 5.0.h),
                            EditTextFieldWidget(
                                textEditingController:
                                getIt<ProfileProvider>().editname,
                                hint: "${value.profileModel!.data!.displayName}",
                                withIcon: true,
                                icon: 'assets/images/icon_person.png'),
                            SizedBox(height: 5.0.h),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, RestPassword.id);
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'تغير كلمة السر؟',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0.sp,
                                      color: kPrimaryColor),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Consumer<ProfileProvider>(
                                  builder: (ctx, val, child) => CustomButtonWidget(
                                      title: 'حفظ',
                                      color: kPrimaryColor,
                                      loading: val.editprofileloading,
                                      onClick: () async {
                                        val.editProfile();
                                        print(
                                            "edit profile your : ${value.profileModel!.data!.displayName}");
                                      }),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future addPhoto(ImageSource src) async {
    final ss = await ImagePicker.platform.pickImage(source: src, imageQuality: 65);
    if (ss != null) {
      getIt<ProfileProvider>().profileImage = File(ss.path);
    } else {}
  }
}


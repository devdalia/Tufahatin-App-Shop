import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ecommerce/providers/profile_provider.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../get_it.dart';
import 'custom_button_widget.dart';

class ImageProfileWidget extends StatefulWidget {
  final bool ?editImage;

  ImageProfileWidget({this.editImage});

  @override
  _ImageProfileWidgetState createState() => _ImageProfileWidgetState();
}

class _ImageProfileWidgetState extends State<ImageProfileWidget> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 70.0.sp,
        width: 70.0.sp,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Consumer<ProfileProvider>(
              builder: (context, value, child) {
                return Container(
                  height: 70.0.sp,
                  width: 70.0.sp,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: imageFile != null
                          ? Image.file(imageFile!, fit: BoxFit.cover)
                          : Image.network(
                        value.profileModel!.data!.userImage ??
                            'https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg',
                        fit: BoxFit.cover,
                      )),
                );
              },
            ),
            widget.editImage == true
                ? Positioned(
              left: 8,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Change Your Photo',style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.0.h,
                            ),
                            CustomButtonWidget(
                              title: 'choose from gllary',
                              color: kPrimaryColor,
                              onClick: () async =>
                                  addPhoto(ImageSource.gallery),
                            ),
                            SizedBox(
                              height: 2.0.h,
                            ),
                            CustomButtonWidget(
                              title: 'TakePhoto  ',
                              color: kPrimaryColor,
                              onClick: () async =>
                                  addPhoto(ImageSource.camera),
                            )
                          ],
                        ),
                      ));
                },
                child: Positioned(
                    left: 10,
                    bottom: 0,
                    child: Container(
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 15.0.sp,
                        ))),
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }

  Future addPhoto(ImageSource src) async {
    ImagePicker.platform.pickImage(source: src, imageQuality: 65).then((value) {
      if (value != null) {
        setState(() {
          imageFile = value as File;
          getIt<ProfileProvider>().profileImage = File(value.path);
        });
        Navigator.pop(context);
      }
    });
  }
}

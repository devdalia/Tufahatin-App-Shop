import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void successfulDialog(
    {String? message,
      BuildContext? context,
      Function ?functionOk,
      Function? functionCancel,
      String? btnOkText,
      String? btnCancelText,
      bool ?dismiss}) {
  AwesomeDialog(
      context: context!,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Message',
      desc: message,
      dismissOnTouchOutside: dismiss ?? true,
      btnOkOnPress: functionOk,
      btnOkText: btnOkText,
      btnCancelText: btnCancelText,
      btnCancelOnPress: functionCancel)
      .show();
}

void errorDialog({String ?message, BuildContext ?context, Function ?functionOk}) {
  AwesomeDialog(
      context: context!,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Message',
      desc: message,
      btnOkOnPress: functionOk)
      .show();
}
Future confirmDialog({String ?message, BuildContext ?context, Function? functionOk}) {
  return AwesomeDialog(
      context: context!,
      dialogType: DialogType.QUESTION,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Message',
      desc: message,
      btnOkOnPress: functionOk)
      .show();
}


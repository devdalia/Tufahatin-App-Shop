import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;

  LoadingWidget({this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(color!),
    ));
  }
}

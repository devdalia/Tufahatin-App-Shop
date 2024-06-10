import 'package:flutter/material.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:sizer/sizer.dart';
class TabBarDetailsWidget extends StatelessWidget {
  final Function ?onChange;

  TabBarDetailsWidget({this.onChange});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: TabBar(
        indicatorColor: kPrimaryColor,
        unselectedLabelColor:kColorfont2,
        labelColor: kPrimaryColor,
        onTap: (value) => onChange,
        tabs: [
          Tab(
            child: Text('التفاصيل' ,
              style: TextStyle(fontSize: 13.0.sp),
            ),
          ),

          Tab(
            child: Text(
              'التقيمات',
              style: TextStyle(fontSize: 13.0.sp),
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:ecommerce/providers/add_cart_provider.dart';
import 'package:ecommerce/ui/Screen/profile_screen.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ecommerce/providers/home_provider.dart';
import 'package:ecommerce/providers/profile_provider.dart';
import 'home_screen.dart';
import 'information_screen.dart';
import '../../get_it.dart';
import 'package:sizer/sizer.dart';
class HomeApplication extends StatefulWidget {
  static const String id = "HomeApplication";
  final String ?currentUserId;

  const HomeApplication({Key? key, this.currentUserId}) : super(key: key);

  @override
  _HomeApplicationState createState() => _HomeApplicationState();
}

class _HomeApplicationState extends State<HomeApplication>
    with SingleTickerProviderStateMixin {
  TabController ?_tabController;
  int _currentIndex = 0;

  List<Widget> _buildScreens = [
    HomeScreen(),
    InformationScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getIt<HomeProvider>().getCategories();
    getIt<HomeProvider>().getDiscount();
    getIt<AddCartProvider>().getCart();
    //  getIt<ReviewProvider>().getReviewdata();
    getIt<ProfileProvider>().getProfiledata();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
          child: TabBar(
            labelColor: kPrimaryColor,
            unselectedLabelColor: kBlueColor,
            indicatorColor: kPrimaryColor,
            onTap: onTabTapped,
            tabs: <Widget>[
              Tab(
                icon: ImageIcon(AssetImage("assets/images/Home_button.png"),size: 20.0.sp),
              ),
              Tab(
                icon: ImageIcon(
                    AssetImage("assets/images/cattt.png"),size: 20.0.sp),
              ),
              Tab(
                icon: ImageIcon(AssetImage("assets/images/Profil_Icon.png"),size: 20.0.sp),
              ),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

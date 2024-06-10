import 'package:ecommerce/model/location_model.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ecommerce/providers/location_provider.dart';
import 'package:provider/provider.dart';
import 'add_location_screen.dart';
import 'package:ecommerce/get_it.dart';


class locationScreen extends StatefulWidget {
  static const String id = "locationScreen";

  @override
  _locationScreenState createState() => _locationScreenState();
}

class _locationScreenState extends State<locationScreen> {

  @override
  void initState() {
    getIt<LocationProvider>().getLocations();

    super.initState();
  }

  List<LocationModel> list=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Container(
          alignment: Alignment.centerRight,
          child:    Text(
            "موقعي",

            style: TextStyle(
                color: Colors.white,
                fontSize: 15.0.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: Colors.white,
            size: 18.0.sp,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),

            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AddLocationScreen.id);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: ListTile(
                      leading: Icon(
                        Icons.add_location_alt_outlined,
                        color: kPrimaryColor,
                        size: 18.0.sp,
                      ),
                      title: Text("اضافة موقع",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15.0.sp,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(height:2.0.h),
                Consumer<LocationProvider>(
                  builder: (context, value, child) {
                    // if(value.locationModel!.data!.isEmpty)
                    //   return Container();
                    if (value.loading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 15,bottom: 15,left: 15,right: 15),
                        itemCount: value.locationModel!.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Row(
                              children: [
                                Icon(Icons.location_on,color: kSecondaryColor),
                                SizedBox(width: 10),
                                Container(
                                  height: 40,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    value.locationModel!.data![index].fullAddress!,
                                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
                                  ),
                                ),
                                /*Spacer(),
                                IconButton( icon: Icon(Icons.delete,color:kPrimaryColor ),

                                onPressed: (){

                                  getIt<LocationProvider>().deletelocation(value.locationModel.data[index].iD.toString());

                                },),*/
                              ],
                            ),
                          );
                        },
                      ),
                    );

                  },
                )
              ],
            ),

          ],
        ),
      ),
      bottomSheet: Container(
        height: 5.0.h,
        color: Colors.white,
      ),
    );
  }
}

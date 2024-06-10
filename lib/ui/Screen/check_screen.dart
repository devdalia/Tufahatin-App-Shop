
import 'package:ecommerce/get_it.dart';
import 'package:ecommerce/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'home_application.dart';
import 'package:provider/provider.dart';
class CheckOutScreen extends StatefulWidget {
  static const String id ="CheckOutScreen";


  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

String ?cart;

@override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final pay= getIt<CreateOrderProvider>().updateOrderModel;
    return Scaffold(

      body: Center(

        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.0.h),
            Image.asset('assets/images/pay.jpg',width: 90.0.w,height: 30.0.h,fit: BoxFit.cover,),
            SizedBox(height: 5.0.h),
            Text(
             "Then the payment is successfulr",style: TextStyle(fontSize: 20.0.sp),),
//'Then the payment is successful'
            Expanded(child:Container()),
            Container(
              width: double.infinity,
              height: 6.5.h,
              padding: EdgeInsets.only(right: 15, left: 15 ),

         /*     child:Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer<CartProvider>(
                      builder: (context, value, child){
                        return  CustomButtonWidget(
                            title: 'Done',
                            color: kPrimaryColor,
                            onClick: () async {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, HomeApplication.id, (route) => false);

                              await savePrefString(cart_pro, '');


                            });
                      }
                    
                  ),
                  ),
                ),*/
              ),



            SizedBox(height: 10.5.w),
          ],
        ),
      ),
    );
  }
/*getPre() async {
  String cart = await getPrefString(cart_pro);
  setState(() {
    cart = cart;
    print(cart);
    // log('token => ${tokenPref}');
  });
}*/
}

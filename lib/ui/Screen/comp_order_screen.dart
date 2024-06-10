import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ecommerce/providers/order_provider.dart';
import '../../get_it.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/ui/widget/loading_widget.dart';
import 'package:ecommerce/ui/widget/custom_radio.dart';
import 'package:ecommerce/ui/Screen/Cash_on_delivery_screen.dart';
class CompleteOrderScreem extends StatefulWidget {
  static const String id = "CompleteOrderScreem";

  @override
  _CompleteOrderScreemState createState() => _CompleteOrderScreemState();
}

enum SingingCharacter { jefferson4, jefferson, jefferson2, jefferson3 }

class _CompleteOrderScreemState extends State<CompleteOrderScreem> {
  SingingCharacter _character = SingingCharacter.jefferson;

  @override
  void initState() {
    getIt<CreateOrderProvider>().getPayment();
    super.initState();
  }

  String ?itemSelected11;

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
            "Completed Order",

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
            SizedBox(height: 5.0.h),
          /*        buildDropButton(),
            itemSelected == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                              color: kColorfont2,
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          itemSelected == null
                              ? '  '
                              : itemSelected.description,
                          style: TextStyle(
                            color: kColorfont2,
                            fontSize: 12.0.sp,
                          ),
                        ),
                      ],
                    ),
                  ),*/

            Consumer<CreateOrderProvider>(
              builder: (context, value, child) {
                if (value.paymentloading) {
                  return LoadingWidget(color: kPrimaryColor);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 10),
                      margin: EdgeInsets.only(top: 25),
                      child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                        children: value.paymentModel!.paymentDetails!
                            .map((e) => CustomRadio(
                          title:e.id,
                          value: e.id.toString(),
                          selected:itemSelected11,
                          click: () {
                            setState(() {
                              itemSelected11= e.id.toString();

                            });
                          },
                        ))
                            .toList(),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        if(itemSelected11==value.paymentModel!.paymentDetails![2].id){
                          Navigator.pushNamed(context, CashOnDeliveryScreeen.id);
                        }
                      },
                      child: Container(
                        height: 7.5.h,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 20,right: 20),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(25)
                        ),
                        margin: EdgeInsets.symmetric(horizontal:25,vertical: 20 ),
                        alignment: Alignment.center,
                        child: Text('Next',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0.sp) ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

/*  Widget buildDropButton() {
    return Consumer<CreateOrderProvider>(
      builder: (context, value, child) {
        if (value.paymentloading) {
          return LoadingWidget(color: kPrimaryColor);
        }
        return Container(
          padding: EdgeInsets.only(left: 10, right: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child:  DropdownButtonHideUnderline(
            child: DropdownButton(
                hint: new Text(
                  'Payment Method',
                  style: TextStyle(
                      color: kTextLightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0.sp),
                ),
                iconEnabledColor: Color(0xff3F3E3E),
                iconDisabledColor: Color(0xff3F3E3E),
                icon: Icon(Icons.keyboard_arrow_down),
                dropdownColor: Colors.white,
                items:
                    value.paymentModel.paymentDetails.map((PaymentModel item) {
                  return DropdownMenuItem(
                      value: item,
                      child: Text(item.id,
                          style: TextStyle(
                              color: kTextLightColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0.sp)));
                }).toList(),
                isExpanded: true,
                value: itemSelected,
                onChanged: (value) {
                  setState(() {
                    itemSelected = value;
                    getIt<CreateOrderProvider>().itemSelected = value;
                  });
                }),
          )
        );
      },
    );
  }*/
}

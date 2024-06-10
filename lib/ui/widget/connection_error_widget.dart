import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/material.dart';
class ConnectionErrorWidget extends StatelessWidget {
  final VoidCallback ?onClick;

  ConnectionErrorWidget({this.onClick});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_wifi.png'),
          SizedBox(
            height: 20,
          ),
          Text('المعذرة لا يوجد بيانات',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: kColorfont
              )),
          Text("يرجى التأكد من إتصالك بالانترنت",
              style: TextStyle(fontSize: 16, color: kColorfont)),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 40,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: kPrimaryColor,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ('refresh'),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  ],
                ),
                onPressed: onClick),
          )
        ],
      ),
    );
  }
}


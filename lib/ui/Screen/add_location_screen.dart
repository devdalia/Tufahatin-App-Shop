import 'dart:async';
import 'dart:developer';
import 'package:ecommerce/ui/widget/custom_button_widget.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providers/location_provider.dart';
import 'package:ecommerce/get_it.dart'
    '';
class AddLocationScreen extends StatefulWidget {
  static const String id = "AddLocationScreen";

  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  Completer<GoogleMapController> _mapController = Completer();

  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  int _markerIdCounter = 0;
  String latitude = "";
  String longitude = "";
  String newLat = "";
  String newLog = "";

  @override
  void initState() {
    getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getIt<LocationProvider>().scaffoldKey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          " Address",
          style: TextStyle(
              color: Colors.white,
              fontSize: 15.0.sp,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Container(),
      ),
      backgroundColor: Colors.white,
      body: Consumer<LocationProvider>(
        builder: (context, value, child) {
          if (value.loading || latitude == "" || longitude == "") {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 30),
            child: Column(
              children: [
                TextFormField(
                  controller: getIt<LocationProvider>().addressController,
                  decoration: InputDecoration(
                      labelText: ('Address'),
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: kPrimaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: kPrimaryColor))),
                ),
                SizedBox(height: 3.0.h),
                Container(
                  height: 50.0.h,
                  width: double.infinity,
                  child: GoogleMap(
                    markers: Set<Marker>.of(_markers.values),
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          double.parse(latitude), double.parse(longitude)),
                      zoom: 12.0,
                    ),
                    myLocationEnabled: true,
                    onCameraMove: (CameraPosition position) {
                      if (_markers.length > 0) {
                        MarkerId markerId = MarkerId(_markerIdVal());
                        Marker? marker = _markers[markerId];
                        Marker updatedMarker = marker!.copyWith(
                          positionParam: position.target,
                        );
                        setState(() {
                          log('message => ${position.target.latitude}');
                          log('message1 => ${position.target.longitude}');
                          log('message address => ${value.addressController}');
                          log('message mark => ${marker}');
                          getIt<LocationProvider>().lat =
                              position.target.latitude.toString();
                          getIt<LocationProvider>().log =
                              position.target.longitude.toString();
                          _markers[markerId] = updatedMarker;
                        });
                      }
                    },
                    gestureRecognizers: Set()
                      ..add(Factory<EagerGestureRecognizer>(
                              () => EagerGestureRecognizer())),
                  ),
                ),
                SizedBox(height: 1.0.h),
                CustomButtonWidget(
                  title: 'save',
                  onClick: () {
                    value.addNewAddress();
                  },
                  loading: value.loading,
                  color: kPrimaryColor,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    LatLng INITIAL_LOCATION =
    LatLng(double.parse(latitude), double.parse(longitude));
    _mapController.complete(controller);
    if (INITIAL_LOCATION != null) {
      MarkerId markerId = MarkerId(_markerIdVal());
      LatLng position = INITIAL_LOCATION;
      Marker marker =
      Marker(markerId: markerId, position: position, draggable: false);
      setState(() {
        _markers[markerId] = marker;
      });

      Future.delayed(Duration(seconds: 1), () async {
        GoogleMapController controller = await _mapController.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: position,
              zoom: 17.0,
            ),
          ),
        );
      });
    }
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  getUserLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    });
  }
}

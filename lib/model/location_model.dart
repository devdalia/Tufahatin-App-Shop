class LocationModel {
  bool ?status;
  List<Datass>? data;

  LocationModel({this.status, this.data});

  LocationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Datass>[];
      json['data'].forEach((v) {
        data!.add(new Datass.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datass {
  String ?iD;
  String? userId;
  String ?locationLatitude;
  String ?locationLongtitude;
  String ?fullAddress;
  String ?type;

  Datass(
      {this.iD,
        this.userId,
        this.locationLatitude,
        this.locationLongtitude,
        this.fullAddress,
        this.type});

  Datass.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userId = json['user_id'];
    locationLatitude = json['location_latitude'];
    locationLongtitude = json['location_longtitude'];
    fullAddress = json['full_address'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['user_id'] = this.userId;
    data['location_latitude'] = this.locationLatitude;
    data['location_longtitude'] = this.locationLongtitude;
    data['full_address'] = this.fullAddress;
    data['type'] = this.type;
    return data;
  }
}

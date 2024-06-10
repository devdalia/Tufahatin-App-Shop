class ProfileModel {
  bool ?status;
  String? message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String ?id;
  String ?displayName;
  String? email;
  String ?userName;
  String ?userImage;

  Data({this.id, this.displayName, this.email, this.userName, this.userImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['display_name'];
    email = json['email'];
    userName = json['user_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['display_name'] = this.displayName;
    data['email'] = this.email;
    data['user_name'] = this.userName;
    data['user_image'] = this.userImage;
    return data;
  }
}

class RegisterModel {
  bool ?status;
  String ?message;
  Data ?data;

  RegisterModel({this.status, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
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
  int ?id;
  String ?token;
  String ?email;
  String ?displayName;
  String? userName;
  String ?userImage;

  Data(
      {this.id,
        this.token,
        this.email,
        this.displayName,
        this.userName,
        this.userImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    email = json['email'];
    displayName = json['display_name'];
    userName = json['user_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['email'] = this.email;
    data['display_name'] = this.displayName;
    data['user_name'] = this.userName;
    data['user_image'] = this.userImage;
    return data;
  }
}

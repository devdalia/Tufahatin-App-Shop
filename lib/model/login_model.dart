// class LoginModel {
//   bool status;
//   String message;
//   Data data;
//
//   LoginModel({this.status, this.message, this.data});
//
//   LoginModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class Data {
//   String token;
//   int id;
//  // String cookie;
//
//   Data({this.token});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     id = json['id'];
//  // cookie = json['cookie'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['token'] = this.token;
//     data['id'] = this.id;
//  // data['cookie'] = this.cookie;
//     return data;
//   }
// }
//
class LoginModel {
  bool ?status;
  String ?message;
  Data ?data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  //Cookie cookie;
  String ?email;
  String ?displayName;
  String ?userName;
  String ?userImage;

  Data(
      {this.id,
        this.token,
      //  this.cookie,
        this.email,
        this.displayName,
        this.userName,
        this.userImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    //cookie = json['cookie'] != null ? new Cookie.fromJson(json['cookie']) : null;
    email = json['email'];
    displayName = json['display_name'];
    userName = json['user_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
   /* if (this.cookie != null) {
      data['cookie'] = this.cookie.toJson();
    }*/
    data['email'] = this.email;
    data['display_name'] = this.displayName;
    data['user_name'] = this.userName;
    data['user_image'] = this.userImage;
    return data;
  }
}
/*
class Cookie {
  String wordpressLoggedIn9879b51c395e1906fc92a701d4450dcd;

  Cookie({this.wordpressLoggedIn9879b51c395e1906fc92a701d4450dcd});

  Cookie.fromJson(Map<String, dynamic> json) {
    wordpressLoggedIn9879b51c395e1906fc92a701d4450dcd =
    json['wordpress_logged_in_9879b51c395e1906fc92a701d4450dcd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wordpress_logged_in_9879b51c395e1906fc92a701d4450dcd'] =
        this.wordpressLoggedIn9879b51c395e1906fc92a701d4450dcd;
    return data;
  }
}*/

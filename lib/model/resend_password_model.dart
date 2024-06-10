class ResendPasswordModel {
  bool? status;
  ResendPassword? resendPassword;
  String? message;

  ResendPasswordModel({this.status, this.resendPassword, this.message});

  ResendPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    resendPassword = json['data'] != null ? new ResendPassword.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.resendPassword != null) {
      data['data'] = this.resendPassword!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class ResendPassword {
  String ?userId;
  String ?newPassword;

  ResendPassword({this.userId, this.newPassword});

  ResendPassword.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    newPassword = json['new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['new_password'] = this.newPassword;
    return data;
  }
}

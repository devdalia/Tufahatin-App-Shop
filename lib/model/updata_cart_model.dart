class UpdataCartModel {
  String ?message;
  int? quantity;

  UpdataCartModel({this.message, this.quantity});

  UpdataCartModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['quantity'] = this.quantity;
    return data;
  }
}

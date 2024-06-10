class UpdateOrderModel {
  bool ?status;
  String ?message;
  Data? data;

  UpdateOrderModel({this.status, this.message, this.data});

  UpdateOrderModel.fromJson(Map<String, dynamic> json) {
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
  int ?orderId;
  String ?orderStatus;

  Data({this.orderId, this.orderStatus});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_status'] = this.orderStatus;
    return data;
  }
}

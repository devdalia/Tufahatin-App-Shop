class PaymentModelList {
  List<PaymentModel>? paymentDetails;

  PaymentModelList({this.paymentDetails});

  PaymentModelList.fromJson(List<dynamic> parsedJson) {
    if (parsedJson != null) {
      paymentDetails = <PaymentModel>[];
      paymentDetails =
          parsedJson.map((e) => PaymentModel.fromJson(e)).toList();
    }
  }

}

class PaymentModel {
  String ?id;
  String ?title;
  String ?description;
  var order;
  bool? enabled;
  String ?methodTitle;
  String ?methodDescription;
  List<String> ?methodSupports;

  PaymentModel({this.id, this.title, this.description, this.order, this.enabled, this.methodTitle, this.methodDescription, this.methodSupports});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    order = json['order'];
    enabled = json['enabled'];
    methodTitle = json['method_title'];
    methodDescription = json['method_description'];
    methodSupports = json['method_supports'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['order'] = this.order;
    data['enabled'] = this.enabled;
    data['method_title'] = this.methodTitle;
    data['method_description'] = this.methodDescription;
    data['method_supports'] = this.methodSupports;

    return data;
  }
}





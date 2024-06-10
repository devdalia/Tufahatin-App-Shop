





class CreateOrderModel {
  int ?customerId;
  int ?id;
  String? status;
  String ?currency;
  String ?version;
  String ?customerNote;
  String? paymentMethod;
  String ?paymentMethodTitle;
  bool? setPaid;
  Shipping ?shipping;
  List<MetaDataa> ?metaData;
  List<LineItems>? lineItems;

  CreateOrderModel(
      {this.customerId,
        this.id,
        this.status,
        this.currency,
        this.version,
        this.customerNote,
        this.paymentMethod,
        this.paymentMethodTitle,
        this.setPaid,
        this.shipping,
        this.metaData,
        this.lineItems});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    id = json['id'];
    status = json['status'];
    currency = json['currency'];
    version = json['version'];
    customerNote = json['customer_note'];
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    setPaid = json['set_paid'];
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    if (json['meta_data'] != null) {
      metaData = <MetaDataa>[];
      json['meta_data'].forEach((v) {
        metaData!.add(new MetaDataa.fromJson(v));
      });
    }
    if (json['line_items'] != null) {
      lineItems = <LineItems>[];
      json['line_items'].forEach((v) {
        lineItems!.add(new LineItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['id'] = this.id;
    data['status'] = this.status;
    data['currency'] = this.currency;
    data['version'] = this.version;
    data['customer_note'] = this.customerNote;
    data['payment_method'] = this.paymentMethod;
    data['payment_method_title'] = this.paymentMethodTitle;
    data['set_paid'] = this.setPaid;
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.map((v) => v.toJson()).toList();
    }
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shipping {
  String ?firstName;
  String ?lastName;
  String ?address1;
  String ?address2;
  String?city;
  String ?state;
  String ?postcode;
  String ?country;

  Shipping(
      {this.firstName,
        this.lastName,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.postcode,
        this.country});

  Shipping.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    return data;
  }
}
class MetaDataa {
  int ?id;
  String? key;
  String ?value;

  MetaDataa({this.id, this.key, this.value});

  MetaDataa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class LineItems {
  int ?productId;
  int ?quantity;

  LineItems({this.productId, this.quantity });

  LineItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;

    return data;
  }
}

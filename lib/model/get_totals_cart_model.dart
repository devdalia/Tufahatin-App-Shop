class GetTotalsCartModel {
  String ?subtotal;
 // String shippingTotal;
  //int shippingTax;
//  List<Null> shippingTaxes;
 // int discountTotal;
  int? discountTax;
  //String cartContentsTotal;
 // int cartContentsTax;
 // List<Null> cartContentsTaxes;
 // String feeTotal;
//  int feeTax;
 // List<Null> feeTaxes;
  String? total;
  int ?totalTax;

  GetTotalsCartModel(
      {this.subtotal,

        this.discountTax,

        this.total,
        this.totalTax});

  GetTotalsCartModel.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];

    discountTax = json['discount_tax'];


    total = json['total'];
    totalTax = json['total_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['discount_tax'] = this.discountTax;

    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    return data;
  }
}

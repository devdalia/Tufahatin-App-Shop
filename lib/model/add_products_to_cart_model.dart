/*class AddProductsToCartModel {
  List<ProductsToCartModel> addproduct;

  AddProductsToCartModel({this.addproduct});

  AddProductsToCartModel.fromJson(List<dynamic> parsedJson) {
    if (parsedJson != null) {
      addproduct = List<ProductsToCartModel>();
      addproduct =
          parsedJson.map((e) => ProductsToCartModel.fromJson(e)).toList();
    }
  }

}*/
class  AddProductsToCartModel {
  String ?key;
  int ?productId;
  int ?quantity;
  String? dataHash;
  String ?productName;
  String ?productPrice;
  String ?productImage;

  AddProductsToCartModel({required this.key, required this.productId,   required this.quantity, required this.dataHash,     required this.productName,  required this.productPrice});

  AddProductsToCartModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    productId = json['product_id'];
    quantity = json['quantity'];
    dataHash = json['data_hash'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['data_hash'] = this.dataHash;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    return data;
  }

}



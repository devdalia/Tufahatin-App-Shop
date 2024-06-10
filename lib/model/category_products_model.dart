class CategoryProductModel {
  List<CategoryProduct> ?productsDetails;
  CategoryProductModel({this.productsDetails});
  CategoryProductModel.fromJson(List<dynamic> parsedJson) {
    if (parsedJson != null) {
      productsDetails = <CategoryProduct>[];
      productsDetails =
          parsedJson.map((e) => CategoryProduct.fromJson(e)).toList();
    }
  }
}
class CategoryProduct  {
  int ?id;
  String ?name;
  String ?slug;
  String?permalink;
  String ?dateCreated;
  String? dateCreatedGmt;
  String ?dateModified;
  String? dateModifiedGmt;
  String? type;
  String ?status;
  bool ?featured;
  String? catalogVisibility;
  String ?description;
  String ?shortDescription;
  String ?sku;
  String ?price;
  String? regularPrice;
  String ?salePrice;
  bool ?onSale;
  bool ?purchasable;
  int ?totalSales;
  bool ?virtual;
  bool? downloadable;
  int ?downloadLimit;
  int ?downloadExpiry;
  String ?externalUrl;
  String? buttonText;
  String ?taxStatus;
  String? taxClass;
  bool ?manageStock;
  int ?stockQuantity;
  String? backorders;
  bool? backordersAllowed;
  bool ?backordered;
  bool ?soldIndividually;
  String? weight;
  bool ?shippingRequired;
  bool ?shippingTaxable;
  String ?shippingClass;
  int? shippingClassId;
  bool ?reviewsAllowed;
  String ?averageRating;
  int ?ratingCount;
  int ?parentId;
  String ?purchaseNote;
  List<Images> ?images;
  int? menuOrder;
  String ?priceHtml;
  List<int> ?relatedIds;
  String ?stockStatus;
 late int quntity;


  CategoryProduct(
      {this.id,
        this.name,
        this.slug,
        this.permalink,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.type,
        this.status,
        this.featured,
        this.catalogVisibility,
        this.description,
        this.shortDescription,
        this.sku,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.onSale,
        this.purchasable,
        this.totalSales,
        this.virtual,
        this.downloadable,
        this.downloadLimit,
        this.downloadExpiry,
        this.externalUrl,
        this.buttonText,
        this.taxStatus,
        this.taxClass,
        this.manageStock,
        this.stockQuantity,
        this.backorders,
        this.backordersAllowed,
        this.backordered,
        this.soldIndividually,
        this.weight,
        this.shippingRequired,
        this.shippingTaxable,
        this.shippingClass,
        this.shippingClassId,
        this.reviewsAllowed,
        this.averageRating,
        this.ratingCount,
        this.parentId,
        this.purchaseNote,
        this.images,
        this.menuOrder,
        this.priceHtml,
        this.relatedIds,
        this.stockStatus,
      this.quntity =1});

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    permalink = json['permalink'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    type = json['type'];
    status = json['status'];
    featured = json['featured'];
    catalogVisibility = json['catalog_visibility'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    onSale = json['on_sale'];
    purchasable = json['purchasable'];
    totalSales = json['total_sales'];
    virtual = json['virtual'];
    downloadable = json['downloadable'];
    downloadLimit = json['download_limit'];
    downloadExpiry = json['download_expiry'];
    externalUrl = json['external_url'];
    buttonText = json['button_text'];
    taxStatus = json['tax_status'];
    taxClass = json['tax_class'];
    manageStock = json['manage_stock'];
    stockQuantity = json['stock_quantity'];
    backorders = json['backorders'];
    backordersAllowed = json['backorders_allowed'];
    backordered = json['backordered'];
    soldIndividually = json['sold_individually'];
    weight = json['weight'];

    shippingRequired = json['shipping_required'];
    shippingTaxable = json['shipping_taxable'];
    shippingClass = json['shipping_class'];
    shippingClassId = json['shipping_class_id'];
    reviewsAllowed = json['reviews_allowed'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    quntity = json['quntity'] ?? 1;

    parentId = json['parent_id'];
    purchaseNote = json['purchase_note'];

    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    menuOrder = json['menu_order'];
    priceHtml = json['price_html'];
    relatedIds = json['related_ids'].cast<int>();

    stockStatus = json['stock_status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['permalink'] = this.permalink;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['type'] = this.type;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['catalog_visibility'] = this.catalogVisibility;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['on_sale'] = this.onSale;
    data['purchasable'] = this.purchasable;
    data['total_sales'] = this.totalSales;
    data['virtual'] = this.virtual;
    data['downloadable'] = this.downloadable;
    data['download_limit'] = this.downloadLimit;
    data['download_expiry'] = this.downloadExpiry;
    data['external_url'] = this.externalUrl;
    data['button_text'] = this.buttonText;
    data['tax_status'] = this.taxStatus;
    data['tax_class'] = this.taxClass;
    data['manage_stock'] = this.manageStock;
    data['stock_quantity'] = this.stockQuantity;
    data['backorders'] = this.backorders;
    data['backorders_allowed'] = this.backordersAllowed;
    data['backordered'] = this.backordered;
    data['sold_individually'] = this.soldIndividually;
    data['weight'] = this.weight;

    data['shipping_required'] = this.shippingRequired;
    data['shipping_taxable'] = this.shippingTaxable;
    data['shipping_class'] = this.shippingClass;
    data['shipping_class_id'] = this.shippingClassId;
    data['reviews_allowed'] = this.reviewsAllowed;
    data['average_rating'] = this.averageRating;
    data['rating_count'] = this.ratingCount;
    data['parent_id'] = this.parentId;
    data['purchase_note'] = this.purchaseNote;

    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['menu_order'] = this.menuOrder;
    data['price_html'] = this.priceHtml;
    data['related_ids'] = this.relatedIds;

    data['stock_status'] = this.stockStatus;
    data['quntity'] = this.quntity;
    return data;
  }
}

/*class Dimensions {
  String length;
  String width;
  String height;

  Dimensions({this.length, this.width, this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Categories {
  int id;
  String name;
  String slug;

  Categories({this.id, this.name, this.slug});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}*/

class Images {
  int ?id;
  String ?dateCreated;
  String ?dateCreatedGmt;
  String ?dateModified;
  String ?dateModifiedGmt;
  String ?src;
  String ?name;
  String ?alt;

  Images(
      {this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.src,
        this.name,
        this.alt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}

/*class MetaData {
  int id;
  String key;
  String value;

  MetaData({this.id, this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}*/



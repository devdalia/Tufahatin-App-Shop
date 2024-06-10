class AllSearchModel {
  List<AllSearch> ?productsSearch;

  AllSearchModel({required this.productsSearch});

  AllSearchModel.fromJson(List<dynamic> parsedJson) {
    if (parsedJson != null) {
      productsSearch = <AllSearch>[];
      productsSearch =
          parsedJson.map((e) => AllSearch.fromJson(e)).toList();
    }
  }

}



class AllSearch {
  int ?id;
  String? name;
  String ?slug;
  String? permalink;
  String ?dateCreated;
  String ?dateCreatedGmt;
  String ?dateModified;
  String ?dateModifiedGmt;
  String ?type;
  String ?status;
  bool ?featured;
  String ?catalogVisibility;
  String? description;
  String? shortDescription;
  String ?sku;
  String ?price;
  String? regularPrice;
  String? salePrice;
  bool ?onSale;
  bool? purchasable;
  int? totalSales;
  bool? virtual;
  bool ?downloadable;
  int? downloadLimit;
  int ?downloadExpiry;
  String? externalUrl;
  String ?buttonText;
  String? taxStatus;
  String? taxClass;
  bool ?manageStock;

  String? backorders;
  bool ?backordersAllowed;
  bool? backordered;
  bool? soldIndividually;
  String? weight;
  Dimensions ?dimensions;
  bool? shippingRequired;
  bool ?shippingTaxable;
  String? shippingClass;
  int ?shippingClassId;
  bool?reviewsAllowed;
  String ?averageRating;
  int ?ratingCount;
  List<int> ?upsellIds;
  int ?parentId;
  String ?purchaseNote;
  List<Categories>? categories;
  List<Images> ?images;
  int? menuOrder;
  String? priceHtml;
  List<int>? relatedIds;
  List<MetaData> ?metaData;
  String ?stockStatus;


  AllSearch({this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required  this.type,
    required  this.status,
    required  this.featured,
    required   this.catalogVisibility,
    required   this.description,
    required   this.shortDescription,
    required  this.sku,
    required   this.price,
    required   this.regularPrice,
    required    this.salePrice,
    required    this.onSale,
    required    this.purchasable,
    required   this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloadLimit,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,

    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.soldIndividually,
    this.weight,
    this.dimensions,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.upsellIds,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.images,
    this.menuOrder,
    this.priceHtml,
    this.relatedIds,
    this.metaData,
    this.stockStatus});

  AllSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];


  }
}

class Dimensions {
  String ?length;
  String? width;
  String ?height;

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
  int ?id;
  String? name;
  String ?slug;

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
}

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

class MetaData {
  int ?id;
  String ?key;
  String? value;

  MetaData({this.id, this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}





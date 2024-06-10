

class FavoriteeModel {
  List<Favorites>? productsFavorite;

  FavoriteeModel({this.productsFavorite});

  FavoriteeModel.fromJson(List<dynamic> parsedJson) {
    if (parsedJson != null) {
      productsFavorite = <Favorites>[];
      productsFavorite =
          parsedJson.map((e) => Favorites.fromJson(e)).toList();
    }
  }
}
class Favorites {
    int? id;
  String? name;
  String ?averageRating;
  String ?price;
  int ?ratingCount;
  String ?images;
 // bool favorite;

  Favorites(
      {this.id,
        this.name,
        this.averageRating,
        this.price,
        this.ratingCount,

        this.images});

  Favorites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    averageRating = json['averageRating'];
    name = json['name'];
    price = json['price'];
    ratingCount = json['ratingCount'];
    images = json['images'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['averageRating'] = this.averageRating;
    data['ratingCount'] = this.ratingCount;
    data['images'] = this.images;


    return data;
  }
}

class Images {
  int ?id;
  String? dateCreated;
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

class CategoryModel {
  int? count;
  List<Datum>? data;
  int? limit;
  int? page;

  CategoryModel({
    this.count,
    this.data,
    this.limit,
    this.page,
  });

  CategoryModel copyWith({
    int? count,
    List<Datum>? data,
    int? limit,
    int? page,
  }) =>
      CategoryModel(
        count: count ?? this.count,
        data: data ?? this.data,
        limit: limit ?? this.limit,
        page: page ?? this.page,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        limit: json["limit"],
        page: json["page"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "limit": limit,
        "page": page,
      };
}

class Datum {
  String? title;
  String? key;
  String? url;
  String? type;
  String? image;
  dynamic count;
  String? categoryType;

  Datum({
    this.title,
    this.key,
    this.url,
    this.type,
    this.image,
    this.count,
    this.categoryType,
  });

  Datum copyWith({
    String? title,
    String? key,
    String? url,
    String? type,
    String? image,
    dynamic count,
    String? categoryType,
  }) =>
      Datum(
        title: title ?? this.title,
        key: key ?? this.key,
        url: url ?? this.url,
        type: type ?? this.type,
        image: image ?? this.image,
        count: count ?? this.count,
        categoryType: categoryType ?? this.categoryType,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        key: json["key"],
        url: json["url"],
        type: json["type"],
        image: json["image"],
        count: json["count"],
        categoryType: json["category_type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "key": key,
        "url": url,
        "type": type,
        "image": image,
        "count": count,
        "category_type": categoryType,
      };
}

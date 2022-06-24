// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
  SearchModel({
    this.id,
    this.title,
    this.url,
    this.type,
    this.subtype,
    this.links,
  });

  int id;
  String title;
  String url;
  Type type;
  Type subtype;
  Links links;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    type: typeValues.map[json["type"]],
    subtype: typeValues.map[json["subtype"]],
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "type": typeValues.reverse[type],
    "subtype": typeValues.reverse[subtype],
    "_links": links.toJson(),
  };
}

class Links {
  Links({
    this.self,
    this.about,
    this.collection,
  });

  List<Self> self;
  List<About> about;
  List<About> collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Self>.from(json["self"].map((x) => Self.fromJson(x))),
    about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
    collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "about": List<dynamic>.from(about.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
  };
}

class About {
  About({
    this.href,
  });

  String href;

  factory About.fromJson(Map<String, dynamic> json) => About(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class Self {
  Self({
    this.embeddable,
    this.href,
  });

  bool embeddable;
  String href;

  factory Self.fromJson(Map<String, dynamic> json) => Self(
    embeddable: json["embeddable"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "embeddable": embeddable,
    "href": href,
  };
}

enum Type { POST, PRESS_RELEASE }

final typeValues = EnumValues({
  "post": Type.POST,
  "press_release": Type.PRESS_RELEASE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

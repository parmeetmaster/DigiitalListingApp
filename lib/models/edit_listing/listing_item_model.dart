// To parse this JSON data, do
//
//     final lIstingItemModel = lIstingItemModelFromJson(jsonString);

import 'dart:convert';

class LIstingItemModel {
  LIstingItemModel({
    this.success,
    this.pagination,
    this.data,
  });

  bool success;
  Pagination pagination;
  List<DataListModel> data;

  factory LIstingItemModel.fromRawJson(String str) => LIstingItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LIstingItemModel.fromJson(Map<String, dynamic> json) => LIstingItemModel(
    success: json["success"],
    pagination: Pagination.fromJson(json["pagination"]),
    data: List<DataListModel>.from(json["data"].map((x) => DataListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "pagination": pagination.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataListModel {
  DataListModel({
    this.id,
    this.postAuthor,
    this.postDate,
    this.postDateGmt,
    this.postContent,
    this.postTitle,
    this.postExcerpt,
    this.postStatus,
    this.commentStatus,
    this.pingStatus,
    this.postPassword,
    this.postName,
    this.toPing,
    this.pinged,
    this.postModified,
    this.postModifiedGmt,
    this.postContentFiltered,
    this.postParent,
    this.guid,
    this.menuOrder,
    this.postType,
    this.postMimeType,
    this.commentCount,
    this.filter,
    this.address,
    this.phone,
    this.status,
    this.longitude,
    this.latitude,
    this.image,
    this.category,
    this.links,
    this.ratingAvg,
    this.ratingCount,
    this.wishlist,
  });

  int id;
  String postAuthor;
  DateTime postDate;
  DateTime postDateGmt;
  String postContent;
  String postTitle;
  PostExcerpt postExcerpt;
  PostStatus postStatus;
  CommentStatus commentStatus;
  PingStatus pingStatus;
  String postPassword;
  String postName;
  String toPing;
  String pinged;
  dynamic postModified;
  dynamic postModifiedGmt;
  String postContentFiltered;
  int postParent;
  String guid;
  int menuOrder;
  PostType postType;
  String postMimeType;
  int commentCount;
  Filter filter;
  String address;
  String phone;
  Status status;
  String longitude;
  String latitude;
  Image image;
  Category category;
  Links links;
  int ratingAvg;
  int ratingCount;
  bool wishlist;

  factory DataListModel.fromRawJson(String str) => DataListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataListModel.fromJson(Map<String, dynamic> json) => DataListModel(
    id: json["ID"],
    postAuthor: json["post_author"],
    postDate: DateTime.parse(json["post_date"]),
    postDateGmt: DateTime.parse(json["post_date_gmt"]),
    postContent: json["post_content"],
    postTitle: json["post_title"],
    postExcerpt: postExcerptValues.map[json["post_excerpt"]],
    postStatus: postStatusValues.map[json["post_status"]],
    commentStatus: commentStatusValues.map[json["comment_status"]],
    pingStatus: pingStatusValues.map[json["ping_status"]],
    postPassword: json["post_password"],
    postName: json["post_name"],
    toPing: json["to_ping"],
    pinged: json["pinged"],
    postModified: json["post_modified"],
    postModifiedGmt: json["post_modified_gmt"],
    postContentFiltered: json["post_content_filtered"],
    postParent: json["post_parent"],
    guid: json["guid"],
    menuOrder: json["menu_order"],
    postType: postTypeValues.map[json["post_type"]],
    postMimeType: json["post_mime_type"],
    commentCount: json["comment_count"],
    filter: filterValues.map[json["filter"]],
    address: json["address"],
    phone: json["phone"],
    status: statusValues.map[json["status"]],
    longitude: json["longitude"],
    latitude: json["latitude"],
    image: Image.fromJson(json["image"]),
    category: Category.fromJson(json["category"]),
    links: Links.fromJson(json["links"]),
    ratingAvg: json["rating_avg"],
    ratingCount: json["rating_count"],
    wishlist: json["wishlist"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "post_author": postAuthor,
    "post_date": postDate.toIso8601String(),
    "post_date_gmt": postDateGmt.toIso8601String(),
    "post_content": postContent,
    "post_title": postTitle,
    "post_excerpt": postExcerptValues.reverse[postExcerpt],
    "post_status": postStatusValues.reverse[postStatus],
    "comment_status": commentStatusValues.reverse[commentStatus],
    "ping_status": pingStatusValues.reverse[pingStatus],
    "post_password": postPassword,
    "post_name": postName,
    "to_ping": toPing,
    "pinged": pinged,
    "post_modified": postModified,
    "post_modified_gmt": postModifiedGmt,
    "post_content_filtered": postContentFiltered,
    "post_parent": postParent,
    "guid": guid,
    "menu_order": menuOrder,
    "post_type": postTypeValues.reverse[postType],
    "post_mime_type": postMimeType,
    "comment_count": commentCount,
    "filter": filterValues.reverse[filter],
    "address": address,
    "phone": phone,
    "status": statusValues.reverse[status],
    "longitude": longitude,
    "latitude": latitude,
    "image": image.toJson(),
    "category": category.toJson(),
    "links": links.toJson(),
    "rating_avg": ratingAvg,
    "rating_count": ratingCount,
    "wishlist": wishlist,
  };
}

class Category {
  Category({
    this.termId,
    this.name,
    this.slug,
    this.termTaxonomyId,
    this.parent,
    this.count,
    this.taxonomy,
    this.description,
    this.status,
  });

  int termId;
  Name name;
  String slug;
  int termTaxonomyId;
  int parent;
  int count;
  Taxonomy taxonomy;
  String description;
  Status status;

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    termId: json["term_id"],
    name: nameValues.map[json["name"]],
    slug: json["slug"],
    termTaxonomyId: json["term_taxonomy_id"],
    parent: json["parent"],
    count: json["count"],
    taxonomy: taxonomyValues.map[json["taxonomy"]],
    description: json["description"],
    status: statusValues.map[json["status"]],
  );

  Map<String, dynamic> toJson() => {
    "term_id": termId,
    "name": nameValues.reverse[name],
    "slug": slug,
    "term_taxonomy_id": termTaxonomyId,
    "parent": parent,
    "count": count,
    "taxonomy": taxonomyValues.reverse[taxonomy],
    "description": description,
    "status": statusValues.reverse[status],
  };
}

enum Name { AUTOMOTIVE, JOB_SEEKER }

final nameValues = EnumValues({
  "Automotive": Name.AUTOMOTIVE,
  "JobSeeker": Name.JOB_SEEKER
});

enum Status { ACTIVE }

final statusValues = EnumValues({
  "Active": Status.ACTIVE
});

enum Taxonomy { LISTAR_CATEGORY }

final taxonomyValues = EnumValues({
  "listar_category": Taxonomy.LISTAR_CATEGORY
});

enum CommentStatus { OPEN }

final commentStatusValues = EnumValues({
  "open": CommentStatus.OPEN
});

enum Filter { RAW }

final filterValues = EnumValues({
  "raw": Filter.RAW
});

class Image {
  Image({
    this.full,
    this.thumb,
    this.medium,
  });

  Full full;
  Full thumb;
  Full medium;

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    full: Full.fromJson(json["full"]),
    thumb: Full.fromJson(json["thumb"]),
    medium: Full.fromJson(json["medium"]),
  );

  Map<String, dynamic> toJson() => {
    "full": full.toJson(),
    "thumb": thumb.toJson(),
    "medium": medium.toJson(),
  };
}

class Full {
  Full({
    this.url,
  });

  String url;

  factory Full.fromRawJson(String str) => Full.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Full.fromJson(Map<String, dynamic> json) => Full(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  Collection self;
  Collection collection;

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: Collection.fromJson(json["self"]),
    collection: Collection.fromJson(json["collection"]),
  );

  Map<String, dynamic> toJson() => {
    "self": self.toJson(),
    "collection": collection.toJson(),
  };
}

class Collection {
  Collection({
    this.href,
  });

  String href;

  factory Collection.fromRawJson(String str) => Collection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

enum PingStatus { CLOSED }

final pingStatusValues = EnumValues({
  "closed": PingStatus.CLOSED
});

enum PostExcerpt { HAHAH, SHSH, EMPTY, EHE }

final postExcerptValues = EnumValues({
  "ehe": PostExcerpt.EHE,
  "": PostExcerpt.EMPTY,
  "hahah": PostExcerpt.HAHAH,
  "shsh": PostExcerpt.SHSH
});

enum PostStatus { PUBLISH }

final postStatusValues = EnumValues({
  "publish": PostStatus.PUBLISH
});

enum PostType { LISTAR }

final postTypeValues = EnumValues({
  "listar": PostType.LISTAR
});

class Pagination {
  Pagination({
    this.page,
    this.perPage,
    this.maxPage,
    this.total,
  });

  String page;
  int perPage;
  int maxPage;
  int total;

  factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    page: json["page"],
    perPage: json["per_page"],
    maxPage: json["max_page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "max_page": maxPage,
    "total": total,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

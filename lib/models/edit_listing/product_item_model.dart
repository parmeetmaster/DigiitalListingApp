// To parse this JSON data, do
//
//     final getProductDetail = getProductDetailFromJson(jsonString);

import 'dart:convert';

class GetProductDetail {
  GetProductDetail({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory GetProductDetail.fromRawJson(String str) => GetProductDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProductDetail.fromJson(Map<String, dynamic> json) => GetProductDetail(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  Data({
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
    this.author,
    this.image,
    this.category,
    this.features,
    this.tags,
    this.ratingAvg,
    this.ratingCount,
    this.ratingMeta,
    this.galleries,
    this.wishlist,
    this.openingHour,
    this.countryName,
    this.stateName,
    this.cityName,
    this.country,
    this.state,
    this.city,
    this.address,
    this.zipCode,
    this.phone,
    this.fax,
    this.email,
    this.website,
    this.color,
    this.icon,
    this.status,
    this.dateEstablish,
    this.latitude,
    this.longitude,
    this.priceMax,
    this.priceMin,
    this.socialNetwork,
    this.related,
    this.lastest,
    this.ads,
  });

  int id;
  String postAuthor;
  String postDate;
  DateTime postDateGmt;
  String postContent;
  String postTitle;
  String postExcerpt;
  String postStatus;
  String commentStatus;
  String pingStatus;
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
  String postType;
  String postMimeType;
  String commentCount;
  String filter;
  Author author;
  Image image;
  CategoryClass category;
  List<CategoryClass> features;
  List<Tag> tags;
  int ratingAvg;
  int ratingCount;
  Map<String, int> ratingMeta;
  List<Gallery> galleries;
  bool wishlist;
  List<OpeningHour> openingHour;
  String countryName;
  String stateName;
  String cityName;
  String country;
  String state;
  String city;
  String address;
  String zipCode;
  String phone;
  String fax;
  String email;
  String website;
  String color;
  String icon;
  String status;
  String dateEstablish;
  String latitude;
  String longitude;
  int priceMax;
  int priceMin;
  SocialNetwork socialNetwork;
  List<Lastest> related;
  List<Lastest> lastest;
  List<Ad> ads;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["ID"],
    postAuthor: json["post_author"],
    postDate: json["post_date"],
    postDateGmt: DateTime.parse(json["post_date_gmt"]),
    postContent: json["post_content"],
    postTitle: json["post_title"],
    postExcerpt: json["post_excerpt"],
    postStatus: json["post_status"],
    commentStatus: json["comment_status"],
    pingStatus: json["ping_status"],
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
    postType: json["post_type"],
    postMimeType: json["post_mime_type"],
    commentCount: json["comment_count"],
    filter: json["filter"],
    author: Author.fromJson(json["author"]),
    image: Image.fromJson(json["image"]),
    category: CategoryClass.fromJson(json["category"]),
    features: List<CategoryClass>.from(json["features"].map((x) => CategoryClass.fromJson(x))),
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    ratingAvg: json["rating_avg"],
    ratingCount: json["rating_count"],
    ratingMeta: Map.from(json["rating_meta"]).map((k, v) => MapEntry<String, int>(k, v)),
    galleries: List<Gallery>.from(json["galleries"].map((x) => Gallery.fromJson(x))),
    wishlist: json["wishlist"],
    openingHour: List<OpeningHour>.from(json["opening_hour"].map((x) => OpeningHour.fromJson(x))),
    countryName: json["country_name"],
    stateName: json["state_name"],
    cityName: json["city_name"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    address: json["address"],
    zipCode: json["zip_code"],
    phone: json["phone"],
    fax: json["fax"],
    email: json["email"],
    website: json["website"],
    color: json["color"],
    icon: json["icon"],
    status: json["status"],
    dateEstablish: json["date_establish"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    priceMax: json["price_max"],
    priceMin: json["price_min"],
    socialNetwork: SocialNetwork.fromJson(json["social_network"]),
    related: List<Lastest>.from(json["related"].map((x) => Lastest.fromJson(x))),
    lastest: List<Lastest>.from(json["lastest"].map((x) => Lastest.fromJson(x))),
    ads: List<Ad>.from(json["ads"].map((x) => Ad.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "post_author": postAuthor,
    "post_date": postDate,
    "post_date_gmt": postDateGmt.toIso8601String(),
    "post_content": postContent,
    "post_title": postTitle,
    "post_excerpt": postExcerpt,
    "post_status": postStatus,
    "comment_status": commentStatus,
    "ping_status": pingStatus,
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
    "post_type": postType,
    "post_mime_type": postMimeType,
    "comment_count": commentCount,
    "filter": filter,
    "author": author.toJson(),
    "image": image.toJson(),
    "category": category.toJson(),
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "rating_avg": ratingAvg,
    "rating_count": ratingCount,
    "rating_meta": Map.from(ratingMeta).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "galleries": List<dynamic>.from(galleries.map((x) => x.toJson())),
    "wishlist": wishlist,
    "opening_hour": List<dynamic>.from(openingHour.map((x) => x.toJson())),
    "country_name": countryName,
    "state_name": stateName,
    "city_name": cityName,
    "country": country,
    "state": state,
    "city": city,
    "address": address,
    "zip_code": zipCode,
    "phone": phone,
    "fax": fax,
    "email": email,
    "website": website,
    "color": color,
    "icon": icon,
    "status": status,
    "date_establish": dateEstablish,
    "latitude": latitude,
    "longitude": longitude,
    "price_max": priceMax,
    "price_min": priceMin,
    "social_network": socialNetwork.toJson(),
    "related": List<dynamic>.from(related.map((x) => x.toJson())),
    "lastest": List<dynamic>.from(lastest.map((x) => x.toJson())),
    "ads": List<dynamic>.from(ads.map((x) => x.toJson())),
  };
}

class Ad {
  Ad({
    this.id,
    this.name,
    this.url,
    this.image,
  });

  int id;
  String name;
  String url;
  String image;

  factory Ad.fromRawJson(String str) => Ad.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    id: json["id"],
    name: json["name"],
    url: json["url"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
    "image": image,
  };
}

class Author {
  Author({
    this.id,
    this.userEmail,
    this.displayName,
    this.userNicename,
    this.userUrl,
    this.decription,
    this.userLevel,
    this.locale,
    this.userPhoto,
  });

  int id;
  String userEmail;
  String displayName;
  String userNicename;
  String userUrl;
  String decription;
  int userLevel;
  String locale;
  String userPhoto;

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"],
    userEmail: json["user_email"],
    displayName: json["display_name"],
    userNicename: json["user_nicename"],
    userUrl: json["user_url"],
    decription: json["decription"],
    userLevel: json["user_level"],
    locale: json["locale"],
    userPhoto: json["user_photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_email": userEmail,
    "display_name": displayName,
    "user_nicename": userNicename,
    "user_url": userUrl,
    "decription": decription,
    "user_level": userLevel,
    "locale": locale,
    "user_photo": userPhoto,
  };
}

class CategoryClass {
  CategoryClass({
    this.termId,
    this.name,
    this.slug,
    this.termGroup,
    this.termTaxonomyId,
    this.taxonomy,
    this.description,
    this.parent,
    this.count,
    this.featuredImage,
    this.filter,
    this.image,
    this.color,
    this.icon,
  });

  int termId;
  String name;
  String slug;
  int termGroup;
  int termTaxonomyId;
  String taxonomy;
  String description;
  int parent;
  int count;
  String featuredImage;
  String filter;
  Gallery image;
  String color;
  String icon;

  factory CategoryClass.fromRawJson(String str) => CategoryClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryClass.fromJson(Map<String, dynamic> json) => CategoryClass(
    termId: json["term_id"],
    name: json["name"],
    slug: json["slug"],
    termGroup: json["term_group"],
    termTaxonomyId: json["term_taxonomy_id"],
    taxonomy: json["taxonomy"],
    description: json["description"],
    parent: json["parent"],
    count: json["count"],
    featuredImage: json["featured_image"] == null ? null : json["featured_image"],
    filter: json["filter"],
    image: json["image"] == null ? null : Gallery.fromJson(json["image"]),
    color: json["color"] == null ? null : json["color"],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "term_id": termId,
    "name": name,
    "slug": slug,
    "term_group": termGroup,
    "term_taxonomy_id": termTaxonomyId,
    "taxonomy": taxonomy,
    "description": description,
    "parent": parent,
    "count": count,
    "featured_image": featuredImage == null ? null : featuredImage,
    "filter": filter,
    "image": image == null ? null : image.toJson(),
    "color": color == null ? null : color,
    "icon": icon == null ? null : icon,
  };
}

class Gallery {
  Gallery({
    this.full,
    this.thumb,
  });

  Full full;
  Full thumb;

  factory Gallery.fromRawJson(String str) => Gallery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
    full: Full.fromJson(json["full"]),
    thumb: Full.fromJson(json["thumb"]),
  );

  Map<String, dynamic> toJson() => {
    "full": full.toJson(),
    "thumb": thumb.toJson(),
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

class Image {
  Image({
    this.full,
    this.medium,
    this.thumb,
  });

  Full full;
  Full medium;
  Full thumb;

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    full: Full.fromJson(json["full"]),
    medium: Full.fromJson(json["medium"]),
    thumb: Full.fromJson(json["thumb"]),
  );

  Map<String, dynamic> toJson() => {
    "full": full.toJson(),
    "medium": medium.toJson(),
    "thumb": thumb.toJson(),
  };
}

class Lastest {
  Lastest({
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
  String postDate;
  DateTime postDateGmt;
  String postContent;
  String postTitle;
  String postExcerpt;
  String postStatus;
  String commentStatus;
  String pingStatus;
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
  String postType;
  String postMimeType;
  String commentCount;
  String filter;
  String address;
  String phone;
  String status;
  String longitude;
  String latitude;
  Image image;
  CategoryClass category;
  Links links;
  int ratingAvg;
  int ratingCount;
  bool wishlist;

  factory Lastest.fromRawJson(String str) => Lastest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Lastest.fromJson(Map<String, dynamic> json) => Lastest(
    id: json["ID"],
    postAuthor: json["post_author"],
    postDate: json["post_date"],
    postDateGmt: DateTime.parse(json["post_date_gmt"]),
    postContent: json["post_content"],
    postTitle: json["post_title"],
    postExcerpt: json["post_excerpt"],
    postStatus: json["post_status"],
    commentStatus: json["comment_status"],
    pingStatus: json["ping_status"],
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
    postType: json["post_type"],
    postMimeType: json["post_mime_type"],
    commentCount: json["comment_count"],
    filter: json["filter"],
    address: json["address"],
    phone: json["phone"],
    status: json["status"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    image: Image.fromJson(json["image"]),
    category: CategoryClass.fromJson(json["category"]),
    links: Links.fromJson(json["links"]),
    ratingAvg: json["rating_avg"],
    ratingCount: json["rating_count"],
    wishlist: json["wishlist"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "post_author": postAuthor,
    "post_date": postDate,
    "post_date_gmt": postDateGmt.toIso8601String(),
    "post_content": postContent,
    "post_title": postTitle,
    "post_excerpt": postExcerpt,
    "post_status": postStatus,
    "comment_status": commentStatus,
    "ping_status": pingStatus,
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
    "post_type": postType,
    "post_mime_type": postMimeType,
    "comment_count": commentCount,
    "filter": filter,
    "address": address,
    "phone": phone,
    "status": status,
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

class OpeningHour {
  OpeningHour({
    this.label,
    this.key,
    this.dayOfWeek,
    this.schedule,
  });

  String label;
  String key;
  int dayOfWeek;
  List<Schedule> schedule;

  factory OpeningHour.fromRawJson(String str) => OpeningHour.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OpeningHour.fromJson(Map<String, dynamic> json) => OpeningHour(
    label: json["label"],
    key: json["key"],
    dayOfWeek: json["day_of_week"],
    schedule: List<Schedule>.from(json["schedule"].map((x) => Schedule.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "key": key,
    "day_of_week": dayOfWeek,
    "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
  };
}

class Schedule {
  Schedule({
    this.start,
    this.end,
  });

  String start;
  String end;

  factory Schedule.fromRawJson(String str) => Schedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    start: json["start"],
    end: json["end"],
  );

  Map<String, dynamic> toJson() => {
    "start": start,
    "end": end,
  };
}

class SocialNetwork {
  SocialNetwork({
    this.facebook,
    this.twitter,
    this.pinterest,
    this.tumblr,
    this.googlePlus,
    this.linkedin,
    this.youtube,
    this.instagram,
    this.flickr,
  });

  String facebook;
  String twitter;
  String pinterest;
  String tumblr;
  String googlePlus;
  String linkedin;
  String youtube;
  String instagram;
  String flickr;

  factory SocialNetwork.fromRawJson(String str) => SocialNetwork.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SocialNetwork.fromJson(Map<String, dynamic> json) => SocialNetwork(
    facebook: json["facebook"],
    twitter: json["twitter"],
    pinterest: json["pinterest"],
    tumblr: json["tumblr"],
    googlePlus: json["google_plus"],
    linkedin: json["linkedin"],
    youtube: json["youtube"],
    instagram: json["instagram"],
    flickr: json["flickr"],
  );

  Map<String, dynamic> toJson() => {
    "facebook": facebook,
    "twitter": twitter,
    "pinterest": pinterest,
    "tumblr": tumblr,
    "google_plus": googlePlus,
    "linkedin": linkedin,
    "youtube": youtube,
    "instagram": instagram,
    "flickr": flickr,
  };
}

class Tag {
  Tag({
    this.termId,
    this.name,
  });

  int termId;
  String name;

  factory Tag.fromRawJson(String str) => Tag.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    termId: json["term_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "term_id": termId,
    "name": name,
  };
}

class Advertisment {
  int id;
  String name;
  int subCategory;
  String typeOfAds;
  String governorate;
  String city;
  String category;
  String models;
  String status;
  String guarantee;
  String manufacturingYear;
  String kilometers;
  String gear;
  int price;
  String subject;
  String description;
  String userId;
  String publishedDate;
  String userNumber;
  String views;
  String publishedAt;
  String createdAt;
  String updatedAt;
  String userToken;
  List<Imagess> imagess;
  String video;

  Advertisment(
      {this.id,
        this.name,
        this.subCategory,
        this.typeOfAds,
        this.governorate,
        this.city,
        this.category,
        this.models,
        this.status,
        this.guarantee,
        this.manufacturingYear,
        this.kilometers,
        this.gear,
        this.price,
        this.subject,
        this.description,
        this.userId,
        this.publishedDate,
        this.userNumber,
        this.views,
        this.publishedAt,
        this.createdAt,
        this.updatedAt,
        this.userToken,
        this.imagess,
        this.video});

  Advertisment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subCategory = json['sub_category'];
    typeOfAds = json['type_of_ads'];
    governorate = json['Governorate'];
    city = json['city'];
    category = json['category'];
    models = json['models'];
    status = json['status'];
    guarantee = json['guarantee'];
    manufacturingYear = json['manufacturing_year'];
    kilometers = json['kilometers'];
    gear = json['gear'];
    price = json['price'];
    subject = json['subject'];
    description = json['description'];
    userId = json['user_id'];
    publishedDate = json['published_date'];
    userNumber = json['user_number'];
    views = json['views'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userToken = json['user_token'];
    if (json['imagess'] != null) {
      imagess = new List<Imagess>();
      json['imagess'].forEach((v) {
        imagess.add(new Imagess.fromJson(v));
      });
    }
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sub_category'] = this.subCategory;
    data['type_of_ads'] = this.typeOfAds;
    data['Governorate'] = this.governorate;
    data['city'] = this.city;
    data['category'] = this.category;
    data['models'] = this.models;
    data['status'] = this.status;
    data['guarantee'] = this.guarantee;
    data['manufacturing_year'] = this.manufacturingYear;
    data['kilometers'] = this.kilometers;
    data['gear'] = this.gear;
    data['price'] = this.price;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['published_date'] = this.publishedDate;
    data['user_number'] = this.userNumber;
    data['views'] = this.views;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_token'] = this.userToken;
    if (this.imagess != null) {
      data['imagess'] = this.imagess.map((v) => v.toJson()).toList();
    }
    data['video'] = this.video;
    return data;
  }
}

class Imagess {
  int id;
  String name;
  String alternativeText;
  String caption;
  int width;
  int height;
  Formats formats;
  String hash;
  String ext;
  String mime;
  double size;
  String url;
  String provider;
  String createdAt;
  String updatedAt;

  Imagess(
      {this.id,
        this.name,
        this.alternativeText,
        this.caption,
        this.width,
        this.height,
        this.formats,
        this.hash,
        this.ext,
        this.mime,
        this.size,
        this.url,
        this.provider,
        this.createdAt,
        this.updatedAt});

  Imagess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
    width = json['width'];
    height = json['height'];
    formats =
    json['formats'] != null ? new Formats.fromJson(json['formats']) : null;
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    size = json['size'];
    url = json['url'];
    provider = json['provider'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['alternativeText'] = this.alternativeText;
    data['caption'] = this.caption;
    data['width'] = this.width;
    data['height'] = this.height;
    if (this.formats != null) {
      data['formats'] = this.formats.toJson();
    }
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['size'] = this.size;
    data['url'] = this.url;
    data['provider'] = this.provider;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Formats {
  Thumbnail thumbnail;
  Thumbnail large;
  Thumbnail medium;
  Thumbnail small;

  Formats({this.thumbnail, this.large, this.medium, this.small});

  Formats.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    large =
    json['large'] != null ? new Thumbnail.fromJson(json['large']) : null;
    medium =
    json['medium'] != null ? new Thumbnail.fromJson(json['medium']) : null;
    small =
    json['small'] != null ? new Thumbnail.fromJson(json['small']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
    if (this.large != null) {
      data['large'] = this.large.toJson();
    }
    if (this.medium != null) {
      data['medium'] = this.medium.toJson();
    }
    if (this.small != null) {
      data['small'] = this.small.toJson();
    }
    return data;
  }
}

class Thumbnail {
  String name;
  String hash;
  String ext;
  String mime;
  int width;
  int height;
  double size;
  String url;

  Thumbnail(
      {this.name,
        this.hash,
        this.ext,
        this.mime,
        this.width,
        this.height,
        this.size,
        this.url});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['width'] = this.width;
    data['height'] = this.height;
    data['size'] = this.size;
    data['url'] = this.url;
    return data;
  }}
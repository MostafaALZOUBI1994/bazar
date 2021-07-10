import 'package:easy_localization/easy_localization.dart';

class Advertisment {
  int id;
  String name;
  int subCategory;
  String typeOfAds;
  String governorate;
  String city;
  String category;
  String models;
  //الحالة == المؤهل العلمي (وظائف) == يشمل التوصيل (طبخ حلويات)== حالة الخط(أرقام الهواتف)
  String status;
  String guarantee;
  // العمر(أغنام وجمال)(الخيول)(الطيور)(الحيوانات اليفة)(التحف الانتيك)
  String manufacturingYear;
  // عدد الغرف (عقارات) == المساحة بالدونم(أراضي)== سنوات الخبرة(وظائف)== سعة التخزين (هواتف)
  String kilometers;
  // مغيرالسرعة == جودة القطعة (قطع الغيار) == نوع الوحدة (تكييف) == نوع الفرش (عقارات) == طريقة الدفع(أراضي) == الجنس (وظائف)==طريقة الطلب (طبخ حلويات)== تفاصيل الخط (هواتف)==الميزات(كاميرا و فيديو)== نوع الشبكة(أرقام هواتف) == الجنس(الطيور)(حيوانات أليفة)
  String gear;
  // السعر == الراتب (وظائف)
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
  List<String> imagess;
  String video;
  //قوة المحرك (دراجات)==وضوح الكاميرا (هواتف)(كاميرا فيديو)==العدد(أغنام وجمال)(الخيول)(الطيور)(حيوانات أليفة)
  String enginePower;
  // المحرك (دراجات)==مجمرك (هواتف)(الكترونيات) == نوع الخيل(الخيول)
  String engineSize;

  Advertisment(
      {this.id,
        this.name,
        this.enginePower,
        this.engineSize,
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
    //publishedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(json['published_date']));
    userNumber = json['user_number'];
    views = json['views'];
    publishedAt =  DateFormat('yyyy-MM-dd').format(DateTime.parse(json['published_at']));
    createdAt =DateFormat('yyyy-MM-dd').format(DateTime.parse(json['created_at']));
    updatedAt = DateFormat('yyyy-MM-dd').format(DateTime.parse(json['updated_at']));
    userToken = json['user_token'];
    enginePower =json['engine_power'];
    engineSize=json['engine_size'];
    if (json['imagess'] != null) {
      imagess = new List<String>();
      json['imagess'].forEach((v) {
        imagess.add(v["url"]);
      });
    }
    video =json['video']==null?"": json['video']['url'];
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
    data["engine_power"] =this.enginePower;
    data["engine_size"] =this.engineSize;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['published_date'] = this.publishedDate;
    data['user_number'] = this.userNumber;
    data['views'] = this.views;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_token'] = this.userToken;
    //TODO upload images
    /*
    if (this.imagess != null) {
      data['imagess'] = this.imagess.map((v) => v.toJson()).toList();
    }

     */
    data['video'] = this.video;
    return data;
  }
}

class Imagess {
  String url;

  Imagess(
      {
        this.url,
      });

  Imagess.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
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
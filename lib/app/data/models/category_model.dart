class CategoryModel {
  int id;
  String name;
  String nameAr;
  String publishedAt;
  String createdAt;
  String updatedAt;
  String image;
  List<SubCategory> subCategories;

  CategoryModel({this.id, this.name,  this.nameAr, this.publishedAt, this.createdAt, this.updatedAt, this.image, this.subCategories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image']["formats"]["url"];
    if (json['sub_categories'] != null) {
      subCategories = new List<SubCategory>();
      json['sub_categories'].forEach((v) { subCategories.add(new SubCategory.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.image != null) {
      data['image'] = this.image;
    }
    if (this.subCategories != null) {
      data['sub_categories'] = this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  int id;
  String name;
  int category;
  String nameAr;
  String publishedAt;
  String createdAt;
  String updatedAt;
  String image;
  List<String> kindOfAdvertisment;
  SubCategory({this.id, this.name, this.category, this.nameAr, this.publishedAt, this.createdAt, this.updatedAt, this.image,this.kindOfAdvertisment});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    nameAr = json['name_ar'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image']["url"];
    kindOfAdvertisment=json["KindOfAdvertisment"]==null?[]: json["KindOfAdvertisment"].cast<String>() ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['name_ar'] = this.nameAr;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.image != null) {
      data['image'] = this.image;
    }
    return data;
  }
}

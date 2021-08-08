import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:bazarcom/app/data/models/category_model.dart';
import 'package:bazarcom/app/data/models/user_model.dart';
import 'package:bazarcom/app/global_widgets/loadingText.dart';
import 'package:bazarcom/app/global_widgets/snackbar.dart';
import 'package:bazarcom/app/modules/controllers/auth_controller.dart';
import 'package:bazarcom/app/modules/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:async/async.dart';
import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/data/models/advertisment_model.dart';
import 'package:flutter/material.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:video_compress/video_compress.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import 'home_page.dart';

class AddAdvertisment extends StatefulWidget {
  final HomeController homeController;
  final AuthController authController;
  const AddAdvertisment({Key key, this.homeController, this.authController})
      : super(key: key);
  @override
  _AddAdvertismentState createState() => _AddAdvertismentState();
}

class _AddAdvertismentState extends State<AddAdvertisment> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  CategoryModel selectedCategory;
  SubCategory selectedSubCategory;
  String selectedKindOfAds;
  String selectedStatus;
  String selectedGovernorate;
  String selectedGuarantee;
  String selectedGear;
  String jwt;
  var categoryAd;
  var thumbnail;
  User user;
  List<String> governorates = [
    "دمشق",
    "ريف دمشق",
    "درعا",
    "القنيطرة",
    "حلب",
    "حمص",
    "حماة",
    "دير الزور",
    "الحسكة",
    "الرقة",
    "إدلب",
    "طرطوس",
    "اللاذقية",
    "السويداء"
  ];
  List<CategoryModel> categoryList = [];
  List<File> imagesFile = [];
  var videoFile;
  Advertisment advertisment;
  @override
  void initState() {
    // TODO: implement initState
    categoryList = widget.homeController.categoriesList;
    advertisment = Advertisment(
      name: "",
      category: "",
      city: "",
      description: "",
      enginePower: "",
      engineSize: "",
      gear: "",
      governorate: "",
      guarantee: "",
      imagess: [],
      kilometers: "",
      price: 0,
      manufacturingYear: "",
      models: "",
      status: "",
      subCategory: 0,
      subject: "",
      typeOfAds: "",
      userId: "",
      userNumber: "",
      userToken: "",
      video: "",
      views: "",
      kindOfAdvertisment: "",
    );
    user = widget.authController.user;
    jwt = widget.authController.user.jwt;
    super.initState();
  }

  void addAd() async {
    var ad = await strapiClient.create(
      "advertisments",
      {
        "name": advertisment.name,
        "sub_category": selectedSubCategory.id,
        "type_of_ads": advertisment.kindOfAdvertisment,
        "Governorate": advertisment.governorate,
        "city": advertisment.city,
        "category": advertisment.category,
        "models": advertisment.models,
        "status": advertisment.status,
        "guarantee": advertisment.guarantee,
        "manufacturing_year": advertisment.manufacturingYear,
        "kilometers": advertisment.kilometers,
        "gear": advertisment.gear,
        "price": advertisment.price,
        "subject": "s",
        "description": advertisment.description,
        "user_id": user.id.toString(),
        "user_number": user.phoneNumber,
        "user_token": user.jwt,
        "views": 0,
        "engine_power": advertisment.enginePower,
        "engine_size": advertisment.engineSize
      },
      options: Options(contentType: "application/json", headers: {
        'Authorization': 'Bearer $jwt',
      }),
    );
    print(ad.toString());
    await uploadMultipleImage(imagesFile, ad["id"].toString());
    uploadVideo(videoFile, ad["id"].toString()).then((value) {
      _btnController.success();
      showSnakBarTop("تمت إضافة الإعلان",kColorOfYellowRect);
      Get.off(HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: deviceHieght / 15,
          title: Container(
              child: Image.asset(
            "assets/images/4.png",
            width: deviceWidth / 2,
            height: deviceHieght / 10,
          )),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: deviceHieght / 40,
                ),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kColorOfYellowRect, width: 2),
                        color: kColorOfBlueRect),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          advertisment.name = value;
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 8.0),
                          border: InputBorder.none,
                          hintText: "اسم الإعلان",
                          hintStyle: fieldsHint),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: deviceHieght / 40,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kColorOfYellowRect, width: 2),
                      color: kColorOfBlueRect),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                    hint: Text(
                      "  المحافظة",
                      style: fieldsHint,
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    elevation: 8,
                    value: selectedGovernorate,
                    onChanged: (String value) {
                      setState(() {
                        selectedGovernorate = value;
                        advertisment.governorate = selectedGovernorate;
                      });
                    },
                    underline: Container(
                      color: Colors.amber,
                    ),
                    items: governorates.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            new Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: deviceHieght / 40,
                ),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kColorOfYellowRect, width: 2),
                        color: kColorOfBlueRect),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          advertisment.city = value;
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 8.0),
                          border: InputBorder.none,
                          hintText: "المدينة",
                          hintStyle: fieldsHint),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: deviceHieght / 40,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kColorOfYellowRect, width: 2),
                      color: kColorOfBlueRect),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<CategoryModel>(
                      hint: Text(
                        "  القسم الرئيسي",
                        style: fieldsHint,
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      elevation: 8,
                      value: selectedCategory,
                      underline: Container(
                        color: Colors.amber,
                      ),
                      onChanged: (CategoryModel value) {
                        setState(() {
                          selectedCategory = value;
                          selectedSubCategory = null;
                        });
                      },
                      items: categoryList.map((CategoryModel category) {
                        return DropdownMenuItem<CategoryModel>(
                          value: category,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                category.nameAr,
                                style: fieldsHint,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              selectedCategory == null
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(
                        top: deviceHieght / 40,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: kColorOfYellowRect, width: 2),
                            color: kColorOfBlueRect),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<SubCategory>(
                            hint: Text(
                              "القسم الفرعي",
                              style: fieldsHint,
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            elevation: 8,
                            value: selectedSubCategory,
                            onChanged: (SubCategory value) {
                              setState(() {
                                selectedSubCategory = value;
                                advertisment.subCategory = value.id;
                              });
                            },
                            items: selectedCategory.subCategories
                                .map((SubCategory category) {
                              return DropdownMenuItem<SubCategory>(
                                value: category,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      category.nameAr,
                                      style: fieldsHint,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
              selectedSubCategory == null
                  ? Container()
                  : selectedSubCategory.kindOfAdvertisment.isEmpty
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(
                            top: deviceHieght / 40,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: kColorOfYellowRect, width: 2),
                                    color: kColorOfBlueRect),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                  hint: Text(
                                    "  نوع الإعلان",
                                    style: fieldsHint,
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  elevation: 8,
                                  value: selectedKindOfAds,
                                  onChanged: (String value) {
                                    setState(() {
                                      selectedKindOfAds = value;
                                      advertisment.kindOfAdvertisment =
                                          selectedKindOfAds;
                                    });
                                  },
                                  underline: Container(
                                    color: Colors.amber,
                                  ),
                                  items: selectedSubCategory.kindOfAdvertisment
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          new Text(value),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                )),
                              ),
                              selectedSubCategory
                                      .advertistemntCategories.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                        top: deviceHieght / 40,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: kColorOfYellowRect,
                                                width: 2),
                                            color: kColorOfBlueRect),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                          hint: Text(
                                            " الفئة",
                                            style: fieldsHint,
                                          ),
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                          ),
                                          value: categoryAd,
                                          onChanged: (value) {
                                            setState(() {
                                              categoryAd = value;
                                              advertisment.category = value;
                                            });
                                          },
                                          underline: Container(
                                            color: Colors.amber,
                                          ),
                                          items: selectedSubCategory
                                              .advertistemntCategories
                                              .map((value) {
                                            return DropdownMenuItem(
                                                value: value["name"],
                                                child: Container(
                                                  height: 30,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      new Text(value["name"]),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Image.network(
                                                          value["logo"])
                                                    ],
                                                  ),
                                                ));
                                          }).toList(),
                                        )),
                                      ),
                                    ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: deviceHieght / 40,
                                ),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: kColorOfYellowRect,
                                            width: 2),
                                        color: kColorOfBlueRect),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          advertisment.models = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(right: 8.0),
                                          border: InputBorder.none,
                                          hintText: "الموديل",
                                          hintStyle: fieldsHint),
                                    )),
                              ),
                              selectedSubCategory.status.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                        top: deviceHieght / 40,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: kColorOfYellowRect,
                                                width: 2),
                                            color: kColorOfBlueRect),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                          hint: Text(
                                            selectedSubCategory.id == 10
                                                ? "  المؤهل العلمي"
                                                : selectedSubCategory.id == 33
                                                    ? "  يشمل التوصيل"
                                                    : "  الحالة",
                                            style: fieldsHint,
                                          ),
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                          ),
                                          elevation: 8,
                                          value: selectedStatus,
                                          onChanged: (String value) {
                                            setState(() {
                                              selectedStatus = value;
                                              advertisment.status =
                                                  selectedStatus;
                                            });
                                          },
                                          underline: Container(
                                            color: Colors.amber,
                                          ),
                                          items: selectedSubCategory.status
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  new Text(value),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        )),
                                      ),
                                    ),
                              selectedSubCategory.guarantee.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                        top: deviceHieght / 40,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: kColorOfYellowRect,
                                                width: 2),
                                            color: kColorOfBlueRect),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                          hint: Text(
                                            "  الضمان",
                                            style: fieldsHint,
                                          ),
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                          ),
                                          elevation: 8,
                                          value: selectedGuarantee,
                                          onChanged: (String value) {
                                            setState(() {
                                              selectedGuarantee = value;
                                              advertisment.guarantee =
                                                  selectedGuarantee;
                                            });
                                          },
                                          underline: Container(
                                            color: Colors.amber,
                                          ),
                                          items: selectedSubCategory.guarantee
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  new Text(value),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        )),
                                      ),
                                    ),
                              selectedCategory.id == 1 ||
                                      selectedCategory.id == 9 ||
                                      selectedCategory.id == 10
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: deviceHieght / 40,
                                      ),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: kColorOfYellowRect,
                                                  width: 2),
                                              color: kColorOfBlueRect),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                advertisment.manufacturingYear =
                                                    value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(right: 8.0),
                                                border: InputBorder.none,
                                                hintText:
                                                    selectedCategory.id == 9 ||
                                                            selectedSubCategory
                                                                    .id ==
                                                                47
                                                        ? "العمر"
                                                        : "سنة الصنع",
                                                hintStyle: fieldsHint),
                                          )),
                                    )
                                  : Container(),
                              selectedSubCategory.kilometers.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                        top: deviceHieght / 40,
                                      ),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: kColorOfYellowRect,
                                                  width: 2),
                                              color: kColorOfBlueRect),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                advertisment.kilometers = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(right: 8.0),
                                                border: InputBorder.none,
                                                hintText: selectedSubCategory
                                                    .kilometers,
                                                hintStyle: fieldsHint),
                                          )),
                                    ),
                              selectedSubCategory.gear.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                        top: deviceHieght / 40,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: kColorOfYellowRect,
                                                width: 2),
                                            color: kColorOfBlueRect),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                          hint: Text(
                                            selectedSubCategory.id == 1 ||
                                                    selectedSubCategory.id == 2
                                                ? "  نوع مغير السرعة"
                                                : selectedCategory.id == 8
                                                    ? "  الجنس"
                                                    : selectedSubCategory.id ==
                                                            5
                                                        ? "  جودة القطعة"
                                                        : selectedSubCategory
                                                                    .id ==
                                                                8
                                                            ? "  نوع الوحدة"
                                                            : selectedSubCategory
                                                                        .id ==
                                                                    9
                                                                ? "  نوع الفرش"
                                                                : selectedSubCategory
                                                                            .id ==
                                                                        28
                                                                    ? "  طريقة الدفع"
                                                                    : selectedSubCategory.id ==
                                                                            10
                                                                        ? "  الجنس"
                                                                        : selectedSubCategory.id ==
                                                                                33
                                                                            ? "  طريقة الطلب"
                                                                            : selectedSubCategory.id == 11
                                                                                ? "  تفاصيل الخط"
                                                                                : selectedSubCategory.id == 14
                                                                                    ? "  نوع الشبكة"
                                                                                    : selectedSubCategory.id == 36
                                                                                        ? "  المميزات"
                                                                                        : "",
                                            style: fieldsHint,
                                          ),
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                          ),
                                          elevation: 8,
                                          value: selectedGear,
                                          onChanged: (String value) {
                                            setState(() {
                                              selectedGear = value;
                                              advertisment.gear = selectedGear;
                                            });
                                          },
                                          underline: Container(
                                            color: Colors.amber,
                                          ),
                                          items: selectedSubCategory.gear
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  new Text(value),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        )),
                                      ),
                                    ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: deviceHieght / 40,
                                ),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: kColorOfYellowRect,
                                            width: 2),
                                        color: kColorOfBlueRect),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          advertisment.price = int.parse(value);
                                        });
                                      },
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(right: 8.0),
                                          border: InputBorder.none,
                                          hintText: selectedSubCategory.id == 10
                                              ? "  الراتب"
                                              : "  السعر",
                                          hintStyle: fieldsHint),
                                    )),
                              ),
                              selectedSubCategory.id == 2
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: deviceHieght / 40,
                                      ),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: kColorOfYellowRect,
                                                  width: 2),
                                              color: kColorOfBlueRect),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                advertisment.enginePower =
                                                    value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(right: 8.0),
                                                border: InputBorder.none,
                                                hintText: "  قوة المحرك",
                                                hintStyle: fieldsHint),
                                          )),
                                    )
                                  : Container(),
                              selectedSubCategory.id == 9
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: deviceHieght / 40,
                                      ),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: kColorOfYellowRect,
                                                  width: 2),
                                              color: kColorOfBlueRect),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                advertisment.enginePower =
                                                    value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(right: 8.0),
                                                border: InputBorder.none,
                                                hintText: "  العدد",
                                                hintStyle: fieldsHint),
                                          )),
                                    )
                                  : Container(),
                              selectedSubCategory.id == 11 ||
                                      selectedCategory.id == 36
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: deviceHieght / 40,
                                      ),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: kColorOfYellowRect,
                                                  width: 2),
                                              color: kColorOfBlueRect),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                advertisment.enginePower =
                                                    value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(right: 8.0),
                                                border: InputBorder.none,
                                                hintText: "  وضوح الكاميرا",
                                                hintStyle: fieldsHint),
                                          )),
                                    )
                                  : Container(),
                              selectedSubCategory.id == 2
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: deviceHieght / 40,
                                      ),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: kColorOfYellowRect,
                                                  width: 2),
                                              color: kColorOfBlueRect),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                advertisment.enginePower =
                                                    value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(right: 8.0),
                                                border: InputBorder.none,
                                                hintText: "  حجم المحرك",
                                                hintStyle: fieldsHint),
                                          )),
                                    )
                                  : Container(),
                              selectedSubCategory.id == 11 ||
                                      selectedCategory.id == 35
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: deviceHieght / 40,
                                      ),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: kColorOfYellowRect,
                                                  width: 2),
                                              color: kColorOfBlueRect),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                advertisment.enginePower =
                                                    value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(right: 8.0),
                                                border: InputBorder.none,
                                                hintText: "  مجمرك",
                                                hintStyle: fieldsHint),
                                          )),
                                    )
                                  : Container(),
                              selectedSubCategory.id == 43
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: deviceHieght / 40,
                                      ),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: kColorOfYellowRect,
                                                  width: 2),
                                              color: kColorOfBlueRect),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                advertisment.engineSize = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(right: 8.0),
                                                border: InputBorder.none,
                                                hintText: "  نوع الخيل",
                                                hintStyle: fieldsHint),
                                          )),
                                    )
                                  : Container(),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: deviceHieght / 40,
                                ),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: kColorOfYellowRect,
                                            width: 2),
                                        color: kColorOfBlueRect),
                                    child: TextFormField(
                                      maxLines: null,
                                      onChanged: (value) {
                                        setState(() {
                                          advertisment.description = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(right: 8.0),
                                          border: InputBorder.none,
                                          hintText: "  الوصف",
                                          hintStyle: fieldsHint),
                                    )),
                              ),
                              selectedSubCategory.id == 1
                                  ? InkWell(
                                      onTap: () {
                                        selectVideo();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: deviceHieght / 40,
                                        ),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: kColorOfYellowRect,
                                                    width: 2),
                                                color: kColorOfBlueRect),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text("إضافة فيديو")),
                                            )),
                                      ),
                                    )
                                  : Container(),
                              thumbnail == null
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          top: deviceHieght / 40),
                                      child: Container(
                                          width: deviceWidth / 3,
                                          height: deviceWidth / 3,
                                          child: Image.file(thumbnail)),
                                    )
                            ],
                          ),
                        ),
              InkWell(
                onTap: () {
                  selectImages();
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: deviceHieght / 40,
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: kColorOfYellowRect, width: 2),
                          color: kColorOfBlueRect),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("إضافة صور")),
                      )),
                ),
              ),
              imagesFile.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: deviceHieght / 40),
                      child: GridView.count(
                        crossAxisCount: 5,
                        shrinkWrap: true,
                        children: List.generate(imagesFile.length, (index) {
                          return Container(
                            child: Image.file(imagesFile[index]),
                          );
                        }),
                      ),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.only(
                  top: deviceHieght / 40,
                ),
                child: RoundedLoadingButton(
                  width: deviceWidth,
                  child: Text('إضافة إعلان',
                      style: TextStyle(color: Colors.white)),
                  color: kColorOfYellowRect,
                  controller: _btnController,
                  onPressed: addAd,
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> selectImages() async {
    imagesFile.clear();
    List<Media> _listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 5,
        showGif: false,
        showCamera: true,
        compressSize: 50,
        uiConfig: UIConfig(uiThemeColor: kColorOfBlueRect),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));
    _listImagePaths.forEach((media) {
      imagesFile.add(new File(media.path));
    });
    setState(() {});
    //  uploadMultipleImage(imagesFile);
  }

  Future<void> selectVideo() async {
    final ImagePicker _picker = ImagePicker();
    videoFile = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 60),
    );
    Get.defaultDialog(
        middleText: '',
        barrierDismissible: false,
        content: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: LoadingText(
            text: "يتم ضغط الفيديو الرجاء الانتظار",
            textStyle: TextStyle(color: Colors.white),
            duration: Duration(milliseconds: 500),
          ),
        ),
        backgroundColor: kColorOfYellowRect,
        title: "");
    var video = await VideoCompress.compressVideo(videoFile.path,
        quality: VideoQuality.LowQuality);
    thumbnail = await VideoCompress.getFileThumbnail(video.path);
    Get.back();
    setState(() {});

    //  uploadMultipleImage(imagesFile);
  }

  Future<String> uploadMultipleImage(List<File> files, String adId) async {
// string to uri
    var uri = Uri.parse(baseUrl + "/upload");

// create multipart request
    var request = new http.MultipartRequest("POST", uri);

    for (var file in files) {
      String fileName = file.path.split("/").last;
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));

      // get file length

      var length = await file.length(); //imageFile is your image file

      // multipart that takes file
      var multipartFileSign = new http.MultipartFile('files', stream, length,
          filename: fileName, contentType: MediaType('image', 'png'));
      request.files.add(multipartFileSign);
    }
    Map<String, String> headers = {
      "Accept": "application/json",
      'Authorization': "Bearer $jwt"
    };

//add headers
    request.headers.addAll(headers);

//adding params
    request.fields['ref'] = "advertisment";
    request.fields['refId'] = adId;
    request.fields['field'] = 'imagess';

// send
    var responseStream = await request.send();
    var response = await responseStream.stream.bytesToString();
    json
        .decode(response.toString())
        .map((data) => advertisment.imagess.add(data["url"]))
        .toList();
  }

  Future<String> uploadVideo(XFile file, String id) async {
// string to uri
    var uri = Uri.parse(baseUrl + "/upload");

// create multipart request
    var request = new http.MultipartRequest("POST", uri);

    String fileName = file.path.split("/").last;
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));

    // get file length

    var length = await file.length(); //imageFile is your image file

    // multipart that takes file
    var multipartFileSign = new http.MultipartFile('files', stream, length,
        filename: fileName, contentType: MediaType('video', 'mp4'));
    request.files.add(multipartFileSign);

    Map<String, String> headers = {
      "Accept": "application/json",
      'Authorization': "Bearer $jwt"
    };

//add headers
    request.headers.addAll(headers);
    //adding params
    request.fields['ref'] = "advertisment";
    request.fields['refId'] = id;
    request.fields['field'] = 'video';
// send
    var responseStream = await request.send();
    var response = await responseStream.stream.bytesToString();
    print(json.decode(response.toString()));
  }
}

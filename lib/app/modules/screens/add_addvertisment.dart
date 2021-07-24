import 'dart:io';
import 'dart:convert';
import 'package:bazarcom/app/data/models/category_model.dart';
import 'package:bazarcom/app/global_widgets/textfield.dart';
import 'package:bazarcom/app/modules/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:async/async.dart';
import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/data/models/advertisment_model.dart';
import 'package:flutter/material.dart';
import 'package:image_pickers/image_pickers.dart';

class AddAdvertisment extends StatefulWidget {
  final HomeController homeController;
  const AddAdvertisment({
    Key key,
    this.homeController,
  }) : super(key: key);
  @override
  _AddAdvertismentState createState() => _AddAdvertismentState();
}

class _AddAdvertismentState extends State<AddAdvertisment> {
  CategoryModel selectedCategory;
  SubCategory selectedSubCategory;
  String selectedKindOfAds;
  List<CategoryModel> categoryList = [];
  List<String> kindsOfAds = [];

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
        kindOfAdvertisment: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          SizedBox(
            height: Get.height / 40,
          ),
          TextFieldWidget(
            hint: "اسم الإعلان",
          ),
          SizedBox(
            height: Get.height / 40,
          ),
          Container(
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
          SizedBox(
            height: Get.height / 40,
          ),
          selectedCategory == null
              ? Container()
              : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kColorOfYellowRect, width: 2),
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
                          kindsOfAds = selectedSubCategory.kindOfAdvertisment;
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
          SizedBox(
            height: Get.height / 40,
          ),
          selectedSubCategory == null
              ? Container()
              : selectedSubCategory.kindOfAdvertisment.isEmpty
                  ? Container()
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: kColorOfYellowRect, width: 2),
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
                        elevation: 8, value: selectedKindOfAds,
                            onChanged: (String value) {
                              setState(() {
                               selectedKindOfAds = value;
                                advertisment.kindOfAdvertisment = selectedKindOfAds;
                              });
                            },

                        underline: Container(
                          color: Colors.amber,
                        ),

                        items: kindsOfAds
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
          FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () async {
                selectImages();
                uploadMultipleImage;
                /*
                  strapiClient.create(
                    "advertisments",
                    {
                      "name": "string",
                      "sub_category": "1",
                      "type_of_ads": "string",
                      "Governorate": "string",
                      "city": "string",
                      "category": "string",
                      "models": "string",
                      "status": "string",
                      "guarantee": "string",
                      "manufacturing_year": "string",
                      "kilometers": "string",
                      "gear": "string",
                      "price": 0,
                      "subject": "string",
                      "description": "string",
                      "user_id": "string",
                      "user_number": "string",
                      "user_token": "string",
                      "views": 0,
                      "engine_power": "string",
                      "engine_size": "string"
                    },
                    options: Options(contentType: "application/json", headers: {
                      'Authorization':
                          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDcsImlhdCI6MTYyNjI1OTUyOSwiZXhwIjoxNjI4ODUxNTI5fQ.5s_rN5MuU7O6EoCfaM6fppEEIN1oeSGJuoz1rpBWRYA',
                    }),
                  );
                   */
              })
        ],
      ),
    ));
  }

  Future<void> selectImages() async {
    List<File> imagesFile = [];
    List<Media> _listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 2,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: kColorOfBlueRect),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));
    _listImagePaths.forEach((media) {
      imagesFile.add(new File(media.path));
    });
    uploadMultipleImage(imagesFile);
  }

  Future<String> uploadMultipleImage(List<File> files) async {
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
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDcsImlhdCI6MTYyNjI5MDA5NCwiZXhwIjoxNjI4ODgyMDk0fQ.HSbQvyEv8qU-kjJTh3FqZDbIhUtdS3YA2hGMgSL8Bc0"
    };

//add headers
    request.headers.addAll(headers);

//adding params
    //   request.fields['id'] = userid;
// request.fields['firstName'] = 'abc';
// request.fields['lastName'] = 'efg';

// send
    var response = await request.send();

    print(response.statusCode);

// listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}

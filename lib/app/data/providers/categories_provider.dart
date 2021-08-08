import 'dart:convert';
import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/data/models/advertisment_model.dart';
import 'package:bazarcom/app/data/models/category_model.dart';
import 'package:bazarcom/app/utils/utils/locale_keys.g.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryApi {
  final http.Client httpClient;
  CategoryApi({@required this.httpClient});
  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json'
  };

  Future<List<CategoryModel>> getAllCategory() async {
    List<CategoryModel> categories = [];
    try {
      final response = await httpClient.get(Uri.parse(baseUrl + "/categories"));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
         jsonResponse
            .map((json) => categories.add(CategoryModel.fromJson(json)))
            .toList();
         return categories;
      } else {
        print('Error -getAll');
      }
    } catch (ex) {
      print("getAllCategories " + ex.toString());
    }
    return categories;
  }

  Future getId(id) async {
    try {
      final response = await httpClient.get(Uri.parse(baseUrl + "/$id"));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      } else {
        print('Error -getId');
      }
    } catch (ex) {
      print("getCategoryById " + ex.toString());
    }
    return null;
  }

  getFieldsRelatedToSubCategories(
      int subCategoryId, Advertisment advertisment) {
    var initialFields = {
      LocaleKeys.adsName.tranlation(): advertisment.name,
      LocaleKeys.price.tranlation(): advertisment.price,
      LocaleKeys.views.tranlation(): advertisment.views,
      LocaleKeys.adsDate.tranlation(): advertisment.publishedAt,
      LocaleKeys.department.tranlation(): advertisment.category,
      LocaleKeys.governorate.tranlation(): advertisment.governorate,
      LocaleKeys.adsType.tranlation(): advertisment.typeOfAds,
      LocaleKeys.category.tranlation(): advertisment.category
    };

    switch (subCategoryId) {
      case 1:
         initialFields.addAll({
          LocaleKeys.model.tranlation(): advertisment.models,
          LocaleKeys.manufactureYear.tranlation(): advertisment.manufacturingYear,
          LocaleKeys.status.tranlation(): advertisment.status,
          LocaleKeys.guarantee.tranlation(): advertisment.guarantee,
           LocaleKeys.kilometers.tranlation():advertisment.kilometers,
        });
        break;

      case 2:
        initialFields.addAll({
          LocaleKeys.gear.tranlation(): advertisment.gear,
          LocaleKeys.manufactureYear.tranlation(): advertisment.manufacturingYear,
          LocaleKeys.engineSize.tranlation(): advertisment.engineSize,
          LocaleKeys.enginePower.tranlation(): advertisment.enginePower,
          LocaleKeys.kilometers.tranlation():advertisment.kilometers
        });
        break;

      case 3:
        initialFields.addAll({
          LocaleKeys.manufactureYear.tranlation(): advertisment.manufacturingYear,
          LocaleKeys.status.tranlation(): advertisment.status,
        });
        break;
      case 4 :
        initialFields.addAll({
          LocaleKeys.manufactureYear.tranlation(): advertisment.manufacturingYear,
          LocaleKeys.status.tranlation(): advertisment.status,
        });
        break;
      case 5 :
        initialFields.addAll({
          LocaleKeys.widgetQuality.tranlation(): advertisment.gear,
          LocaleKeys.status.tranlation(): advertisment.status,
        });
        break;
      case 8 :
        initialFields.addAll({
          LocaleKeys.unitType.tranlation(): advertisment.gear,
          LocaleKeys.guarantee.tranlation():advertisment.guarantee,
          LocaleKeys.status.tranlation(): advertisment.status,
        });
        break;
        //real state
      case 9 :
        initialFields.addAll({
          LocaleKeys.typeOfFurniture.tranlation(): advertisment.gear,
          LocaleKeys.numberOfRooms.tranlation():advertisment.kilometers,
        });
        break;
      case 10 :
        initialFields.remove("price");
        initialFields.addAll({
          LocaleKeys.sex.tranlation(): advertisment.gear,
          LocaleKeys.qualification.tranlation():advertisment.status,
          LocaleKeys.experience.tranlation():advertisment.kilometers,
          LocaleKeys.salary.tranlation():advertisment.price
        });
        break;
//phone
      case 11 :
        initialFields.addAll({
          LocaleKeys.sim.tranlation(): advertisment.gear,
          LocaleKeys.storage.tranlation():advertisment.kilometers,
          LocaleKeys.cameraResolution.tranlation():advertisment.enginePower,
          LocaleKeys.customs.tranlation():advertisment.engineSize
        });
        break;
      case 14 :
        initialFields.addAll({
          LocaleKeys.status.tranlation(): advertisment.status,
          LocaleKeys.network.tranlation():advertisment.gear,
        });
        break;
      case 15 :
        initialFields.addAll({
          LocaleKeys.age.tranlation(): advertisment.manufacturingYear,
          LocaleKeys.number.tranlation():advertisment.enginePower,
        });
        break;
      case 28 :
        initialFields.addAll({
          LocaleKeys.paymentMethod.tranlation(): advertisment.gear,
          LocaleKeys.space.tranlation():advertisment.kilometers,
        });
        break;
      case 29 :
        initialFields.addAll({
          LocaleKeys.status.tranlation(): advertisment.status,
        });
        break;
      case 30 :
        initialFields.addAll({
          LocaleKeys.status.tranlation(): advertisment.status,
        });
        break;
      case 31 :
        initialFields.addAll({
          LocaleKeys.status.tranlation(): advertisment.status,
        });
        break;
      case 32 :
        initialFields.addAll({
          LocaleKeys.status.tranlation(): advertisment.status,
        });
        break;
      case 35 :
        initialFields.addAll({
          LocaleKeys.guarantee.tranlation(): advertisment.guarantee,
          LocaleKeys.customs.tranlation(): advertisment.engineSize,
        });
        break;
      case 36 :
        initialFields.addAll({
          LocaleKeys.specification.tranlation(): advertisment.gear,
          LocaleKeys.cameraResolution.tranlation(): advertisment.enginePower,
          LocaleKeys.guarantee.tranlation(): advertisment.guarantee,
        });
        break;
      case 43 :
        initialFields.addAll({
          LocaleKeys.horseType.tranlation(): advertisment.engineSize,
          LocaleKeys.number.tranlation(): advertisment.enginePower,
          LocaleKeys.age.tranlation(): advertisment.manufacturingYear,

        });
        break;
      case 44 :
        initialFields.addAll({
          LocaleKeys.number.tranlation(): advertisment.enginePower,
          LocaleKeys.sex.tranlation(): advertisment.gear,
          LocaleKeys.age.tranlation(): advertisment.manufacturingYear,
        });
        break;
      case 45 :
        initialFields.addAll({
          LocaleKeys.number.tranlation(): advertisment.enginePower,
          LocaleKeys.sex.tranlation(): advertisment.gear,
          LocaleKeys.age.tranlation(): advertisment.manufacturingYear,
        });
        break;
      case 47 :
        initialFields.addAll({
          LocaleKeys.age.tranlation(): advertisment.manufacturingYear,
        });
        break;
      default:
         initialFields;
    }
    return initialFields;
  }
}

/*
  ad() async {
Uri url=Uri.parse("http://192.168.1.105:1337/advertisments") ;
var response = await http.get(url);
print(response.body.toString());
    Map<String,String> headerspost = {
      'Content-Type':'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    };

    print("dd"+response.body.toString());
  }
 */

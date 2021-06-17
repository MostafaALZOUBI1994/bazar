import 'dart:convert';
import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/data/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';



class CategoryApi {
  final http.Client httpClient;
  CategoryApi({@required this.httpClient});
  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json'
  };

  Future<List<CategoryModel>> getAllCategory() async {
    List<CategoryModel> categories=[];
    try {
      final response = await httpClient.get(Uri.parse(baseUrl+"/categories"));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse
            .map((json) => categories.add(CategoryModel.fromJson(json)))
            .toList();
      } else {
        print('Error -getAll');
      }
    } catch (ex) {print("getAllCategories "+ex.toString());}
return categories;
  }

  Future getId(id) async {
    try {
      final response = await httpClient.get(Uri.parse(baseUrl+"/$id"));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      } else{
        print('Error -getId');
      }
    } catch (ex) {print("getAllCategories "+ex.toString());}
    return null;
  }
}

/*
  ad() async {
Uri url=Uri.parse("http://192.168.1.105:1337/advertisments") ;var response = await http.get(url);
print(response.body.toString());


    Map<String,String> headerspost = {
      'Content-Type':'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    };



    print("dd"+response.body.toString());
  }
 */
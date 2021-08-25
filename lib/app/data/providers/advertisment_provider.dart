import 'dart:convert';
import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/data/models/advertisment_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

class AdvertismentApiClient {
  final http.Client httpClient;

  AdvertismentApiClient({@required this.httpClient});

  Future<List<Advertisment>> getAdvertisment(int subCategoryId) async {
    List<Advertisment> advertisments = [];
    try {
      final response = await httpClient
          .get(Uri.parse("$baseUrl/sub-categories/$subCategoryId"));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List ads = jsonResponse["advertisments"];
        ads.forEach((element) {
          advertisments.add(Advertisment.fromJson(element));
        });
      } else {
        print('Error -getAll');
      }
    } catch (ex) {
      print("getAdsgfhhhhhhhhhhhhhhh" + ex.toString());
    }
    return advertisments;
  }

  Future<List<Advertisment>> getMyAdvertisment(int userId) async {
    List<Advertisment> advertisments = [];
    try {
      final response = await httpClient
          .get(Uri.parse("$baseUrl/advertisments?user_id_eq=$userId"));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        jsonResponse.forEach((element) {
          advertisments.add(Advertisment.fromJson(element));
        });
      } else {
        print('Error -getAll');
      }
    } catch (ex) {
      print("getAdsgfhhhhhhhhhhhhhhh" + ex.toString());
    }
    return advertisments;
  }

  Future addView(String advertismentId, String views) async {
    int newView = int.parse(views) + 1;
    try {
      var res = await Dio().put("$baseUrl/advertisments/$advertismentId",
          data: jsonEncode({"views": newView.toString()}),
          options: Options(contentType: "application/json"));
      print(res.data.toString());
    } catch (ex) {
      print("view " + ex.toString());
    }
  }

  Future removeAdvertisment(int advertismentId, String jwt) async {
    try {
      var res = await Dio().delete("$baseUrl/advertisments/$advertismentId",
          options: Options(contentType: "application/json",headers: {
            'Authorization': 'Bearer $jwt',
          }));
      print(res.data.toString());
    } catch (ex) {
      print("removebyid" + ex.toString());
    }
  }
}

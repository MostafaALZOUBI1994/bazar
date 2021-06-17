import 'dart:convert';
import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/data/models/advertisment_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class AdvertismentApiClient {
  final http.Client httpClient;

  AdvertismentApiClient({@required this.httpClient});

  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json'
  };

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
}

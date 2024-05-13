import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rentcarapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:rentcarapp/models/combobox/combomobil_model.dart';

class ComboMobilAPI {
  String urlGetComboEndPoint =
      "${AppData.prefixEndPoint}/api/mmobilcombobox/getlist";

  Future<List<ComboMobilModel>> getComboMobilAPI(String filter) async {
    Map<String, String> queryParams = {"filter": filter};
    var uri = AppData.uriHtpp(
        AppData.httpAuthority, urlGetComboEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("response.statusCode : ${response.statusCode}");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ComboMobilModel>((json) => ComboMobilModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}

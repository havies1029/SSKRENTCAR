import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rentcarapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:rentcarapp/models/mstmobil/mobilcari_model.dart';

class MobilCariAPI {
  String urlGetListEndPoint =
      "${AppData.prefixEndPoint}/api/mstmobil/mobilcari/getlist";

  Future<List<MobilCariModel>> getMobilCariAPI(
      String searchText, int hal) async {
    Map<String, String> queryParams = {
      "searchText": searchText,
      "hal": hal.toString()
    };
    var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("getMobilCariAPI #10");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      try {
        json.decode(response.body).cast<Map<String, dynamic>>();
      } catch (e) {
        debugPrint("error #10 : ${e.toString()}");
      }

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      debugPrint("getMobilCariAPI #20");

      try {
        parsed
          .map<MobilCariModel>((json) => MobilCariModel.fromJson(json))
          .toList();
      } catch (e) {
        debugPrint("error #20 : ${e.toString()}");
      }

      return parsed
          .map<MobilCariModel>((json) => MobilCariModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}

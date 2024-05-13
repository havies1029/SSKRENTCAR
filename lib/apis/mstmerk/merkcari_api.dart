import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rentcarapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:rentcarapp/models/mstmerk/merkcari_model.dart';

String urlGetListEndPoint =
    "${AppData.prefixEndPoint}/api/mstmerk/merkcari/getlist";

Future<List<MerkCariModel>> getMerkCariAPI(String searchText, int hal) async {
  debugPrint("getMerkCariAPI #10");
  debugPrint("urlGetListEndPoint : $urlGetListEndPoint");

  Map<String, String> queryParams = {
    "searchText": searchText,
    "hal": hal.toString()
  };

  debugPrint("queryParams : ${jsonEncode(queryParams)}");

  var uri =
      AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
  final http.Response response = await http.get(uri, headers: <String, String>{
    'Content-Type': 'application/json; odata=verbos',
    'Accept': 'application/json; odata=verbos',
    'Authorization': 'Bearer ${AppData.userToken}'
  });
  debugPrint("getMerkCariAPI #20");
  debugPrint("response.statusCode : ${response.statusCode}");
  debugPrint(response.body);

  if (response.statusCode == 200) {
    try {
      json.decode(response.body).cast<Map<String, dynamic>>();
    } catch (e) {
      debugPrint("error #10 : ${e.toString()}");
    }
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    debugPrint("getMerkCariAPI #30");

    try {
      parsed
          .map<MerkCariModel>((json) => MerkCariModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("error #20 : ${e.toString()}");
    }

    debugPrint("getMerkCariAPI #40");

    return parsed
        .map<MerkCariModel>((json) => MerkCariModel.fromJson(json))
        .toList();
  } else {
    throw Exception("Failed to load data");
  }
}

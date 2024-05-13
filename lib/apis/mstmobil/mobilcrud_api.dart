import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rentcarapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/models/mstmobil/mobilcrud_model.dart';

class MobilCrudAPI {
  Future<ReturnDataAPI> mobilCrudTambahAPI(MobilCrudModel record) async {
    String tambahEndpoint =
        "${AppData.prefixEndPoint}/api/mstmobil/mobilcrud/create";
    Map<String, String> queryParams = {"modul_id": "mobilCrudTambahAPI"};
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, tambahEndpoint, queryParams);

    ReturnDataAPI returnData;
    final http.Response response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; odata=verbos',
          'Accept': 'application/json; odata=verbos',
          'Authorization': 'Bearer ${AppData.userToken}'
        },
        body: jsonEncode(record.toJson()));

    if (response.statusCode == 200) {
      returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
    } else {
      returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
    }
    return returnData;
  }

  Future<bool> mobilCrudUbahAPI(MobilCrudModel record) async {
    String ubahEndpoint =
        "${AppData.prefixEndPoint}/api/mstmobil/mobilcrud/update";
    Map<String, String> queryParams = {"modul_id": "mobilCrudUbahAPI"};

    var uri = AppData.uriHtpp(AppData.httpAuthority, ubahEndpoint, queryParams);

    final http.Response response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; odata=verbos',
          'Accept': 'application/json; odata=verbos',
          'Authorization': 'Bearer ${AppData.userToken}'
        },
        body: jsonEncode(record.toJson()));

    ReturnDataAPI returnData;
    if (response.statusCode == 200) {
      returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
    } else {
      returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
    }
    return returnData.success;
  }

  Future<bool> mobilCrudHapusAPI(String mmobilId) async {
    String hapusEndpoint =
        "${AppData.prefixEndPoint}/api/mstmobil/mobilcrud/delete";
    Map<String, String> queryParams = {
      'mmobilId': mmobilId,
      'modul_id': 'mobilCrudHapusAPI'
    };
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, hapusEndpoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    ReturnDataAPI returnData;
    if (response.statusCode == 200) {
      returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
    } else {
      returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
    }
    return returnData.success;
  }

  Future<MobilCrudModel> mobilCrudLihatAPI(String mmobilId) async {
    String lihatEndpoint =
        "${AppData.prefixEndPoint}/api/mstmobil/mobilcrud/read";
    Map<String, String> queryParams = {'mmobilId': mmobilId};
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("mobilCrudLihatAPI #10");
    debugPrint("response.body : ${response.body}");

    try {
      MobilCrudModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      debugPrint("mobilCrudLihatAPI : ${e.toString()}");
    }

    if (response.statusCode == 200) {
      var returnData = MobilCrudModel.fromJson(jsonDecode(response.body));
      return returnData;
    } else {
      return throw Exception("Failed to load data");
    }
  }
}

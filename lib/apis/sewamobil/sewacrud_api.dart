import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rentcarapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/models/sewamobil/sewacrud_model.dart';

class SewaCrudAPI {
  Future<ReturnDataAPI> sewaCrudTambahAPI(SewaCrudModel record) async {
    String tambahEndpoint =
        "${AppData.prefixEndPoint}/api/sewamobil/sewacrud/create";
    Map<String, String> queryParams = {"modul_id": "sewaCrudTambahAPI"};
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

  Future<bool> sewaCrudUbahAPI(SewaCrudModel record) async {
    String ubahEndpoint =
        "${AppData.prefixEndPoint}/api/sewamobil/sewacrud/update";
    Map<String, String> queryParams = {"modul_id": "sewaCrudUbahAPI"};

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

  Future<bool> sewaCrudHapusAPI(String sewa1Id) async {
    String hapusEndpoint =
        "${AppData.prefixEndPoint}/api/sewamobil/sewacrud/delete";
    Map<String, String> queryParams = {
      'sewa1Id': sewa1Id,
      'modul_id': 'sewaCrudHapusAPI'
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

  Future<SewaCrudModel> sewaCrudLihatAPI(String sewa1Id) async {
    String lihatEndpoint =
        "${AppData.prefixEndPoint}/api/sewamobil/sewacrud/read";
    Map<String, String> queryParams = {'sewa1Id': sewa1Id};
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("sewaCrudLihatAPI #10");
    debugPrint("sewaCrudLihatAPI jsonDecode(response.body) ${jsonDecode(response.body)}");
    try {
      SewaCrudModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      debugPrint("sewaCrudLihatAPI error : ${e.toString()}");
    }
    debugPrint("sewaCrudLihatAPI #20");

    if (response.statusCode == 200) {
      var returnData = SewaCrudModel.fromJson(jsonDecode(response.body));
      return returnData;
    } else {
      return throw Exception("Failed to load data");
    }
  }
}

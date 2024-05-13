import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rentcarapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/models/mstmerk/merkcrud_model.dart';

class MerkCrudAPI {
  Future<ReturnDataAPI> merkCrudTambahAPI(MerkCrudModel record) async {
    String tambahEndpoint =
        "${AppData.prefixEndPoint}/api/mstmerk/merkcrud/create";
    Map<String, String> queryParams = {'modul_id': "merkCrudTambahAPI"};
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, tambahEndpoint, queryParams);

    ReturnDataAPI returnData;
    //final http.Response response = await http.post(Uri.parse(tambahURL),
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

  Future<bool> merkCrudUbahAPI(MerkCrudModel record) async {
    debugPrint("merkCrudUbahAPI");
    String ubahEndpoint =
        "${AppData.prefixEndPoint}/api/mstmerk/merkcrud/update";
    Map<String, String> queryParams = {'modul_id': "merkCrudUbahAPI"};
    var uri = AppData.uriHtpp(AppData.httpAuthority, ubahEndpoint, queryParams);

    final http.Response response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; odata=verbos',
          'Accept': 'application/json; odata=verbos',
          'Authorization': 'Bearer ${AppData.userToken}'
        },
        body: jsonEncode(record.toJson()));

    debugPrint("response.statusCode : ${response.statusCode}");

    ReturnDataAPI returnData;
    if (response.statusCode == 200) {
      returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
    } else {
      returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
    }

    return returnData.success;
  }

  Future<bool> merkCrudHapusAPI(String mmerkId) async {
    debugPrint("merkCrudHapusAPI");

    String hapusEndpoint =
        "${AppData.prefixEndPoint}/api/mstmerk/merkcrud/delete";
    Map<String, String> queryParams = {
      'mmerkId': mmerkId,
      'modul_id': 'merkCrudHapusAPI'
    };
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, hapusEndpoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("response.statusCode : ${response.statusCode}");
    
    ReturnDataAPI returnData;
    if (response.statusCode == 200) {
      returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
    } else {
      returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
    }

    return returnData.success;
  }

  Future<MerkCrudModel> merkCrudLihatAPI(String mmerkId) async {
    debugPrint("merkCrudLihatAPI");

    String lihatEndpoint =
        "${AppData.prefixEndPoint}/api/mstmerk/merkcrud/read";
    Map<String, String> queryParams = {'mmerkId': mmerkId};
    var uri =
        AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    debugPrint("response.statusCode : ${response.statusCode}");

    if (response.statusCode == 200) {
      var returnData = MerkCrudModel.fromJson(jsonDecode(response.body));
      return returnData;
    } else {
      return throw Exception("Failed to load data");
    }
  }
}

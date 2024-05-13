import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rentcarapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/models/mststaff/staffcrud_model.dart';

class StaffCrudAPI {

	Future<ReturnDataAPI> staffCrudTambahAPI(StaffCrudModel record) async {
		String tambahEndpoint =
			"${AppData.prefixEndPoint}/api/mststaff/staffcrud/create";
		Map<String, String> queryParams = {"modul_id": "staffCrudTambahAPI"};
		var uri = AppData.uriHtpp(AppData.httpAuthority, tambahEndpoint, queryParams);

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
	Future<bool> staffCrudUbahAPI(StaffCrudModel record) async {
		String ubahEndpoint =
			"${AppData.prefixEndPoint}/api/mststaff/staffcrud/update";
		Map<String, String> queryParams = {"modul_id": "staffCrudUbahAPI"};

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
	Future<bool> staffCrudHapusAPI(String mstaffId) async {
		String hapusEndpoint = "${AppData.prefixEndPoint}/api/mststaff/staffcrud/delete";
		Map<String, String> queryParams = {
			'mstaffId': mstaffId,
			'modul_id': 'staffCrudHapusAPI'};
		var uri = AppData.uriHtpp(AppData.httpAuthority, hapusEndpoint, queryParams);
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
	Future<StaffCrudModel> staffCrudLihatAPI(String mstaffId) async {
    
    debugPrint("staffCrudLihatAPI");

		String lihatEndpoint = "${AppData.prefixEndPoint}/api/mststaff/staffcrud/read";
		Map<String, String> queryParams = {'mstaffId': mstaffId};
		var uri = AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

    
    debugPrint("staffCrudLihatAPI response.body : ${response.body}");

		if (response.statusCode == 200) {
			var returnData = StaffCrudModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
	}
}

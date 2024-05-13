import 'dart:convert';
import 'package:rentcarapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/models/mstrekan/rekancrud_model.dart';

class RekanCrudAPI {

	Future<ReturnDataAPI> rekanCrudTambahAPI(RekanCrudModel record) async {
		String tambahEndpoint =
			"${AppData.prefixEndPoint}/api/mstrekan/rekancrud/create";
		Map<String, String> queryParams = {"modul_id": "rekanCrudTambahAPI"};
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
	Future<bool> rekanCrudUbahAPI(RekanCrudModel record) async {
		String ubahEndpoint =
			"${AppData.prefixEndPoint}/api/mstrekan/rekancrud/update";
		Map<String, String> queryParams = {"modul_id": "rekanCrudUbahAPI"};

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
	Future<bool> rekanCrudHapusAPI(String mrekanId) async {
		String hapusEndpoint = "${AppData.prefixEndPoint}/api/mstrekan/rekancrud/delete";
		Map<String, String> queryParams = {
			'mrekanId': mrekanId,
			'modul_id': 'rekanCrudHapusAPI'};
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
	Future<RekanCrudModel> rekanCrudLihatAPI(String mrekanId) async {
		String lihatEndpoint = "${AppData.prefixEndPoint}/api/mstrekan/rekancrud/read";
		Map<String, String> queryParams = {'mrekanId': mrekanId};
		var uri = AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			var returnData = RekanCrudModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
	}
}

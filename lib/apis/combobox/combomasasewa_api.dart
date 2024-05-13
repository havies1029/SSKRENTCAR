import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:rentcarapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:rentcarapp/models/combobox/combomasasewa_model.dart';

class ComboMasasewaAPI {
	
	Future<List<ComboMasasewaModel>> getComboMasasewaAPI() async {	
    String urlGetComboEndPoint = "${AppData.prefixEndPoint}/api/mmasacombobox/getlist";	
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

    //debugPrint("response.statusCode : ${response.statusCode}");
    //debugPrint("response.body : ${response.body}");

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<ComboMasasewaModel>((json) => ComboMasasewaModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}

  Future<ComboMasasewaModel> getInitValueComboMasaSewaAPI() async {	
    String urlEndPoint = "${AppData.prefixEndPoint}/api/mmasacombobox/initvalue";	
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlEndPoint);
		final http.Response response = await http.get(uri, headers: AppData.httpHeaders);

    debugPrint("response.statusCode : ${response.statusCode}");
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
			var returnData = ComboMasasewaModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
	}

}

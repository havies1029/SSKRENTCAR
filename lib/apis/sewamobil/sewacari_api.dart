import 'dart:convert';
import 'package:rentcarapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:rentcarapp/models/sewamobil/sewacari_model.dart';

class SewaCariAPI{
	String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/sewamobil/sewacari/getlist";

	Future<List<SewaCariModel>> getSewaCariAPI(String searchText, int hal) async {
		Map<String, String> queryParams = {"searchText": searchText, "hal": hal.toString()};
		var uri = Uri.http(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<SewaCariModel>((json) => SewaCariModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}

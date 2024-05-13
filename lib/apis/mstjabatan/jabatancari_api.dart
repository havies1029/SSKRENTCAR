import 'dart:convert';
import 'package:rentcarapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:rentcarapp/models/mstjabatan/jabatancari_model.dart';

class JabatanCariAPI{
	String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/mstjabatan/jabatancari/getlist";

	Future<List<JabatanCariModel>> getJabatanCariAPI(String searchText, int hal) async {
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
				.map<JabatanCariModel>((json) => JabatanCariModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}

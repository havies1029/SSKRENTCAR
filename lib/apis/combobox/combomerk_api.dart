import 'dart:convert';
import 'package:rentcarapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:rentcarapp/models/combobox/combomerk_model.dart';

String urlGetComboEndPoint = "${AppData.prefixEndPoint}/api/mmerkcombobox/getlist";

Future<List<ComboMerkModel>> getComboMerkAPI(String filter) async {
	Map<String, String> queryParams = {"filter": filter};
	var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint, queryParams);
	final http.Response response = await http.get(uri, headers: <String, String>{
		'Content-Type': 'application/json; odata=verbos',
		'Accept': 'application/json; odata=verbos',
		'Authorization': 'Bearer ${AppData.userToken}'
	});

	if (response.statusCode == 200) {
		final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
		return parsed
			.map<ComboMerkModel>((json) => ComboMerkModel.fromJson(json))
			.toList();
	} else {
		throw Exception("Failed to load data");
	}
}

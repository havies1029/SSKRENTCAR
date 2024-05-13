import 'dart:convert';
import 'package:rentcarapp/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:rentcarapp/models/combobox/combowilayah_model.dart';

class ComboWilayahAPI {
  Future<List<ComboWilayahModel>> getComboWilayahAPI() async {
    String urlEndPoint =
        "${AppData.prefixEndPoint}/api/mwilayahcombobox/getlist";
    var uri = AppData.uriHtpp(AppData.httpAuthority, urlEndPoint);
    final http.Response response =
        await http.get(uri, headers: AppData.httpHeaders);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ComboWilayahModel>((json) => ComboWilayahModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<ComboWilayahModel> getInitValueComboWilayahAPI() async {
    String urlEndPoint =
        "${AppData.prefixEndPoint}/api/mwilayahcombobox/initvalue";
    var uri = AppData.uriHtpp(AppData.httpAuthority, urlEndPoint);
    final http.Response response =
        await http.get(uri, headers: AppData.httpHeaders);

		if (response.statusCode == 200) {
			var returnData = ComboWilayahModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
  }
}

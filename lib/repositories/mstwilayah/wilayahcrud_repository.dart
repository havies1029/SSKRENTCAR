import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/apis/mstwilayah/wilayahcrud_api.dart';
import 'package:rentcarapp/models/mstwilayah/wilayahcrud_model.dart';

class WilayahCrudRepository {

	WilayahCrudAPI api = WilayahCrudAPI();

	Future<ReturnDataAPI> wilayahCrudTambah(WilayahCrudModel record) async {
		return await api.wilayahCrudTambahAPI(record);
	}
	Future<bool> wilayahCrudUbah(WilayahCrudModel record) async {
		return await api.wilayahCrudUbahAPI(record);
	}
	Future<bool> wilayahCrudHapus(String mwilayahId) async {
		return await api.wilayahCrudHapusAPI(mwilayahId);
	}
	Future<WilayahCrudModel> wilayahCrudLihat(String mwilayahId) async {
		return await api.wilayahCrudLihatAPI(mwilayahId);
	}
}

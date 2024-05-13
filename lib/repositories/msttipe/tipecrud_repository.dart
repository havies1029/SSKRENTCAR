import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/apis/msttipe/tipecrud_api.dart';
import 'package:rentcarapp/models/msttipe/tipecrud_model.dart';

class TipeCrudRepository {

	TipeCrudAPI api = TipeCrudAPI();

	Future<ReturnDataAPI> tipeCrudTambah(TipeCrudModel record) async {
		return await api.tipeCrudTambahAPI(record);
	}
	Future<bool> tipeCrudUbah(TipeCrudModel record) async {
		return await api.tipeCrudUbahAPI(record);
	}
	Future<bool> tipeCrudHapus(String mtipeId) async {
		return await api.tipeCrudHapusAPI(mtipeId);
	}
	Future<TipeCrudModel> tipeCrudLihat(String mtipeId) async {
		return await api.tipeCrudLihatAPI(mtipeId);
	}
}

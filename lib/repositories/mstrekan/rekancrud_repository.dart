import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/apis/mstrekan/rekancrud_api.dart';
import 'package:rentcarapp/models/mstrekan/rekancrud_model.dart';

class RekanCrudRepository {

	RekanCrudAPI api = RekanCrudAPI();

	Future<ReturnDataAPI> rekanCrudTambah(RekanCrudModel record) async {
		return await api.rekanCrudTambahAPI(record);
	}
	Future<bool> rekanCrudUbah(RekanCrudModel record) async {
		return await api.rekanCrudUbahAPI(record);
	}
	Future<bool> rekanCrudHapus(String mrekanId) async {
		return await api.rekanCrudHapusAPI(mrekanId);
	}
	Future<RekanCrudModel> rekanCrudLihat(String mrekanId) async {
		return await api.rekanCrudLihatAPI(mrekanId);
	}
}

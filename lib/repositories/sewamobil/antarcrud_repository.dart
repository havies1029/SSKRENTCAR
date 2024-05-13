import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/apis/sewamobil/antarcrud_api.dart';
import 'package:rentcarapp/models/sewamobil/antarcrud_model.dart';

class AntarCrudRepository {

	AntarCrudAPI api = AntarCrudAPI();

	Future<ReturnDataAPI> antarCrudTambah(AntarCrudModel record) async {
		return await api.antarCrudTambahAPI(record);
	}
	Future<bool> antarCrudUbah(AntarCrudModel record) async {
		return await api.antarCrudUbahAPI(record);
	}
	Future<bool> antarCrudHapus(String antarmobilId) async {
		return await api.antarCrudHapusAPI(antarmobilId);
	}
	Future<AntarCrudModel> antarCrudLihat(String antarmobilId) async {
		return await api.antarCrudLihatAPI(antarmobilId);
	}
}

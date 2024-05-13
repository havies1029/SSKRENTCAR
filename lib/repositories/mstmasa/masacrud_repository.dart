import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/apis/mstmasa/masacrud_api.dart';
import 'package:rentcarapp/models/mstmasa/masacrud_model.dart';

class MasaCrudRepository {

	MasaCrudAPI api = MasaCrudAPI();

	Future<ReturnDataAPI> masaCrudTambah(MasaCrudModel record) async {
		return await api.masaCrudTambahAPI(record);
	}
	Future<bool> masaCrudUbah(MasaCrudModel record) async {
		return await api.masaCrudUbahAPI(record);
	}
	Future<bool> masaCrudHapus(String mmasaId) async {
		return await api.masaCrudHapusAPI(mmasaId);
	}
	Future<MasaCrudModel> masaCrudLihat(String mmasaId) async {
		return await api.masaCrudLihatAPI(mmasaId);
	}
}

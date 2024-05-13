import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/apis/mstharga/hargacrud_api.dart';
import 'package:rentcarapp/models/mstharga/hargacrud_model.dart';

class HargaCrudRepository {

	HargaCrudAPI api = HargaCrudAPI();

	Future<ReturnDataAPI> hargaCrudTambah(HargaCrudModel record) async {
		return await api.hargaCrudTambahAPI(record);
	}
	Future<bool> hargaCrudUbah(HargaCrudModel record) async {
		return await api.hargaCrudUbahAPI(record);
	}
	Future<bool> hargaCrudHapus(String mhargaId) async {
		return await api.hargaCrudHapusAPI(mhargaId);
	}
	Future<HargaCrudModel> hargaCrudLihat(String mhargaId) async {
		return await api.hargaCrudLihatAPI(mhargaId);
	}
}

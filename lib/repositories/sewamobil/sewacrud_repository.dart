import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/apis/sewamobil/sewacrud_api.dart';
import 'package:rentcarapp/models/sewamobil/sewacrud_model.dart';

class SewaCrudRepository {

	SewaCrudAPI api = SewaCrudAPI();

	Future<ReturnDataAPI> sewaCrudTambah(SewaCrudModel record) async {
		return await api.sewaCrudTambahAPI(record);
	}
	Future<bool> sewaCrudUbah(SewaCrudModel record) async {
		return await api.sewaCrudUbahAPI(record);
	}
	Future<bool> sewaCrudHapus(String sewa1Id) async {
		return await api.sewaCrudHapusAPI(sewa1Id);
	}
	Future<SewaCrudModel> sewaCrudLihat(String sewa1Id) async {
		return await api.sewaCrudLihatAPI(sewa1Id);
	}
}

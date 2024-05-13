import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/apis/mstmobil/mobilcrud_api.dart';
import 'package:rentcarapp/models/mstmobil/mobilcrud_model.dart';

class MobilCrudRepository {

	MobilCrudAPI api = MobilCrudAPI();

	Future<ReturnDataAPI> mobilCrudTambah(MobilCrudModel record) async {
		return await api.mobilCrudTambahAPI(record);
	}
	Future<bool> mobilCrudUbah(MobilCrudModel record) async {
		return await api.mobilCrudUbahAPI(record);
	}
	Future<bool> mobilCrudHapus(String mmobilId) async {
		return await api.mobilCrudHapusAPI(mmobilId);
	}
	Future<MobilCrudModel> mobilCrudLihat(String mmobilId) async {
		return await api.mobilCrudLihatAPI(mmobilId);
	}
}

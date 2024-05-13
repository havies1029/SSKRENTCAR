import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/apis/mstmerk/merkcrud_api.dart';
import 'package:rentcarapp/models/mstmerk/merkcrud_model.dart';

class MerkCrudRepository {

	MerkCrudAPI api = MerkCrudAPI();

	Future<ReturnDataAPI> merkCrudTambah(MerkCrudModel record) async {
		return await api.merkCrudTambahAPI(record);
	}
	Future<bool> merkCrudUbah(MerkCrudModel record) async {
		return await api.merkCrudUbahAPI(record);
	}
	Future<bool> merkCrudHapus(String mmerkId) async {
		return await api.merkCrudHapusAPI(mmerkId);
	}
	Future<MerkCrudModel> merkCrudLihat(String mmerkId) async {
		return await api.merkCrudLihatAPI(mmerkId);
	}
}

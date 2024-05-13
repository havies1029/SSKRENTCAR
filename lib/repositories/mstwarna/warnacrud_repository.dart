import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/apis/mstwarna/warnacrud_api.dart';
import 'package:rentcarapp/models/mstwarna/warnacrud_model.dart';

class WarnaCrudRepository {

	WarnaCrudAPI api = WarnaCrudAPI();

	Future<ReturnDataAPI> warnaCrudTambah(WarnaCrudModel record) async {
		return await api.warnaCrudTambahAPI(record);
	}
	Future<bool> warnaCrudUbah(WarnaCrudModel record) async {
		return await api.warnaCrudUbahAPI(record);
	}
	Future<bool> warnaCrudHapus(String mwarnaId) async {
		return await api.warnaCrudHapusAPI(mwarnaId);
	}
	Future<WarnaCrudModel> warnaCrudLihat(String mwarnaId) async {
		return await api.warnaCrudLihatAPI(mwarnaId);
	}
}

import 'package:rentcarapp/apis/mstwarna/warnacari_api.dart';
import 'package:rentcarapp/models/mstwarna/warnacari_model.dart';

class WarnaCariRepository {

	Future<List<WarnaCariModel>> getWarnaCari(String searchText, int hal) async {
		WarnaCariAPI api = WarnaCariAPI();
		return await api.getWarnaCariAPI(searchText, hal);
	}
}

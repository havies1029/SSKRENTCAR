import 'package:rentcarapp/apis/mstharga/hargacari_api.dart';
import 'package:rentcarapp/models/mstharga/hargacari_model.dart';

class HargaCariRepository {

	Future<List<HargaCariModel>> getHargaCari(String searchText, int hal) async {
		HargaCariAPI api = HargaCariAPI();
		return await api.getHargaCariAPI(searchText, hal);
	}
}

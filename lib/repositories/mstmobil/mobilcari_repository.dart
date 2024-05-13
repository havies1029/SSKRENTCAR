import 'package:rentcarapp/apis/mstmobil/mobilcari_api.dart';
import 'package:rentcarapp/models/mstmobil/mobilcari_model.dart';

class MobilCariRepository {

	Future<List<MobilCariModel>> getMobilCari(String searchText, int hal) async {
		MobilCariAPI api = MobilCariAPI();
		return await api.getMobilCariAPI(searchText, hal);
	}
}

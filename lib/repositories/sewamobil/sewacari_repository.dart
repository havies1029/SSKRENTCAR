import 'package:rentcarapp/apis/sewamobil/sewacari_api.dart';
import 'package:rentcarapp/models/sewamobil/sewacari_model.dart';

class SewaCariRepository {

	Future<List<SewaCariModel>> getSewaCari(String searchText, int hal) async {
		SewaCariAPI api = SewaCariAPI();
		return await api.getSewaCariAPI(searchText, hal);
	}
}

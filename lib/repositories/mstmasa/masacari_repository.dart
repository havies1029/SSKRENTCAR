import 'package:rentcarapp/apis/mstmasa/masacari_api.dart';
import 'package:rentcarapp/models/mstmasa/masacari_model.dart';

class MasaCariRepository {

	Future<List<MasaCariModel>> getMasaCari(String searchText, int hal) async {
		MasaCariAPI api = MasaCariAPI();
		return await api.getMasaCariAPI(searchText, hal);
	}
}

import 'package:rentcarapp/apis/msttipe/tipecari_api.dart';
import 'package:rentcarapp/models/msttipe/tipecari_model.dart';

class TipeCariRepository {

	Future<List<TipeCariModel>> getTipeCari(String searchText, int hal) async {
		TipeCariAPI api = TipeCariAPI();
		return await api.getTipeCariAPI(searchText, hal);
	}
}

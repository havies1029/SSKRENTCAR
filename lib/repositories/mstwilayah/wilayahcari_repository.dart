import 'package:rentcarapp/apis/mstwilayah/wilayahcari_api.dart';
import 'package:rentcarapp/models/mstwilayah/wilayahcari_model.dart';

class WilayahCariRepository {

	Future<List<WilayahCariModel>> getWilayahCari(String searchText, int hal) async {
		WilayahCariAPI api = WilayahCariAPI();
		return await api.getWilayahCariAPI(searchText, hal);
	}
}

import 'package:rentcarapp/apis/mstrekan/rekancari_api.dart';
import 'package:rentcarapp/models/mstrekan/rekancari_model.dart';

class RekanCariRepository {

	Future<List<RekanCariModel>> getRekanCari(String rekanTypeId, String searchText, int hal) async {
		RekanCariAPI api = RekanCariAPI();
		return await api.getRekanCariAPI(rekanTypeId, searchText, hal);
	}
}

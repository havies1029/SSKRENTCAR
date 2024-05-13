import 'package:rentcarapp/apis/msttitle/titlecari_api.dart';
import 'package:rentcarapp/models/msttitle/titlecari_model.dart';

class TitleCariRepository {

	Future<List<TitleCariModel>> getTitleCari(String searchText, int hal) async {
		TitleCariAPI api = TitleCariAPI();
		return await api.getTitleCariAPI(searchText, hal);
	}
}

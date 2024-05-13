import 'package:rentcarapp/apis/mstmerk/merkcari_api.dart';
import 'package:rentcarapp/models/mstmerk/merkcari_model.dart';

class MerkCariRepository {

	Future<List<MerkCariModel>> getMerkCari(String searchText, int hal) async {
		return await getMerkCariAPI(searchText, hal);
	}
	
}

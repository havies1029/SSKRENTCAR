import 'package:rentcarapp/apis/combobox/combomerk_api.dart';
import 'package:rentcarapp/models/combobox/combomerk_model.dart';

class ComboMerkRepository {

	Future<List<ComboMerkModel>> getComboMerk(String filter) async {
		return await getComboMerkAPI(filter);
	}
}

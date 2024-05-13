import 'package:rentcarapp/apis/combobox/combotipe_api.dart';
import 'package:rentcarapp/models/combobox/combotipe_model.dart';

class ComboTipeRepository {

	Future<List<ComboTipeModel>> getComboTipe(String filter) async {
		ComboTipeAPI api = ComboTipeAPI();
		return await api.getComboTipeAPI(filter);
	}
}

import 'package:rentcarapp/apis/combobox/combowarna_api.dart';
import 'package:rentcarapp/models/combobox/combowarna_model.dart';

class ComboWarnaRepository {

	Future<List<ComboWarnaModel>> getComboWarna(String filter) async {
		return await getComboWarnaAPI(filter);
	}
}

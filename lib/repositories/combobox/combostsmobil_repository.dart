import 'package:rentcarapp/apis/combobox/combostsmobil_api.dart';
import 'package:rentcarapp/models/combobox/combostsmobil_model.dart';

class ComboStsmobilRepository {

	Future<List<ComboStsmobilModel>> getComboStsmobil(String filter) async {
		ComboStsmobilAPI api = ComboStsmobilAPI();
		return await api.getComboStsmobilAPI(filter);
	}
}

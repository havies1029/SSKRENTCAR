import 'package:rentcarapp/apis/combobox/combomobil_api.dart';
import 'package:rentcarapp/models/combobox/combomobil_model.dart';

class ComboMobilRepository {

	Future<List<ComboMobilModel>> getComboMobil(String filter) async {
		ComboMobilAPI api = ComboMobilAPI();
		return await api.getComboMobilAPI(filter);
	}
}

import 'package:rentcarapp/apis/combobox/combosupir_api.dart';
import 'package:rentcarapp/models/combobox/combosupir_model.dart';

class ComboSupirRepository {

	Future<List<ComboSupirModel>> getComboSupir() async {
		ComboSupirAPI api = ComboSupirAPI();
		return await api.getComboSupirAPI();
	}
}

import 'package:rentcarapp/apis/combobox/combomasasewa_api.dart';
import 'package:rentcarapp/models/combobox/combomasasewa_model.dart';

class ComboMasasewaRepository {

	Future<List<ComboMasasewaModel>> getComboMasasewa() async {
		ComboMasasewaAPI api = ComboMasasewaAPI();
		return await api.getComboMasasewaAPI();
	}

  Future<ComboMasasewaModel> getInitValueComboMasaSewa() async {
		ComboMasasewaAPI api = ComboMasasewaAPI();
		return await api.getInitValueComboMasaSewaAPI();
	}
}

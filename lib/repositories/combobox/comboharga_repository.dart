import 'package:rentcarapp/apis/combobox/comboharga_api.dart';
import 'package:rentcarapp/models/combobox/comboharga_model.dart';

class ComboHargaRepository {

	Future<List<ComboHargaModel>> getComboHarga(String filter) async {
		return await getComboHargaAPI(filter);
	}
}

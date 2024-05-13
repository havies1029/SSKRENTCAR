import 'package:rentcarapp/apis/combobox/combojabatan_api.dart';
import 'package:rentcarapp/models/combobox/combojabatan_model.dart';

class ComboJabatanRepository {

	Future<List<ComboJabatanModel>> getComboJabatan(String filter) async {
		return await getComboJabatanAPI(filter);
	}
}

import 'package:rentcarapp/apis/combobox/combotitle_api.dart';
import 'package:rentcarapp/models/combobox/combotitle_model.dart';

class ComboTitleRepository {

	Future<List<ComboTitleModel>> getComboTitle(String filter) async {
		return await getComboTitleAPI(filter);
	}
}

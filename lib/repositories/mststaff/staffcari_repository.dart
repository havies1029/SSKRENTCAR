import 'package:rentcarapp/apis/mststaff/staffcari_api.dart';
import 'package:rentcarapp/models/mststaff/staffcari_model.dart';

class StaffCariRepository {

	Future<List<StaffCariModel>> getStaffCari(String searchText, int hal) async {
		StaffCariAPI api = StaffCariAPI();
		return await api.getStaffCariAPI(searchText, hal);
	}
}

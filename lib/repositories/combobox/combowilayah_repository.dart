import 'package:rentcarapp/apis/combobox/combowilayah_api.dart';
import 'package:rentcarapp/models/combobox/combowilayah_model.dart';

class ComboWilayahRepository {

  Future<List<ComboWilayahModel>> getComboWilayah() async {
    ComboWilayahAPI api = ComboWilayahAPI();
    return await api.getComboWilayahAPI();
  }

  Future<ComboWilayahModel> getInitValueComboWilayah() async {
    ComboWilayahAPI api = ComboWilayahAPI();
    return await api.getInitValueComboWilayahAPI();
  }

}

import 'package:rentcarapp/models/combobox/combosupir_model.dart';

class AntarCrudModel {
	String alamat1;
	String alamat2;
	String antarmobilId;
	double biaya;
	String keterangan;
	String picNama;
	String picTelp;
	String? supirId;
	ComboSupirModel? comboSupir;

	AntarCrudModel({required this.alamat1, required this.alamat2, 
		required this.antarmobilId, required this.biaya, 
		required this.keterangan, required this.picNama, 
		required this.picTelp, this.supirId, this.comboSupir});

	factory AntarCrudModel.fromJson(Map<String, dynamic> data) {
		ComboSupirModel? comboSupir;
		if (data['comboSupir'] != null) {
			comboSupir = ComboSupirModel.fromJson(data['comboSupir']);
		}

		return AntarCrudModel(
			alamat1: data['alamat1']??'',
			alamat2: data['alamat2']??'',
			antarmobilId: data['antarmobilId']??'',
			biaya: double.tryParse(data['biaya'].toString())??0,
			keterangan: data['keterangan']??'',
			picNama: data['picNama']??'',
			picTelp: data['picTelp']??'',
			supirId: data['supirId']??'',
			comboSupir: comboSupir
		);

	}

	Map<String, dynamic> toJson() =>
		{'alamat1': alamat1,
		'alamat2': alamat2,
		'antarmobilId': antarmobilId,
		'biaya': biaya.toString(),
		'keterangan': keterangan,
		'picNama': picNama,
		'picTelp': picTelp,
		'supirId': supirId,
		'comboSupir': comboSupir?.toJson()};

}

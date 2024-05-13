import 'package:equatable/equatable.dart';

class ComboMasasewaModel extends Equatable {
	final String mmasaId;
	final String masaNama;
	final String satuan;

	const ComboMasasewaModel({this.mmasaId='', this.masaNama='', this.satuan=""});

	factory ComboMasasewaModel.fromJson(Map<String, dynamic> data) =>
		ComboMasasewaModel(
			mmasaId: data['mmasaId'],
			masaNama: data['masaNama'],
			satuan: data['satuan']
		);

	Map<String, dynamic> toJson() =>
		{'mmasaId': mmasaId,
		'masaNama': masaNama,
		'satuan': satuan};

	@override
	List<Object> get props => [mmasaId, masaNama, satuan];
}

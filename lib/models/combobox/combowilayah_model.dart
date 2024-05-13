import 'package:equatable/equatable.dart';

class ComboWilayahModel extends Equatable {
	final String mwilayahId;
	final String wilayahNama;

	const ComboWilayahModel({this.mwilayahId='', this.wilayahNama=''});

	factory ComboWilayahModel.fromJson(Map<String, dynamic> data) =>
		ComboWilayahModel(
			mwilayahId: data['mwilayahId'],
			wilayahNama: data['wilayahNama']
		);

	Map<String, dynamic> toJson() =>
		{'mwilayahId': mwilayahId,
		'wilayahNama': wilayahNama};

	@override
	List<Object> get props => [mwilayahId, wilayahNama];
}

import 'package:equatable/equatable.dart';

class ComboSupirModel extends Equatable {
	final String mstaffId;
	final String staffNama;

	const ComboSupirModel({this.mstaffId='', this.staffNama=''});

	factory ComboSupirModel.fromJson(Map<String, dynamic> data) =>
		ComboSupirModel(
			mstaffId: data['mstaffId'],
			staffNama: data['staffNama'],
		);

	Map<String, dynamic> toJson() =>
		{'mstaffId': mstaffId,
		'staffNama': staffNama,};

	@override
	List<Object> get props => [mstaffId, staffNama];
}

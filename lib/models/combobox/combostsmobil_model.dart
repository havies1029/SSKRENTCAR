import 'package:equatable/equatable.dart';

class ComboStsmobilModel extends Equatable {
	final String mstsmobilId;
	final String statusNama;

	const ComboStsmobilModel({this.mstsmobilId='', this.statusNama=''});

	factory ComboStsmobilModel.fromJson(Map<String, dynamic> data) =>
		ComboStsmobilModel(
			mstsmobilId: data['mstsmobilId'],
			statusNama: data['statusNama']
		);

	Map<String, dynamic> toJson() =>
		{'mstsmobilId': mstsmobilId,
		'statusNama': statusNama};

	@override
	List<Object> get props => [mstsmobilId, statusNama];
}

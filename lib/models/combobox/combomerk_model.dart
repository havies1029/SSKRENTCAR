import 'package:equatable/equatable.dart';

class ComboMerkModel extends Equatable {
	final String merkNama;
	final String mmerkId;

	const ComboMerkModel({this.merkNama='', this.mmerkId=''});

	factory ComboMerkModel.fromJson(Map<String, dynamic> data) =>
		ComboMerkModel(
			merkNama: data['merkNama'],
			mmerkId: data['mmerkId']
		);

	Map<String, dynamic> toJson() =>
		{'merkNama': merkNama,
		'mmerkId': mmerkId};

	@override
	List<Object> get props => [merkNama, mmerkId];
}

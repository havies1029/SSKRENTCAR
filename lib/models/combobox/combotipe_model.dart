import 'package:equatable/equatable.dart';

class ComboTipeModel extends Equatable {	
	final String mtipeId;
	final String tipeNama;

	const ComboTipeModel({this.mtipeId='', this.tipeNama=''});

	factory ComboTipeModel.fromJson(Map<String, dynamic> data) =>
		ComboTipeModel(
			mtipeId: data['mtipeId'],
			tipeNama: data['tipeNama']
		);

	Map<String, dynamic> toJson() =>
		{
		'mtipeId': mtipeId,
		'tipeNama': tipeNama};

	@override
	List<Object> get props => [mtipeId, tipeNama];
}

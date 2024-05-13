import 'package:equatable/equatable.dart';

class ComboHargaModel extends Equatable {
	final double harga;
	final String mhargaId;
	final String hargaDesc;

	const ComboHargaModel({this.harga=0, this.mhargaId='', this.hargaDesc = ''});

	factory ComboHargaModel.fromJson(Map<String, dynamic> data) =>
		ComboHargaModel(
			harga: double.parse(data['harga'].toString()),
			mhargaId: data['mhargaId'],
			hargaDesc: data['hargaDesc']
		);

	Map<String, dynamic> toJson() =>
		{'harga': harga.toString(),
		'mhargaId': mhargaId,
		'hargaDesc': hargaDesc};

	@override
	List<Object> get props => [harga, mhargaId, hargaDesc];
}

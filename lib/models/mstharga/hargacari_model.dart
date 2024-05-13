class HargaCariModel {
	String curr;
	double harga;
	String mhargaId;

	HargaCariModel({required this.curr, required this.harga, 
		required this.mhargaId});

	factory HargaCariModel.fromJson(Map<String, dynamic> data) =>
		HargaCariModel(
			curr: data['curr'],
			harga: double.parse(data['harga'].toString()),
			mhargaId: data['mhargaId']
		);

	Map<String, dynamic> toJson() =>
		{'curr': curr,
		'harga': harga.toString(),
		'mhargaId': mhargaId};

}

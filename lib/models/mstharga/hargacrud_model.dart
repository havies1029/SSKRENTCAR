class HargaCrudModel {
	String? curr;
	double harga;
	String mhargaId;

	HargaCrudModel({this.curr, required this.harga, 
		required this.mhargaId});

	factory HargaCrudModel.fromJson(Map<String, dynamic> data) =>
		HargaCrudModel(
			curr: data['curr'],
			harga: double.parse(data['harga'].toString()),
			mhargaId: data['mhargaId']
		);

	Map<String, dynamic> toJson() =>
		{'curr': curr,
		'harga': harga.toString(),
		'mhargaId': mhargaId};

}

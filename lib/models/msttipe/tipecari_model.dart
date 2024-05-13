class TipeCariModel {
	String mmerkId;
	String? merkNama;
	String mtipeId;
	String tipeNama;

	TipeCariModel({required this.mmerkId, this.merkNama, required this.mtipeId, 
		required this.tipeNama});

	factory TipeCariModel.fromJson(Map<String, dynamic> data) =>
		TipeCariModel(
			mmerkId: data['mmerkId'],
			merkNama: data['merkNama'],
			mtipeId: data['mtipeId'],
			tipeNama: data['tipeNama']
		);

	Map<String, dynamic> toJson() =>
		{'mmerkId': mmerkId,
		'merkNama': merkNama,
		'mtipeId': mtipeId,
		'tipeNama': tipeNama};

}

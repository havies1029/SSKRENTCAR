class TipeCrudModel {
	String mmerkId;
	String? merkNama;
	String mtipeId;
	String tipeNama;

	TipeCrudModel({required this.mmerkId, this.merkNama, required this.mtipeId, 
		required this.tipeNama});

	factory TipeCrudModel.fromJson(Map<String, dynamic> data) =>
		TipeCrudModel(
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

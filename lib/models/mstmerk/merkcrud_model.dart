class MerkCrudModel {
	String merkNama;
	String mmerkId;

	MerkCrudModel({required this.merkNama, required this.mmerkId});

	factory MerkCrudModel.fromJson(Map<String, dynamic> data) =>
		MerkCrudModel(
			merkNama: data['merkNama'],
			mmerkId: data['mmerkId']
		);

	Map<String, dynamic> toJson() =>
		{'merkNama': merkNama,
		'mmerkId': mmerkId};

}

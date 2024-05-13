class MerkCariModel {
	String merkNama;
	String mmerkId;

	MerkCariModel({required this.merkNama, required this.mmerkId});

	factory MerkCariModel.fromJson(Map<String, dynamic> data) =>
		MerkCariModel(
			merkNama: data['merkNama']??"",
			mmerkId: data['mmerkId']??""
		);

	Map<String, dynamic> toJson() =>
		{'merkNama': merkNama,
		'mmerkId': mmerkId};

}

class WilayahCariModel {
	String mwilayahId;
	String wilayahNama;

	WilayahCariModel({required this.mwilayahId, required this.wilayahNama});

	factory WilayahCariModel.fromJson(Map<String, dynamic> data) =>
		WilayahCariModel(
			mwilayahId: data['mwilayahId'],
			wilayahNama: data['wilayahNama']
		);

	Map<String, dynamic> toJson() =>
		{'mwilayahId': mwilayahId,
		'wilayahNama': wilayahNama};

}
